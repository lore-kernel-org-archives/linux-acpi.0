From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Fwd: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino notebook (contains agp, lapic, swsusp)]
Date: Wed, 11 Feb 2004 11:32:14 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040211113214.GB6310@redhat.com>
References: <3ACA40606221794F80A5670F0AF15F8401CBB68A@PDSMSX403.ccr.corp.intel.com> <20040211105531.GA30647@hell.org.pl> <20040211110154.GJ12634@redhat.com> <20040211112505.GE30647@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040211112505.GE30647-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>, sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 11, 2004 at 12:25:05PM +0100, Karol Kozimor wrote:
 > Thus wrote Dave Jones:
 > >  > Simple "modprobe intel-agp" will do, the system will reboot or hang when
 > >  > resuming from swsusp1/pmdisk even when AGP is not used.
 > > Hmm, some of the Intel chipset code has resume callbacks already.
 > > These _will_ get called even if AGP isn't in use.
 > 
 > Right.
 > 
 > > I'm wondering if they're doing something they shouldn't.
 > > It might even be possible that those callbacks should just do nothing
 > > if agp isn't in use.  Need to think some more on this one.
 > 
 > That's especially strange as Nigel's swsusp2 survives the suspend. Here's
 > how it looks currently on my system [1]:
 > 
 > 
 > 				pmdisk	swsusp	swsusp2
 > intel-agp not loaded		OK	OK	OK
 > intel-agp loaded, not in use	(?)	reboot	OK
 > intel-agp in use		reboot	reboot	OK
 > 
 > I haven't used pmdisk for some time, so I might be not authoritative.
 > 
 > [1] 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP
 > Bridge (rev 04)
 > 
 > I'm willing to test anything you come up with.

Take a look at drivers/char/agp/intel-agp.c around line 1427 or so
function agp_intel_resume().

Does it still hang if you just return 0 there ?

I'm guessing that will fix it. Maybe we don't quite have the
initialisation routine perfect, and reinitialising the chipset
twice causes it to hang..

		Dave



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
