From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH][RFC] Add C3 support to P4-M / ICH-M chipsets
Date: Fri, 21 May 2004 20:01:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040521180155.GP29214@poupinou.org>
References: <20040518211431.GA17545@hell.org.pl> <1085110450.12353.553.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1085110450.12353.553.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, May 20, 2004 at 11:34:11PM -0400, Len Brown wrote:
> On Tue, 2004-05-18 at 17:14, Karol Kozimor wrote:
> 
> > Now, for the tricky part:
> > 
> > 1) Is it actually worth it? Do the power savings justify the effort? Are
> >    there many people who might benefit from this patch?
> > 2) Are there any chances on merging such chipset-specific quirks?
> >    Obviously, not in the current form, but possibly as a separate object
> >    surrounded by pci_find_subsys() or anything appropriate?
> 
> Karol,
> Good hunting ont he chip set spect etc.

IIRC, there is trouble with C3 on a ICH3m, though I do not remember
exactly if that is true.  I will look at the specs update.

> But lets wait till after we have a _CST based implementation in place
> and then see if the workarounds are still necessary then.

I doubt this will work.  At least my patch do require ARB_DIS, as well
for those writen by Dominik IIRC.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
