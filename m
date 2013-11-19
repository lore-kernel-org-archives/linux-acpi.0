From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI / hotplug / ACPI: Drop unused acpiphp_debug declaration
Date: Tue, 19 Nov 2013 21:52:17 +0100
Message-ID: <5115264.27yxWCajFa@vostro.rjw.lan>
References: <1384870535-20532-1-git-send-email-mika.westerberg@linux.intel.com> <CAErSpo56wWzNpkcEmkRnaGR4uk=eHrDzt2k-4PiHk9Rb=qRr-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64401 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752309Ab3KSUji (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2013 15:39:38 -0500
In-Reply-To: <CAErSpo56wWzNpkcEmkRnaGR4uk=eHrDzt2k-4PiHk9Rb=qRr-w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tuesday, November 19, 2013 10:23:57 AM Bjorn Helgaas wrote:
> On Tue, Nov 19, 2013 at 7:15 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > Commit bd950799d951 (PCI: acpiphp: Convert to dynamic debug) removed users
> > of acpiphp_debug variable and the variable itself but the declaration was
> > left in the header file. Drop this unused declaration.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Rafael, if it makes sense for you to apply this, you can add my:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Otherwise I can pick it up.

Applied, thanks!

I'm going to send my next pull request tomorrow.

> > ---
> >  drivers/pci/hotplug/acpiphp.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
> > index 26100f510b10..1592dbe4f904 100644
> > --- a/drivers/pci/hotplug/acpiphp.h
> > +++ b/drivers/pci/hotplug/acpiphp.h
> > @@ -176,7 +176,6 @@ u8 acpiphp_get_latch_status(struct acpiphp_slot *slot);
> >  u8 acpiphp_get_adapter_status(struct acpiphp_slot *slot);
> >
> >  /* variables */
> > -extern bool acpiphp_debug;
> >  extern bool acpiphp_disabled;
> >
> >  #endif /* _ACPIPHP_H */
> > --
> > 1.8.4.3
> >
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
