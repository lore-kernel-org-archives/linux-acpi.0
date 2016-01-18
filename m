From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 10/11] acpi: Export acpi_bus_type
Date: Tue, 19 Jan 2016 00:59:13 +0100
Message-ID: <5484189.RBRMZdsTjH@vostro.rjw.lan>
References: <1452752207-30382-1-git-send-email-ankitprasad.r.sharma@intel.com> <1530202.t7e2q1JhJ2@vostro.rjw.lan> <20160118230047.GA9173@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50496 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754668AbcARX6b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2016 18:58:31 -0500
In-Reply-To: <20160118230047.GA9173@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>, intel-gfx@lists.freedesktop.org, akash.goel@intel.com, shashidhar.hiremath@intel.com, tvrtko.ursulin@linux.intel.com, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, January 19, 2016 12:00:47 AM Lukas Wunner wrote:
> Hi,
> 
> On Mon, Jan 18, 2016 at 11:46:18PM +0100, Rafael J. Wysocki wrote:
> > On Monday, January 18, 2016 11:39:07 PM Lukas Wunner wrote:

[cut]

> > > > > If you want to check if the device ir present at all, you cen use
> > > > > acpi_device_is_present() introduced recently (although that would need
> > > > > to be exported if you want to use it from a driver).
> > > > 
> > > > I meant acpi_dev_present(), sorry about the mistake.
> > > > 
> > > > I guess we should rename it to acpi_device_found() or something similar
> > > > to avoid such confusion in the future.
> > > 
> > > The name was chosen because the PCI equivalent is called pci_dev_present()
> > > and I assumed that name already stuck in developers' heads, so if they're
> > > looking for an ACPI presence detection function, that's what they'd look
> > > for first.
> > 
> > But "present" in ACPI really means something different.  There may be ACPI
> > device objects in the namespace for devices that are not *actually* present.
> 
> You mean synthesized devices like LNXSYBUS?
> Don't think anyone is going to test for the presence of that.

No, I mean real devices, where the corresponding ACPI object has _STA that
returns 0.

There may be a couple of reasons for that.  The device the ACPI object
corresponds to may not be physically present (eg. it may possible to
hot-add it) or the device may depend on something else for functionality
and that thing hasn't been set up yet etc.

The presence of an ACPI device object in the namespace means that the
platform firmware knows about the device, but it need not mean that
the device is really there.  _STA returns that piece of information.

> 
> I've posted 5 patches over the last days which use acpi_dev_present():
> 
> http://lists.freedesktop.org/archives/dri-devel/2016-January/098403.html
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-January/103056.html
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-January/103058.html
> http://thread.gmane.org/gmane.linux.drivers.platform.x86.devel/8474/focus=8475
> http://thread.gmane.org/gmane.linux.drivers.platform.x86.devel/8474/focus=8476
> 
> When considering a rename of the function, please bear in mind that it
> will cause breakage for anyone testing or merging these patches.
> (Postponing a rename until these patches have landed would avoid that.)

No problem with that.  Please let me know when these patches are merged.

Thanks,
Rafael

