From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: Bogus names on vmware
Date: Thu, 19 Nov 2015 17:10:41 -0800
Message-ID: <20151119171041.13468158@xeon-e3>
References: <20151021084158.6b650224@xeon-e3>
	<20151021161755.GA15833@gardel-login>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35329 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933030AbbKTBK3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2015 20:10:29 -0500
Received: by pacej9 with SMTP id ej9so98182573pac.2
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2015 17:10:28 -0800 (PST)
In-Reply-To: <20151021161755.GA15833@gardel-login>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lennart Poettering <lennart@poettering.net>
Cc: Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>, linux-acpi@vger.kernel.org

On Wed, 21 Oct 2015 18:17:56 +0200
Lennart Poettering <lennart@poettering.net> wrote:

> On Wed, 21.10.15 08:41, Stephen Hemminger (stephen@networkplumber.org) wrote:
> 
> > Do you have any recommendations on how to deal with VMware borkage
> > of the ACPI firmware index?
> 
> Hmm, shouldn't the kernel filter such crappy data out already? I mean,
> if we work around crappy firmware, why should that happen in userspace? So
> far that was always a kernel job...
> 
> Any specific reason you assume that 0xffff is a good cutoff point?
> 
> > https://communities.vmware.com/message/2378360
> > 
> > My proposal is to just add special case:
> > 
> > diff --git a/src/udev/udev-builtin-net_id.c b/src/udev/udev-builtin-net_id.c
> > index 6e7e127..b8c6f47 100644
> > --- a/src/udev/udev-builtin-net_id.c
> > +++ b/src/udev/udev-builtin-net_id.c
> > @@ -133,7 +133,7 @@ static int dev_pci_onboard(struct udev_device *dev, struct netnames *names) {
> >          size_t l;
> >          char *s;
> >          const char *attr;
> > -        int idx;
> > +        unsigned long idx;
> >  
> >          /* ACPI _DSM  -- device specific method for naming a PCI or PCI Express device */
> >          attr = udev_device_get_sysattr_value(names->pcidev, "acpi_index");
> > @@ -143,8 +143,9 @@ static int dev_pci_onboard(struct udev_device *dev, struct netnames *names) {
> >          if (!attr)
> >                  return -ENOENT;
> >  
> > +        /* vmware returns bogus values */
> >          idx = strtoul(attr, NULL, 0);
> > -        if (idx <= 0)
> > +        if (idx == 0 || idx > 0xffff)
> >                  return -EINVAL;
> >  
> >          /* kernel provided port index for multiple ports on a single PCI function */
> > 

Sorry for the long latency, for some reason this ended up in Spam.

The kernel could filter but I suspect the ACPI developers would consider
it a valid value.  I made up 0xffff as a mask assuming 64K slots is more than
any normal ACPI would return.

VMware has other issues, there concept of PCI addresses is equally borked (unique)
 http://goo.gl/uhGEj8

Copying the ACPI kernel list on this.



