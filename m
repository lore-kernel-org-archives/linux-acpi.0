From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Resend PATCH] ACPI: Add the IPMI opregion driver to enable ACPI to access BMC controller
Date: Tue, 15 Dec 2009 08:27:51 -0700
Message-ID: <200912150827.52420.bjorn.helgaas@hp.com>
References: <1260323925-25701-1-git-send-email-yakui.zhao@intel.com> <1260854520.21292.26.camel@dc7800.home> <1260868950.3847.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:27007 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbZLOP15 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2009 10:27:57 -0500
In-Reply-To: <1260868950.3847.40.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, minyard@acm.org

On Tuesday 15 December 2009 02:22:30 am ykzhao wrote:
> On Tue, 2009-12-15 at 13:22 +0800, Bjorn Helgaas wrote:
> > On Tue, 2009-12-15 at 08:59 +0800, ykzhao wrote:
> > > On Tue, 2009-12-15 at 08:18 +0800, Bjorn Helgaas wrote:
> > > > On Sunday 13 December 2009 03:20:27 am ykzhao wrote:
> > > > > On Wed, 2009-12-09 at 22:57 +0800, Bjorn Helgaas wrote:
> > > > > > On Tuesday 08 December 2009 06:58:45 pm yakui.zhao@intel.com wrote:
> > > > > > > From: Zhao Yakui <yakui.zhao@intel.com>
> > > > > > >
> > > > > > > Add the IPMI opregion driver so that the AML code can communicate with BMC
> > > > > > > throught IPMI message.
> > > > > > >      It will create IPMI user interface for every IPMI device detected
> > > > > > > in ACPI namespace and install the corresponding IPMI opregion space handler.
> > > > > > >
> > > > > > > The following describes how to process the IPMI request in IPMI space handler:
> > > > > > >     1. format the IPMI message based on the request in AML code.
> > > > > > >     IPMI system address. Now the address type is SYSTEM_INTERFACE_ADDR_TYPE
> > > > > > >     IPMI net function & command
> > > > > > >     IPMI message payload
> > > > > > >     2. send the IPMI message by using the function of ipmi_request_settime
> > > > > > >     3. wait for the completion of IPMI message. It can be done in different
> > > > > > > routes: One is in handled in IPMI user recv callback function. Another is
> > > > > > > handled in timeout function.
> > > > > > >     4. format the IPMI response and return it to ACPI AML code.
> > > > > > 
> > > > > > I think this should be part of the ipmi_si_intf module, not a separate
> > > > > > module.  This opregion code is of no use without ipmi_si_intf.  The
> > > > > > opregion code can still be under its own config option, but I don't
> > > > > > see the value in having it be a separate module.
> > > > > 
> > > > > This opregion code can't work if the IPMI subsystem is not loaded. this
> > > > > is right. I also agree with this point.
> > > > > But this doesn't mean that this must be put into the module of
> > > > > ipmi_si_intf.
> > > > > In fact this opregion code only uses the IPMI API function to
> > > > > communicate with IPMI system interface. At the same time its main
> > > > > purpose is to handle the request from ACPI AML code. It had better be
> > > > > put into the ACPI subsystem. I think that it is unnecessary to put it
> > > > > into the ipmi_si_intf module.
> > > > > 
> > > > > 
> > > > > BTW: Several modules(for example: drivers/hwmon/ibmaem.c ,
> > > > > drivers/hwmon/ibmpex.c) also use the IPMI system interface to
> > > > > communicate with the IPMI subsystem. But they are the different part of
> > > > > ipmi_si_intf module.
> > > > > 
> > > > > > The opregion code should definitely not use acpi_bus_register_driver()
> > > > > > to claim IPI0001 devices.  The ipmi_si_intf driver already uses
> > > > > > pnp_register_driver() to claim IPI0001 devices.  The fact that Linux
> > > > > > allows two drivers to claim the same device (one via pnp_register_driver()
> > > > > > and the other via acpi_bus_register_driver()) is a defect in Linux, and
> > > > > > we shouldn't take advantage of that.
> > > > > 
> > > > > If you think that this code had better not use the
> > > > > acpi_bus_register_driver, I will try to enumerate this device from ACPI
> > > > > device tree directly and then install the IPMI opregion handler for it.
> > > > 
> > > > I think there are two questions here: (1) should this be part of
> > > > ipmi_si_intf? and (2) how should it be registered?
> > > > 
> > > > For (1), I see your point that we do have existing modules that are
> > > > separate modules, and this is conceptually similar to those.  So
> > > > maybe this should be a separate module, too.  If they're separate
> > > > modules, I think the issues are how they communicate and how we get
> > > > the opregion part autoloaded.  It's easy to see how ipmi_si_intf
> > > > gets autoloaded -- the PNP or PCI core discovers a device and emits
> > > > a uevent that udev can match with a driver.  I don't think we want
> > > > the user to have to explicitly modprobe the opregion driver, so we
> > > > need some uevent or similar hook that udev can use to load it
> > > > automatically when appropriate.
> > > 
> > > From the source code it seems that the ipmi_si_intf module only detects
> > > the available BMC device. It doesn't care which part communicates with
> > > the BMC device. So it will be better to put this code out of
> > > ipmi_si_intf module. 
> > > 
> > > Whether the opregion code should used depends on the user configuration.
> > > If we expect that the ACPI aml code can communicate with the BMC, we
> > > will select this part. Correspondingly the IPMI subsystem will also be
> > > selected as this part depends on the IPMI subsystem. If the user doesn't
> > > care whether the AML code can communicate with the BMC, they can leave
> > > it alone. If we expect to use the uevent, that is not related with this
> > > patch.
> > 
> > I'm sorry, I don't understand what you're saying here.  I expect the
> > opregion module to be generally useful, so distros will probably enable
> > the config option, so the module will be present on every machine.  How
> > do you plan to have it loaded?  We need some sort of automatic
> > mechanism; the user should not have to decide whether to load the
> > module.
> 
> What I said is that user needs to decide whether the IPMI opregion
> module should be used when building the kernel. If we want to use it, we
> will have to select it in kernel configuration.

