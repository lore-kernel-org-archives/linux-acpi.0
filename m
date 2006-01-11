From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: [RFC 2/2] new C-state policy
Date: Wed, 11 Jan 2006 14:51:13 +0100
Message-ID: <20060111135113.GA11960@isilmar.linta.de>
References: <1136866376.5750.29.camel@sli10-desk.sh.intel.com> <20060110231711.GB30356@isilmar.linta.de> <1136944855.5750.61.camel@sli10-desk.sh.intel.com> <20060111080402.GB599@isilmar.linta.de> <43C4EA5D.9040907@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43C4EA5D.9040907-l3A5Bk7waGM@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Wed, Jan 11, 2006 at 12:22:05PM +0100, Thomas Renninger wrote:
> >What to do once bm_activity is or was detected, yes. How to determine
> >whether there is current bus mastering activity, no -- that's core stuff,
> >not policy stuff.
> >
> I had the experience that tweaking how bm_activity is detected could help a 
> lot.

I think we still don't speak about the same topic:

a) how to detect bus mastering activity?
	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status, ACPI_MTX_DO_NOT_LOCK);
	if (errata.piix4.bmisx) {
        	if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
                   || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
				pr->power.bm_activity++;
	}
	=> generic

b) what to do?
	demote/allow faulty transition/...
	=> driver-specific


So  all I want is the following:
	

static int acpi_processor_bm_status(void) {
	u32 bm_status;

	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status, ACPI_MTX_DO_NOT_LOCK);
	if (bm_status)
		return 1;
	else if (errata.piix4.bmisx) {
        	if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
                   || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
			return 1;
	}

	return 0;
}


in order to not having to copy this code into each policy. What to do with
the return value of acpi_processor_bm_status() is then up to the policy.

	Dominik

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
