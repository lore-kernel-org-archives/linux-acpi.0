From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: smartbattery support
Date: Mon, 11 Oct 2004 11:49:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041011094935.GA23992@poupinou.org>
References: <16A54BF5D6E14E4D916CE26C9AD30575457124@pdsmsx402.ccr.corp.intel.com> <4166EC29.8070006@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4166EC29.8070006-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 08, 2004 at 08:36:09PM +0100, Pedro Venda wrote:
> Li, Shaohua wrote:
> >>On Thu, Oct 07, 2004 at 09:43:20PM +0800, Li, Shaohua wrote:
> >>
> >>>You needed an EC-based SMBus host driver (IIRC, some Acer latops
> >
> >defined
> >
> >>>such host in DSDT). ACPI spec has the definition for EC-based SMBus
> >
> >host
> >
> >>>interface. Second, a sensor driver for reading smart battery
> >
> >information
> >
> >>>is required.
> >>>
> >>
> >>Some times ago, for a toshiba laptop, I began an i2c-acpi-ec driver:
> >>ftp://ftp.poupinou.org/acpi/i2c-acpi-ec.c
> >>
> >>It's a little bit buggy though but this allowed for me to access the
> >>sensors
> >>behind the EC.  The main trouble was that there were not actually a
> >>smbus declared in the ACPI namespace and it was needed to hardcode
> >
> >where
> >
> >>is the base adress in the EC space.
> >>You may try to start with that maybe, and I guess a real
> >
> >acpi_ec_smb_probe
> >
> >>function must be written.
> >
> >Some Acer laptops define the SMBus host as below:
> >  		Device (SMBC)
> >                    {
> >                        Name (_HID, "ACPI0001")
> >                        Name (_EC, 0x1820)
> >                        Device (SBS0)
> >                        {
> >                            Name (_HID, "ACPI0002")
> >                            Name (_SBS, 0x02)
> >                        }
> >                    }
> >The base address and the notification number are defined on the _EC
> >method.
> >Please check if you system has such definition.
> 
> my acer travelmate 4001WLmi looks like this:
> 
> Device (SMBC)
>                     {
>                         Name (_HID, "ACPI0001")
>                         Name (_EC, 0x1820)
>                         Device (SBS0)
>                         {
>                             Name (_HID, "ACPI0002")
>                             Name (_SBS, 0x02)
>                         }
>                     }
> 

This mean that you have a SMB-HC with adress 0x18 and query 0x20.
You may try i2c-acpi-ec, but you have to change:
#define SMBUS_ADDRESS_TO_HAVE 0x60
to 
#define SMBUS_ADDRESS_TO_HAVE 0x18
Also, you need to get at least i2c-core in your kernel for this to work.

Note that this code have 2 years... and if there is more than one EC in
your system, this may not work.  In that case, could you please send me
a dump of the acpi tables?
btw, there is two batteries, because 'Name (_SBS, 0x02)'.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
