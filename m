From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: S3 won't resume correctly
Date: Tue, 18 Feb 2003 23:49:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030218224905.GB8829@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
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

Hi,
I'm using an Asus L3800C laptop, which itself is quite ACPI-compatible
(well, all is ok except for trivial things like C3 not supported for the
P4-M processor). I've been testing the S3 status since 2.5.59, up to
2.5.61. I use XFS for my root filesystem, which makes it inconvenient to
suspend (at least for 2.5.x, there are appropriate patches for 2.4.20), but
the problem I experience is not fs-related, i guess.

The system suspends correctly (though issuing some warnings about pagebufd
not stopping, which as I told is XFS specific), even the power LED blinks
accordingly to the manual, indicating S3. However, upon resume neither the
display, nor the keyboard works. Appending acpi_sleep=s3_bios fixes the
display, but the keyboard still won't respond. I am able to ssh to the box
after resume and everything except the keyboard seems to work fine then.

System details: P4-M 1.7 GHz, 256 MB RAM, i845 (Brookdale) chipset, ATI M7
(Radeon 7500 Mobility) video, RTL-8139 NIC, other usual notebook stuff.
I attach the log of the suspend event (though I doubt it will be of any
use), lspci -v output. My disassembled dsdt is here:
hell.org.pl/~sziwan/asus/dsdt.dsl
I'll be happy to provide further info if needed. Thanks in advance,
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
