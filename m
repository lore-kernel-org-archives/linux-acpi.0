From: David Brownell <david-b@pacbell.net>
Subject: Re: [ACPI] RE: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Date: Wed, 20 Oct 2004 10:02:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410201002.58172.david-b@pacbell.net>
References: <16A54BF5D6E14E4D916CE26C9AD3057559A042@pdsmsx402.ccr.corp.intel.com> <200410192251.14740.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268750AbUJTRNa@vger.kernel.org>
In-Reply-To: <200410192251.14740.dtor_core@ameritech.net>
Content-Disposition: inline
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: acpi-devel@lists.sourceforge.net, "Li, Shaohua" <shaohua.li@intel.com>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 19 October 2004 20:51, Dmitry Torokhov wrote:
> On Tuesday 19 October 2004 04:11 am, Li, Shaohua wrote:
> > A final solution is device core adds an ACPI layer. That is we can link
> > ACPI device and physical device. This way, the PCI device can know which
> > ACPI is linked with it, so the PCI API can use specific ACPI method. 

The driver model core has platform_notify hooks for device add/remove,
and ACPI should kick in that way ... they might well need tweaks though.


> > You are right, we currently haven't a method to reach the goal. To match
> > a physical device and ACPI device, we need to know the ACPI device's
> > _ADR and bus.
> > I have a toy to link the PCI device and ACPI device, and some PCI
> > function can use _SxD method and _PSx method to get some information for
> > suspend/resume.
> > 
> 
> The only caveat is that PCI core should not depend on ACPI because it is not
> available on all platforms, not all world is x86.

RIght!  Maybe something like:

	int pci_enable_wake(pci_dev, on_or_off) {
		...
		if (dev->platform_data)
			platform_enable_wake(dev, on_or_off)
		...
	}

That'd call an acpi_enable_wake().  I guess OpenBoot would
do its thing, and embedded boards could do all kinds of stuff.

- Dave
