From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Stall semantics
Date: Wed, 1 Oct 2003 19:55:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031001185524.GX24824@parcelfarce.linux.theplanet.co.uk>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3DAF@orsmsx405.jf.intel.com> <20031001093943.J85056@root.org> <20031001171657.GW24824@parcelfarce.linux.theplanet.co.uk> <20031001101854.J85056@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031001101854.J85056-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 01, 2003 at 10:27:04AM -0700, Nate Lawson wrote:
> You're assuming the AML mistake is made both ways.  If it is uniformly
> made one way, it's easy to work around correctly.

Actually, I assume that AML writers are idiots who can't read the spec.
They almost certainly want to stall for 2 seconds.  The fact that they
can't doesn't stop them trying.

> > I think the current ACPI behaviour is probably adequate -- accommodate
> > incopetent BIOS writers up to a point, then sleep, and damn them anyway.
> 
> It damns us OS vendors a different way in that we get unacceptably long
> idle spin loops on some machines.  Spinning for 1000 us is not correct any
> way you interpret the standard.

You have a machine which isn't able to stall for 1 millisecond?
Many drivers do stall for that much, and more.  Grepping the linux-2.6
tree shows a lot of drivers calling mdelay() -- tulip, e1000, symbios,
aic7xxx, radeon, mach64, ohci, uhci, ide, ...

One gem..
./drivers/ide/pci/pdc202xx_new.c:       mdelay(2000);   /* 2 seconds ?! */

I don't think a 1ms stall is exceptional, or even remarkable.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
