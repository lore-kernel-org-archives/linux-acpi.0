From: Alberto Ornaghi <alor-G/4Acn03FKk@public.gmane.org>
Subject: [2.5.50] ACPI problems on presario 705
Date: Sat, 30 Nov 2002 16:05:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.1.5.2.20021130160527.028ee1a0@wheresmymailserver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


If I enable the ACPI subsystem it doesn't boot at all.
no log in /var/log/messages, only a call trace on the video, but it is too 
long and it scroll down too fast so I can only see few line.

the call trace ends with this message:

Code: 8b 00 0f 0d 00 81 7c 24 0c ac 00 45 c0 0f 85 7a ff ff ff 9c
  <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

sorry, my laptop doesn't have a serial port, so I cannot dump the call 
trace...
anyone who can ? anyone experiencing the same problem ?

passing the acpi=off option the kernel boots normally

I'm running acpi 20021122 under 2.4.20 and it works like a charme...

are there substantial difference between the 2.4. and 2.5. version of ACPI ?

bye

    --==> ALoR <==---------------------- -  -   -

There are only 10 types of people in this world...
those who understand binary, and those who don't.



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
