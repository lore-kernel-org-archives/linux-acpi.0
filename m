From: reason-ss4n/k5RZhaUArH+D2fLrA@public.gmane.org (Ilya Bagrak)
Subject: radeon display is blank after resume from S3
Date: Sat, 21 Feb 2004 15:50:35 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <34137.68.19.7.134.1077396635.squirrel@webmail.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi all,

My set-up is:

Linux 2.6.3-mm2 on Fujitsu E7110 laptop w/
1. radeon mobility 7500 card
2. intel 845 pci bridge (i think)

The basic problem is that after resuming from S3, the screen remains
completely blank.  All other devices seem to return to normal, and I can
communicate with the laptop over the network.  I have experienced this
same problem since early 2.6.0 test kernels, and I've been actively
looking for a solution ever since.

There are few disparate resources here and there like patched radeon
drivers, kernel patches, suspend/resume scripts, etc. that are supposed to
help get this working. I tried them all, and none offer a complete
solution.

I'd very much like to hear from people that have the same card and chipset
and who have managed to revive it after a suspend.  Part of the problem is
that I am not sure what stands in the way of getting this to work.  I am
willing to use the card in some crippled mode, just so the suspend feature
is working properly.  I've tried suspending from X (runlevel 5) and
console (runlevel 3) without much luck.  I've tried vesafb, and various
video modes, but the behavior never changes.

If somebody is aware of some helpful resources or documentation (I've done
my googling already), or personal experiences, I would appreciate your
help very much.

Thank you,

Ilya




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
