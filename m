From: Jeff Hagen <jeff-ziEjmj+msWXYtjvyW6yDsg@public.gmane.org>
Subject: DSDT on Compaq Evo N610c
Date: Sat, 21 Feb 2004 11:40:19 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402211140.19142.jeff@hagen.org>
Reply-To: jeff-ziEjmj+msWXYtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello all,

I'm working on rebuilding the image for my n610c after a nasty hard drive 
failure, and I'm trying to get ACPI working again...

Last time I built my image I found a working DSDT floating around somewhere on 
the net, but now I can't seem to find one that works.

Right now I am getting this on startup, and /proc crashes anytime I plug or 
unlpug the laptop... 

<--- from dmesg --->

ACPI: AC Adapter [C19A] (on-line)
    ACPI-1120: *** Error: Method execution failed [\_SB_.C045.C059.C0E2.C13F] 
(Node c156dd60), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1120: *** Error: Method execution failed [\_SB_.C045.C059.C0E2.C14E] 
(Node c156dc60), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1120: *** Error: Method execution failed [\_SB_.C198._BTP] (Node 
c1569d40), AE_AML_UNINITIALIZED_LOCAL
ACPI: Battery Slot [C198] (battery present)
ACPI: Battery Slot [C199] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C19B]
ACPI: Lid Switch [C19C]
ACPI: Fan [C1EE] (off)
ACPI: Fan [C1EF] (off)

<--- end dmesg snip-->

This error seems to be mentioned in a previous post.

Anyone have a working modified DSDT for this hardware that they would be 
willing to e-mail me? (I know the S states probably wont work, they didnt on 
the last one I had.) 

I am using kernel 2.6.3 with acpi-20040211-2.6.3.

Thankx,
Jeff Hagen
jeff-ziEjmj+msWXYtjvyW6yDsg@public.gmane.org


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
