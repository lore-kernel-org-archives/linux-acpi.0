From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 3/3] Xen pad logic and notification
Date: Sun, 19 Feb 2012 13:24:28 -0500
Message-ID: <20120219182428.GB11882@phenom.dumpdata.com>
References: <DE8DF0795D48FD4CA783C40EC829233509D87E@SHSMSX101.ccr.corp.intel.com>
 <20120217143727.GC29110@phenom.dumpdata.com>
 <DE8DF0795D48FD4CA783C40EC82923350A0869@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DE8DF0795D48FD4CA783C40EC82923350A0869@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Jinsong" <jinsong.liu@intel.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Kernel development list <linux-kernel@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, Jan Beulich <JBeulich@suse.com>, "keir.xen@gmail.com" <keir.xen@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

> >> +#ifdef CONFIG_ACPI_PROCESSOR_AGGREGATOR
> > 
> > How does that work when the the driver is booted under baremetal?
> > Won't it kick out the native ACPI_PROCESSOR_AGGREGATOR_CLASS
> > (acpi_pad.c) ? 
> > 
> > What about if the other ACPI_PROCESSOR_AGGREGATOR_CLASS gets called
> > first? Won't this fail?
> > 
> > Or is the acpi_bus_register_driver smart enough to process more than
> > one ACPI bus device?
> 
> When driver booted under baremetal, xen_acpi_pad.c would be disabled and native acpi_pad.c logic would work.

Ah right. It is b/c it uses the pvops indirection mechanism.
