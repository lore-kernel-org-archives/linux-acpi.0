From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: TESTING 2.6.0-test1 S3
Date: Wed, 23 Jul 2003 18:31:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030723163122.GB21492@atrey.karlin.mff.cuni.cz>
References: <20030718163905.5AE2F168B09@smtp-out1.iol.cz> <200307231333.59853.mflt1@micrologica.com.hk> <20030723122412.GA18878@atrey.karlin.mff.cuni.cz> <200307232311.48648.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200307232311.48648.mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > What is L2?
> 
> Toshiba Libretto L2, TM5600 600MHz, 256MB, legacy free, reasonable DSDT.
> 
> The hard disk seems to resume fine with 2.6-test1. (Needs more testing)
> 
> Other than potential harddisk problems, the last problem of "unknown origin" 
> for getting 2.6/S3  to work is that BIOS reports a resume failure every 
> 5 suspends or so. 
> 
> May have seen an oops flash by before it switches off on entering S3, 
> but it could also have been the e100 badness trace. 
> 
> I suspect it is an ACPI related problem in hwsleep.c, by which the suspend
> mechanism is not properly setup. Maybe timing, missing setting, incompatibility...
> 
> Will have to look at the spec and test it more, and expect to resolve this in 
> the end.
> 
> There are right now more complaints about shared PCI interrupts, which is
> a major nuisance aggravated by silly DSDT's sometimes assigning 5 inputs to
> the same level. 
> 
> Reproduced this on the L2 with IRQ5 for Yenta and USB causing hangs
> and crashes but ought to figure the cause out. What is your opinon
> on this?

It does not happen here...
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
