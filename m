From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: acpi=force safe?
Date: Sat, 7 Feb 2004 00:06:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040206230617.GJ13262@poupinou.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB685@PDSMSX403.ccr.corp.intel.com> <16644.65.164.3.3.1076087775.squirrel@mail.diamondcpu.com> <20040206211334.GH13262@poupinou.org> <24294.65.164.3.3.1076107609.squirrel@mail.diamondcpu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <24294.65.164.3.3.1076107609.squirrel-gjzqEhKAtSBis2HOlLKa7kEOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nick Bartos <spam99-1EIjRwF9Gc5s5w19saIqfg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 06, 2004 at 04:46:49PM -0600, Nick Bartos wrote:
> 
> >
> > That part of the firmware may be broken, and you may have hang on boot
> > (even though I think it is safe now without lapic support even on old
> > laptops).
> >
> 
> I am compiling it with smp support, so I think it automatically puts in
> lapic support.

lapic support and IO-apic is a good idea ihmo if you have good ethernet
cards especially if you intend to have a lot of traffics in your
router..


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
