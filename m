From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: eisa_set_level_irq(acpi_fadt.sci_int)
Date: 17 Oct 2003 13:28:36 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1066411716.2527.100.camel@dhcppc4>
References: <1066254483.2535.51.camel@dhcppc4>
	 <20031017154107.GI8668@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031017154107.GI8668-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2003-10-17 at 11:41, Ducrot Bruno wrote:
> On Wed, Oct 15, 2003 at 05:48:04PM -0400, Len Brown wrote:
> > What does eisa_set_level_irq() do for us?
> > 
> > As its presence breaks the !CONFIG_PCI build, I deleted it and found
> > that ACPI in PIC mode seems to work just fine without it (at least on 2
> > of 2 systems tested so far)
> > 
> 
> This ensure SCI interrupt is correctly initialized for (poorly) written
> BIOS.  Without it, this break one of my laptop, and certainly others as well.

Do ACPI interrupt work on this latop?  What happens on that system if
you delete the call to eisa_set_level_irq()?

If we blindly program the PIC to be level senstive when the hardware is
designed to be edge triggered, then we'll probably get no ACPI events on
those systems, as the pulse may not be asserted long enough to provoke
an interrupt.

We used to blindly program the APIC assuming the SCI was ACPI compliant,
but we got burnt when we discovered that a significant set of system do
_not_ have a level-triggered active-low SCI.  Most of those specified
their deviation with an SCI-over-ride in the MADT, but some did not:
http://bugzilla.kernel.org/show_bug.cgi?id=774

The APIC solution was to
1. don't hard-code level-triggered active-low
2. do whatever the SCI over-ride says
3. if no SCI over-ride, leave the interrupt trigger/polarity as the BIOS
programmed it.

thanks,
-Len

ps. this routine is mis-named, it it not EISA specific.  Further, it is
mis-located in a PCI-specific file but is not PCI specific.  It should
be in an X86 specific interrupt file and be named pic_something.  I'm
thinking I'll clone it into our x86 acpi code and add a warning when we
find that it actually _changes_ the polarity.






-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
