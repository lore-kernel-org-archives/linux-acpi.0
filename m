From: Ole Myren Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Subject: Re: How to debug not working S3?
Date: 18 Jul 2003 10:41:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3el0ojkgo.fsf@localhost.localdomain>
References: <200307180042.35263.malte.d@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307180042.35263.malte.d-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Malte Doersam <malte.d-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

If you have a parallel port, make a dongle with eight LEDs and trace
your way with OUTB until it hangs. 
If you don't have a parallel port, insert calls to machine_restart in
critical places and see if you ever get there.

In general, you want to get rid of any non-essential gadgets and their
drivers (usb, cdrom etc). If your screen is black on resume, you want
to check out the s3_bios and s3_mode options, or you might have to
resort to POSTing the video adapter from X.

This roadmap to get S3 working might be of help. It is for a
completely different machine, but starting with more-or-less the same
symptoms as you:

<http://mrohne.home.cern.ch/mrohne/P2120/P2120_Linux_S3.html>

Good luck, Ole


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
