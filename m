From: ezra peisach <epeisach-AW32GngNFaTp5eoAjl1PXg@public.gmane.org>
Subject: DELL inspiron 8200 fails to restore console after S1/S3
Date: Tue, 6 Jan 2004 16:10:43 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401062110.QAA188725@med-xtal.bu.edu>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Testing w/ the 2.6.0 kernel and the 12/03 patches to acpi, the following
happens w/ the stock DSDT A10 on an inspiron 8200:

The display is a radeon 9000....

The following occurs if X is not running. (init run level 3)

If one moves to power state: S1 - the screen does not go blank (text
remains) When power is restored, the machine accepts keyboard input,
but the screen then goes blank.

If one move to power state S3 - screen goes blank. Power restoration
flashes the screen then remains blank.

When X is running - sometimes the screen is restored, sometimes
not. I.e. sometimes it comes out w/ garbage.

Based on the bugzilla.kernel.org - bug 605 - discusses backlight not
going off.  There is a comment that ACPI may not be responsible for
this - the gfx driver is.

When X is not running - there isn't a gfx driver - except the kernel.
Do we need an OS specific handler to receive notifications of 

\_SB.PCI0.AGP.VID

and do the right thing?

Perhaps the agp driver is the proper place.... I suspect it may be a radeon 
specific thing...

For the X case - maybe it needs to observe the acpi events - not just apm.

Anyone have any ideas?

Ezra



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
