From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFC 2/2] new C-state policy
Date: Wed, 11 Jan 2006 15:19:18 +0100
Message-ID: <43C513E6.10900@suse.de>
References: <1136866376.5750.29.camel@sli10-desk.sh.intel.com> <20060110231711.GB30356@isilmar.linta.de> <1136944855.5750.61.camel@sli10-desk.sh.intel.com> <20060111080402.GB599@isilmar.linta.de> <43C4EA5D.9040907@suse.de> <20060111135113.GA11960@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060111135113.GA11960-JwFqNg2GrOVrgjWwlLH9qw@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dominik Brodowski wrote:
> Hi,
> 
> On Wed, Jan 11, 2006 at 12:22:05PM +0100, Thomas Renninger wrote:
>>> What to do once bm_activity is or was detected, yes. How to determine
>>> whether there is current bus mastering activity, no -- that's core stuff,
>>> not policy stuff.
>>>
>> I had the experience that tweaking how bm_activity is detected could help a 
>> lot.
> 
> I think we still don't speak about the same topic:
Ok, that's the problem.
> 
> a) how to detect bus mastering activity?
> 	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status, ACPI_MTX_DO_NOT_LOCK);
> 	if (errata.piix4.bmisx) {
>         	if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
>                    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
> 				pr->power.bm_activity++;
> 	}
> 	=> generic
> 
> b) what to do?
> 	demote/allow faulty transition/...
> 	=> driver-specific
> 
> 
> So  all I want is the following:
> 	
> 
> static int acpi_processor_bm_status(void) {
> 	u32 bm_status;
> 
> 	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status, ACPI_MTX_DO_NOT_LOCK);
> 	if (bm_status)
> 		return 1;
> 	else if (errata.piix4.bmisx) {
>         	if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
>                    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
> 			return 1;
> 	}
> 
> 	return 0;
> }
> 
Yep, now I get your point and agree.

       Thomas
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
