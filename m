From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: eisa_set_level_irq(acpi_fadt.sci_int)
Date: Mon, 27 Oct 2003 14:30:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031027133045.GM28351@poupinou.org>
References: <1066254483.2535.51.camel@dhcppc4> <20031017154107.GI8668@poupinou.org> <1066411716.2527.100.camel@dhcppc4> <1066796711.2593.30.camel@dhcppc4> <1066964092.1541.16.camel@darkstar.portugal> <1066965206.3864.55.camel@dhcppc4> <1066969171.1608.32.camel@darkstar.portugal> <1066975669.3861.84.camel@dhcppc4> <1067046644.2219.9.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1067046644.2219.9.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Oct 25, 2003 at 02:50:43AM +0100, Sérgio Monteiro Basto wrote:
> Hi 
> > > On Fri, 2003-10-24 at 04:13, Len Brown wrote:
> > > > I expect the regression related to your lid switch is cased
> > > > by something else.  But since you have a box with an Edge Triggered
> > > > SCI, I'd be interested if you are able to receive ACPI interrupts
> > > > if we leave the SCI in Edge Triggered mode:
> 
> In fact is the acpi_ec_gpe_query patch that cause the regression.
> After some tests, I am sure, if I apply this patch, pressing lid button
> hangs my laptop.
> and only this patch.
> 
> http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.4.22/20031017152411-acpi_ec_gpe_query.patch
> 

Hem, at first read, this patch is wrong, and seems more adapted to
a perticular case, and being a bad hack in fact.

ec_device_init is always 0 if there is no ECDT table, which is wrong,
or else we will have a really really long interrupt handler, not to
mention that acpi_ec_gpe_query is not interrupt-context safe anyway, so
calling directly this function from the interrupt handler is a mistake
in all cases.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
