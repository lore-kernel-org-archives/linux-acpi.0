From: Adam Kessel <adam-/J5p37YCQWYytDrLOV7HaA@public.gmane.org>
Subject: ACPI Poweroff fails on HP OmniBook 500
Date: Tue, 28 Oct 2003 21:06:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031029020636.GF29465@bostoncoop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I posted this recently to lkml, but got no response, so I thought I would
report it here as well.[1]

In 2.4.22-rc2, ACPI poweroff worked fine on the HP OmniBook.

Since 2.4.22, all the way up to 2.4.23-pre8, the system fails to
shutdown--the process gets to "power off" and hangs there. It is
necessary to do a hard shut down to turn the system off.

There is no problem with rebooting.

Apparently this effects a number of HP laptops, although I have only
verified it on the OmniBook 500.[2]

This problem is not present in 2.6.0-test9.

I am using force=acpi as required since I have an older BIOS.  Apparently
the problem occurs in OmniBook laptops they have newer BIOSes as well.

I expect this is related to the Sony VAIO problem discussed this month on
this list as well.[3]

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0310.1/1625.html 
[2] http://zurich.ai.mit.edu/pipermail/omnibook/2003-September/002805.html
[3] http://article.gmane.org/gmane.linux.acpi.devel/4770


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
