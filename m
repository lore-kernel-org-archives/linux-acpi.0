From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI Battery Problems
Date: Mon, 7 Jul 2003 14:38:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030707123833.GB7796@poupinou.org>
References: <20030704195241.GC7074@roadrunner.ichilton.net> <03f101c34268$501e4960$3746028e@bio.dfo.ca> <m3znjrmj1e.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m3znjrmj1e.fsf-eUECQUGGJJCHAtaq1fIXeWD2FQJk+8+b@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "James H. Cloos Jr." <cloos-GRsvFm/Gh/pBDgjK7y7TUQ@public.gmane.org>
Cc: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>, ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jul 06, 2003 at 05:39:41PM -0400, James H. Cloos Jr. wrote:
> >>>>> "Derek" == Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org> writes:
> 
> Derek> yeah, your DSDT is just as broken as every other Dell DSDT I've
> Derek> heard of.  I never have managed to properly fix mine (Inspiron
> Derek> 2500).  And as long as your battery method is broken it's
> Derek> always going to shut down precipitously when the battery runs
> Derek> out...
> 
> FWIW, 2.5.73+ booted w/ acpi_os_name='Microsoft Windows NT' does show
> accurate battery and ac info on an i8100 w/ a14 bios.  (they are up
> to a15 for the 8100.)
> 
> My next test is .74+ with acpi_os_name='Windows 2001'.
> 
> (The two acpi_os_names come from the dsdt; the latter is what the
> dsts expects for xp.)
> 

Most of ASL I saw will more likely use the _OSI() method for Windows XP.
I'm also wondering if that will be OK to implement it (but with
a configure option or perhaps better a boot option).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
