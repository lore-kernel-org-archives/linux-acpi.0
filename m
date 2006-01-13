From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: [RFC] Add lspnp support for sysfs
Date: Fri, 13 Jan 2006 19:02:18 +0100
Message-ID: <20060113180218.GA14129@isilmar.linta.de>
References: <200601131051.36906.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200601131051.36906.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: linux-pcmcia-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Fri, Jan 13, 2006 at 10:51:36AM -0700, Bjorn Helgaas wrote:
> new output (from /sys/bus/pnp/devices/):
> 
>     00:00 PNP0c02 Motherboard resources
> 	state = active
> 	allocated resources:
> 	    io 0x80-0x80
> 	    io 0xffbf-0xffbf
> 	    mem 0xfff80000-0xffffffff
> 
> Feedback welcome.

Sysfs favours a one-value-per-file (or one array per file) approach.
Wouldn't this work for PNP as well?

	Dominik
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
