From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI stops working after memory upgrade vpr Matrix 175b4
Date: Sat, 7 Feb 2004 13:23:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040207122355.GR13262@poupinou.org>
References: <20040204073941.05d71e0b.rddunlap@osdl.org> <20040205123049.GC22034@hell.org.pl> <20040205082758.1917e71a.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040205082758.1917e71a.rddunlap-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 05, 2004 at 08:27:58AM -0800, Randy.Dunlap wrote:
> On Thu, 5 Feb 2004 13:30:49 +0100 Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> wrote:
> 
> | Thus wrote Randy.Dunlap:
> | > < Recompile your DSDT. Since the amount of RAM changed and you're probably
> | > < using old DSDT containing wrong addresses, no wonder you're hitting
> | > < errors.
> | > Is this correct?  If a user adds or removes memory, then the
> | > DSDT must be rebuilt?  Sheesh!!  That's bad if this is correct.
> | 
> | Yes, that's a necessity in most cases. Why do you consider it that bad?
> 
> That seems quite backwards to me.
> Why should we consider that a good thing?

IMHO that a bad thing.

> I discussed this with Andy Grover and he said that the DSDT isn't
> where the memory size is defined.  It should just be coming from
> the e820 BIOS calls, not from ACPI DSDT etc., which certainly
> made sense to me, as that is something that a user wouldn't need
> to modify after changing the memory size of a system.

I'm not sure if the tables are copied upon e820 calls, but I think
there are copied on POST at least on Phoenix BIOS (that what I
understood from their documentations).  Also most of time, the
AML need somehow to access to the nvram, which is located typically
relative to TOM.  Also, when you add/remove memory modules, there
there is chance that mmio regions are not the same, and
aml need to know that.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
