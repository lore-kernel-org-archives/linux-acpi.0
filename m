From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: ACPI issues - suspend-to-ram and processor speed
Date: Fri, 28 May 2004 10:24:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040528082426.GD1808@elf.ucw.cz>
References: <200405180213.34603.andre@eisenbach.com> <20040523122942.GH5215@openzaurus.ucw.cz> <200405280117.51602.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200405280117.51602.andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > I also tried to suspend to disk using swsusp. That corrupted my swap
> > > partition and didn't resume.
> >
> > Read swsusp.txt, power/tricks.txt.
> 
> Thank you, thank you, thank you.
> RTFM seems to have done the trick.
> 
> After reading the two files suggested, I recompiled my kernel (2.6.7-rc1-mm1) 
> with CONFIG_PM_DISK and _without_ CONFIG_PREEMPT and for the first time ever 
> got software suspend to work!

Actually, stay away from CONFIG_PM_DISK, CONFIG_SOFTWARE_SUSPEND
should work better.


> My notebook just got a whole lot more usable!
> Thanks ACPI devs!
> 
> Now, if only suspend-to-ram would work.
> 
> How could I debug this problem?

Well, it involves assembly, black magic and soldering iron. Still
interested?
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
