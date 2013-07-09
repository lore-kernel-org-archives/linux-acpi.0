From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 5/8] ACPI / hotplug / PCI: Unified notify handler for hotplug events
Date: Wed, 10 Jul 2013 01:49:19 +0200
Message-ID: <2332413.CRuyXNEmFc@vostro.rjw.lan>
References: <26431283.HJCKsss0rt@vostro.rjw.lan> <1475924.SZkPqZAdKY@vostro.rjw.lan> <20130709093045.GJ4898@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20130709093045.GJ4898@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, July 09, 2013 12:30:45 PM Mika Westerberg wrote:
> On Tue, Jul 09, 2013 at 02:19:04AM +0200, Rafael J. Wysocki wrote:
> > Index: linux-pm/drivers/pci/hotplug/acpiphp.h
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/hotplug/acpiphp.h
> > +++ linux-pm/drivers/pci/hotplug/acpiphp.h
> > @@ -137,6 +137,7 @@ struct acpiphp_context {
> >  	acpi_handle handle;
> >  	struct acpiphp_func *func;
> >  	struct acpiphp_bridge *bridge;
> > +	bool handler_for_func:1;
> 
> Hmm, should it be just plain:
> 
> 	bool handler_for_func;
> 
> ? What's the reason using bitfields for bool?

If there are more of them, they can be stored together in one int (they are
unsigned int under the hood).

I this particular case it doesn't matter and one of subsequent patches will
remove that field anyway. :-)

> >  };
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
