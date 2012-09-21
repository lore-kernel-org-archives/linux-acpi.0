From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V2] ACPI: Allow acpi binding with usb3.0 hub
Date: Fri, 21 Sep 2012 10:24:33 -0700
Message-ID: <20120921172433.GC6909@xanatos>
References: <1345185849-3041-1-git-send-email-tianyu.lan@intel.com>
 <20120921002527.GB6909@xanatos>
 <505BDBF1.2020209@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <505BDBF1.2020209-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 21, 2012 at 11:16:01AM +0800, Lan Tianyu wrote:
> On 2012=E5=B9=B409=E6=9C=8821=E6=97=A5 08:25, Sarah Sharp wrote:
> > Hi Tianyu,
> >=20
> > You're correct that the USB core and the xHCI driver has a slightly
> > different architecture than the ACPI representation.  We have one P=
CI
> > device that has two USB buses/roothubs underneath it.  That's becau=
se
> > external USB 3.0 hubs show up as two USB devices: a USB 3.0 only
> > portion, and a USB 2.0 portion.  We wanted roothubs to act the same=
 way.
> >=20
> > The architecture looks something like this:
> >=20
> >       struct pci_dev
> >       |
> > struct usb_hcd *primary_hcd -- struct usb_hcd *secondary_hcd
> >       |                               |
> > struct usb_bus                  struct usb_bus
> >       |                               |
> >  struct usb_device *root_hub     struct usb_device *root_hub
> >       |                               |
> >    struct device                   struct device
> >=20
> > Where the primary_hcd is for the USB 2.0 roothub, and the secondary=
_hcd
> > is for the USB 3.0 roothub.
> >=20
> > So you're trying to bind one ACPI node (RHUB) to the struct device
> > contained in those two root_hubs, correct?  That goal seems sane to=
 me.
> >=20
> Yes, that is my patch's purpose.

Great!  Len should queue it up then.

Acked-by: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
