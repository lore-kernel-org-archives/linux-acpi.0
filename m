From: Dominik Bartenstein <dom-K271P2BsTd0@public.gmane.org>
Subject: Thinkpad A31
Date: Tue, 15 Apr 2003 23:08:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304152308.33510.dom@wahuu.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

News from the Thinkpad A31 front:

In the meanwhile IBM has released BIOS version 1.06 for the A31 which fixes 
the broken ECDT table. Yay! I am currently running linux-2.4.21-pre7 with the 
latest acpi-patch. I have also commented out the "if (ec_ecdt && ec_ecdt->uid 
== uid) {...}"   block in acpi_ec_add() of ec.c.
ACPI seems to be pretty usable on the A31 now.

I am experiencing exactly the same issues as Jayan Krishnaswami does with his 
T23. 
- /proc/acpi/fan/ is empty: The fan does not stop which makes the battery only 
last for 90 minutes.
- /proc/acpi/processor/CPU/performance: *P0:                  0 MHz, 0 mW, 500 
uS P1:                  0 MHz, 0 mW, 500 uS

Greetings,
Dom


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