Yes.  During Kconfig, the user (or in most cases, the distro) selects
Y/N/M.

> And then system will 
> load it in the boot time. Right?

Distros will typically select "M", so we build a module.  The module
is not part of the static kernel image.  It will not be loaded unless
we make some arrangement for it to be loaded.  I'm asking what arrangement
you propose.

> If not right, do we need care the case 
> that this opregion code is not loaded automatically in the boot time?

If the opregion code is a module, it will not be loaded until some
event causes it to be loaded.  For example, for PCI drivers, the PCI
core emits a uevent when it discovers a PCI device.  The uevent contains
the vendor/device ID, and udev can match that information with a driver
that claims the device, and load the driver automatically.  Another
way is for the user to type "modprobe <driver>" manually.  Another is
for the user to set up /etc/modprobe.conf so the driver is loaded
automatically by an init script.

I think the last two possibilities ((1) manual modprobe, (2) edit
/etc/modprobe.conf) are poor choices because they require the user
to do too much work.

The kernel already emits uevents for ACPI/PNP devices, and udev
knows how to load matching drivers.  This mechanism is enough to
cause ipmi_si_intf to be loaded automatically, and that gives us a
good hook for the opregion piece as well.

We want to attach the opregion driver exactly when ipmi_si_intf
claims an ACPI device, so integrating this code (or at least a call
to it) in ipmi_si_intf seems natural.  It's also important to *detach*
the opregion handler at the appropriate time (e.g., when the IPMI
interface is removed or the ipmi_si_intf driver is unloaded).  Again,
tight integration in ipmi_si_intf solves the detach problem nicely.

> If you think that it is ok to enable the opregion part as soon as we
> finish the detection of IPMI system interfaces, I can add the opregion
> code into the ipmi_si_intf part. But if so, maybe we can use the ACPI
> device driver to detect the BMC controller defined in ACPI namespace
> instead of using PNP device driver. At the same time this mechanism
> should be used firstly.
> 
> Is this OK to you?

I'm sorry if I'm being repetitious or not understanding you correctly.

My recent patches add PNP detection to ipmi_si_intf.c.  I think it would
be a good idea to add the opregion setup to ipmi_pnp_probe().  I think
it would be a bad idea to change ipmi_si_intf.c to use acpi_walk_namespace()
or acpi_bus_register_driver().

> > > > For (2), I don't think using acpi_walk_namespace() to determine when
> > > > to install the IPMI opregion handler is quite the right thing either.
> > 
> > > > This opregion handler allows AML to use IPMI services.  Using
> > > > acpi_walk_namespace() means that we'll only install the handler
> > > > when we have an ACPI IPMI device.  But I think the opregion should
> > > > be independent of the type of IPMI device, i.e., I think we want
> > > > this opregion to work even if the underlying IPMI interface is PCI.
> > > 
> > > This opregion code is only to enable the ACPI AML code to communicate
> > > with the BMC device. If AML code wants to access the BMC controller, we
> > > must declare the corresponding IPMI device in ACPI namespace and add the
> > > opregion field definition. If the IPMI device is not declared explicitly
> > > in ACPI table, this code won't work even when there exists the BMC
> > > device on the system.
> > 
> > Oops, sorry, I see that you are right: the ACPI 4.0 spec, sec 5.5.2.4.3,
> > Declaring IPMI Operation Regions, is indeed restricted so it only works
> > with ACPI IPMI devices.  That is an unfortunate restriction on the
> > platform architecture, but maybe there's a good reason for it.
> > 
> > That section says that operation regions are defined within the
> > immediate context of the 'owning' IPMI device.  This, together with the
> > fact that the opregion support is only useful for ACPI devices, suggests
> > to me that the opregion module is different from the ibmaem and ibmpex
> > modules after all.  Those modules apparently can work with *any* sort of
> > IPMI device, so they are more independent.
> 
> The IPMI opregion code is only used for the IPMI device that defined in
> ACPI namespace. If one IPMI device is not defined in ACPI namespace,
> then we won't install IPMI opregion space handler for it. Corresponding
> the ACPI AML code won't communicate with it.

If we want the opregion code only for ACPI devices, the easiest way
to accomplish this is to set it up when we discover the ACPI device.
It's much harder to do it later, because you have to look through all
the IPMI interfaces and figure out which ones are ACPI devices.

Bjorn


