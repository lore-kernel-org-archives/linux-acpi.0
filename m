From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [net-next: PATCH v4 1/7] device property: Introduce fwnode_get_mac_address()
Date: Tue, 23 Jan 2018 07:12:49 +0100
Message-ID: <CAPv3WKf0GUE508P8k1nExBA+h6pQr4UcaFPk+mps3xRepESQmw@mail.gmail.com>
References: <1516278704-17141-1-git-send-email-mw@semihalf.com>
 <1516278704-17141-2-git-send-email-mw@semihalf.com> <CAJZ5v0j=4Lvaf49oeDqVmYP5nyAs-E9E8xdgyfL7=J_46X5TMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38344 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeAWGMv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jan 2018 01:12:51 -0500
Received: by mail-it0-f49.google.com with SMTP id w14so12496082itc.3
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jan 2018 22:12:51 -0800 (PST)
In-Reply-To: <CAJZ5v0j=4Lvaf49oeDqVmYP5nyAs-E9E8xdgyfL7=J_46X5TMA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, netdev <netdev@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, David Miller <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Stefan Chulski <stefanc@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Grzegorz

Hi Rafael,

> >         if (res)
> >                 return res;
> >
> > -       return device_get_mac_addr(dev, "address", addr, alen);
> > +       return fwnode_get_mac_addr(fwnode, "address", addr, alen);
> > +}
> > +EXPORT_SYMBOL(fwnode_get_mac_address);
>
> That should be EXPORT_SYMBOL_GPL().
>
> I have overlooked that previously, sorry about that.

The series landed yesterday in net-next, so I need to send a fix on
top. Would you be ok with single patch fixing all EXPORT_SYMBOL()
occurences? Those would be 2 new routines:
- fwnode_get_mac_address
- fwnode_irq_get
and  2 already existing in the file:
- device_get_mac_address
- fwnode_graph_parse_endpoint

Please let know, how you prefer to handle it?

Best regards,
Marcin

>
> > +
> > +/**
> > + * device_get_mac_address - Get the MAC for a given device
> > + * @dev:       Pointer to the device
> > + * @addr:      Address of buffer to store the MAC in
> > + * @alen:      Length of the buffer pointed to by addr, should be ETH_ALEN
> > + */
> > +void *device_get_mac_address(struct device *dev, char *addr, int alen)
> > +{
> > +       return fwnode_get_mac_address(dev_fwnode(dev), addr, alen);
> >  }
> >  EXPORT_SYMBOL(device_get_mac_address);
>
> Same here.
>
> Generally speaking, you should use EXPORT_SYMBOL_GPL() everywhere
> unless there's a specific reason for not doing that in which cases
> that specific reason has to be clearly spelled out at least in the
> changelog of the patch, but really better in a code comment.
>
> >
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index f6189a3..35620e0 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -279,6 +279,8 @@ int device_get_phy_mode(struct device *dev);
> >
> >  void *device_get_mac_address(struct device *dev, char *addr, int alen);
> >
> > +void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
> > +                            char *addr, int alen);
> >  struct fwnode_handle *fwnode_graph_get_next_endpoint(
> >         const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
> >  struct fwnode_handle *
> > --
