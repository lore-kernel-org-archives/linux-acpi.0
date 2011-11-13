From: =?ISO-8859-2?Q?Pawe=B3_Staszewski?= <pstaszewski@itcare.pl>
Subject: Intel Xeon 5649 2.53GHz Turbo problem
Date: Sun, 13 Nov 2011 21:01:53 +0100
Message-ID: <4EC02231.9030501@itcare.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010609050809050109060407"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.iq.pl ([86.111.241.19]:47265 "EHLO smtp.iq.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550Ab1KMUIk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Nov 2011 15:08:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010609050809050109060407
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello


I have question
How can I check if Turbo Boost is working with Xeon E5649

I have turbostats that shows:
pk cr CPU    %c0  GHz  TSC    %c1    %c3    %c6  %pc3  %pc6
            56.12 2.67 2.53  43.88   0.00   0.00  0.00  0.00
0   0   0  17.79 2.67 2.53  82.21   0.00   0.00  0.00  0.00
0   0  12  17.81 2.67 2.53  82.19   0.00   0.00  0.00  0.00
0   1   2  13.04 2.67 2.53  86.96   0.00   0.00  0.00  0.00
0   1  14  12.73 2.67 2.53  87.27   0.00   0.00  0.00  0.00
0   2   4  13.70 2.67 2.53  86.30   0.00   0.00  0.00  0.00
0   2  16  13.39 2.67 2.53  86.61   0.00   0.00  0.00  0.00
0   8   6  98.81 2.67 2.53   1.19   0.00   0.00  0.00  0.00
0   8  18  98.74 2.67 2.53   1.26   0.00   0.00  0.00  0.00
0   9   8  98.60 2.67 2.53   1.40   0.00   0.00  0.00  0.00
0   9  20  97.47 2.67 2.53   2.53   0.00   0.00  0.00  0.00
0  10  10  98.62 2.67 2.53   1.38   0.00   0.00  0.00  0.00
0  10  22  97.19 2.67 2.53   2.81   0.00   0.00  0.00  0.00
1   0   1  13.11 2.67 2.53  86.89   0.00   0.00  0.00  0.00
1   0  13  13.11 2.67 2.53  86.89   0.00   0.00  0.00  0.00
1   1   3  15.34 2.67 2.53  84.66   0.00   0.00  0.00  0.00
1   1  15  15.09 2.67 2.53  84.91   0.00   0.00  0.00  0.00
1   2   5  13.32 2.67 2.53  86.68   0.00   0.00  0.00  0.00
1   2  17  12.77 2.67 2.53  87.23   0.00   0.00  0.00  0.00
1   8   7  98.67 2.67 2.53   1.33   0.00   0.00  0.00  0.00
1   8  19  98.67 2.67 2.53   1.33   0.00   0.00  0.00  0.00
1   9   9  98.35 2.67 2.53   1.65   0.00   0.00  0.00  0.00
1   9  21  96.92 2.67 2.53   3.08   0.00   0.00  0.00  0.00
1  10  11  98.10 2.67 2.53   1.90   0.00   0.00  0.00  0.00
1  10  23  95.56 2.67 2.53   4.44   0.00   0.00  0.00  0.00

So 2.67Ghz - but based on Intel spec max Turbo freq. for this cpu is 2.93Ghz
http://ark.intel.com/products/52581/Intel-Xeon-Processor-E5649-%2812M-Cache-2_53-GHz-5_86-GTs-Intel-QPI%29

Is there any tool that can show me good turbo stats ? or turbostat is ok 
but i have something wrong with Bios settings ? C-STATES ? pm governor ?

Thanks
Pawel


--------------010609050809050109060407
Content-Type: text/x-vcard; charset=utf-8;
 name="pstaszewski.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pstaszewski.vcf"

begin:vcard
fn;quoted-printable:Pawe=C5=82 Staszewski
n;quoted-printable:Staszewski;Pawe=C5=82
org:ITCare
adr;quoted-printable;quoted-printable;dom:;;Sikorskiego 22;Libi=C4=85=C5=BC;Ma=C5=82opolskie;32-590
title:IT Manager
tel;work:+48 32 7203681
tel;fax:+48 32 7203682
tel;cell:+48 0 609911040
url:www.itcare.pl
version:2.1
end:vcard


--------------010609050809050109060407--
