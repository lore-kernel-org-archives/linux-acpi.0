From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Ipw2100-devel] Re: ibm-acpi-0.3
Date: 18 Aug 2004 09:38:18 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092836298.25911.180.camel@dhcppc4>
References: <20040810080826.GD28939@aero.ensim.com>
	 <20040814211247.GS20883@aero.ensim.com>
	 <20040817091921.GI20883@aero.ensim.com>
	 <1092807746.25902.155.camel@dhcppc4>
	 <1092835382.11535.6.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1092835382.11535.6.camel-7g89Hwo0MwsWlyYapE9R8Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Henrik Brix Andersen <brix-dZkOyQknF4g@public.gmane.org>
Cc: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org, ipw2100-devel List <ipw2100-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-08-18 at 09:23, Henrik Brix Andersen wrote:
> Hi,
> 
> On Wed, 2004-08-18 at 07:42, Len Brown wrote:
> > > http://bkernel.sf.net/tmp/ibm-acpi-0.3.tar.gz
> > 
> > The radio hot key sends an ACPI event,
> > and the acpid example calls this radio.sh:
> > 
> > #!/bin/bash
> > 
> > if ! /sbin/rmmod ipw2100; then
> >         /sbin/service network restart
> > fi
> > 
> > 
> > Does this means that the button press magically changed
> > the state of the radio in hardware?  I didn't see any
> > processing inside the driver to do that.
> 
> No. The listed radio.sh script just unloads the ipw2100 module from
> memory which effectively disables the wireless network connection.

So rather than actually disabling the radio, we're diabling the network
by unloading the driver?  Is there an indicator light that says if the
radio is enalbed?  Does is stay on?

thanks,
-Len




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
