From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 10/11] acpi: Export acpi_bus_type
Date: Tue, 19 Jan 2016 23:03:05 +0100
Message-ID: <1687142.Ti6uQtexoh@vostro.rjw.lan>
References: <1452752207-30382-1-git-send-email-ankitprasad.r.sharma@intel.com> <5484189.RBRMZdsTjH@vostro.rjw.lan> <20160119163104.GA9469@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62946 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932252AbcASWCY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2016 17:02:24 -0500
In-Reply-To: <20160119163104.GA9469@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>, intel-gfx@lists.freedesktop.org, akash.goel@intel.com, shashidhar.hiremath@intel.com, tvrtko.ursulin@linux.intel.com, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, January 19, 2016 05:31:04 PM Lukas Wunner wrote:
> Hi Rafael,
> 
> On Tue, Jan 19, 2016 at 12:59:13AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, January 19, 2016 12:00:47 AM Lukas Wunner wrote:
> > > Hi,
> > > 
> > > On Mon, Jan 18, 2016 at 11:46:18PM +0100, Rafael J. Wysocki wrote:
> > > > On Monday, January 18, 2016 11:39:07 PM Lukas Wunner wrote:
> > 
> > [cut]
> > 
> > > > > > > If you want to check if the device ir present at all, you cen use
> > > > > > > acpi_device_is_present() introduced recently (although that would need
> > > > > > > to be exported if you want to use it from a driver).
> > > > > > 
> > > > > > I meant acpi_dev_present(), sorry about the mistake.
> > > > > > 
> > > > > > I guess we should rename it to acpi_device_found() or something similar
> > > > > > to avoid such confusion in the future.
> > > > > 
> > > > > The name was chosen because the PCI equivalent is called pci_dev_present()
> > > > > and I assumed that name already stuck in developers' heads, so if they're
> > > > > looking for an ACPI presence detection function, that's what they'd look
> > > > > for first.
> > > > 
> > > > But "present" in ACPI really means something different.  There may be ACPI
> > > > device objects in the namespace for devices that are not *actually* present.
> > > 
> > > You mean synthesized devices like LNXSYBUS?
> > > Don't think anyone is going to test for the presence of that.
> > 
> > No, I mean real devices, where the corresponding ACPI object has _STA that
> > returns 0.
> > 
> > There may be a couple of reasons for that.  The device the ACPI object
> > corresponds to may not be physically present (eg. it may possible to
> > hot-add it) or the device may depend on something else for functionality
> > and that thing hasn't been set up yet etc.
> > 
> > The presence of an ACPI device object in the namespace means that the
> > platform firmware knows about the device, but it need not mean that
> > the device is really there.  _STA returns that piece of information.
> 
> Thank you for the clarification, these are very good points.
> 
> The drivers in question use acpi_get_devices() merely to probe for
> presence of a device in the namespace. They do not invoke _STA,
> nor do they even hold a pointer to the acpi_device or acpi_handle
> when detecting presence. Mostly this is about activating quirks
> if a certain ACPI device is detected.

I know, but it doesn't matter too much.  I don't want people to wonder
what the difference between acpi_dev_present() and acpi_device_is_present()
is and when to use which of them.

> Currently about 50% of the calls to acpi_get_devices() in the drivers
> fit this pattern and the point of acpi_dev_present() is to give
> developers a simple, lightweight tool as an alternative.

Again, I know, but the name of the function should be different.

> However the kernel-doc should be amended to clarify that _STA is not
> invoked. The patch below is a suggestion, feel free to rephrase.

That's OK, but it's not enough.

I guess it won't be a big deal to change the function name and rebase
the patches depending on it on top of that change, will it?

Thanks,
Rafael

