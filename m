From: Enrico <enrico_tux-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: Acer Travelmate 427LC & ACPI....
Date: Thu, 16 Oct 2003 22:05:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200310162205.17499.enrico_tux@libero.it>
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

Hi everyone, i'm Enry from Italy...

I've an Acer Travelmate 427LC, i run SuSE linux 8.2, and my acpi has some 
problems...

In fact it can't detect thermal and fan sensors... and also if i unplug the ac 
adapter it says that there are 0 seconds of power remaining...

Is there a way to make it work correctly?

In my log i found:

Oct 15 22:42:24 localhost kernel:     ACPI-0165: *** Warning: The ACPI AML in 
your computer contains errors, please nag the manufacturer to correct it.
Oct 15 22:42:24 localhost kernel:     ACPI-0168: *** Warning: Allowing relaxed 
access to fields; turn on CONFIG_ACPI_DEBUG for details.

when i do acpi -V:
     Battery 1: unknown, 100%
No support for device type: thermal
  AC Adapter 1: on-line

Thanks for your attention..


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
