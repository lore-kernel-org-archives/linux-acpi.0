From: Jonathan Gold <jgold-VmQCmMdMyN0AvxtiuMwx3w@public.gmane.org>
Subject: ethernet effectively hangs machine (2.4.22+acpi)
Date: Sun, 2 Nov 2003 20:50:34 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.NEB.4.58.0311022050090.24086@panix1.panix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

i've been reading through the last month or so of this list, and
trying various searches on google for this issue, but can't find
anything. i imagine it's something fairly basic which i'm not doing,
but i don't know what that might be.

i compiled a 2.4.22 from scratch with the acpi stuff statically linked
into the kernel. i had some problems with usb for awhile, but got that
figured out. now i can boot into the acpi-enable kernel, but the
system essentially hangs when bringing up eth0 (it might timeout
eventually, but i haven't seen it do that yet). i tried manually
bringing up eth0 and assigning it a static ip, which worked, but when
i tried to ping another machine, i froze up again.

can someone possible forward me an earlier discussion of this issue. i
can't be the first.

thank you,

jon


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
