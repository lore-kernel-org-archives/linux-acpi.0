From: Li Shaohua <shaohua.li@intel.com>
Subject: Re: [PATCH/RFC 1/4]device core changes
Date: Tue, 09 Nov 2004 11:35:41 +0800
Message-ID: <1099971341.15294.48.camel@sli10-desk.sh.intel.com>
References: <1099887071.1750.243.camel@sli10-desk.sh.intel.com>
	 <20041108225810.GB16197@kroah.com>
	 <1099961418.15294.11.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261160AbUKIDln@vger.kernel.org>
In-Reply-To: <1099961418.15294.11.camel@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Patrick Mochel <mochel@digitalimplant.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-11-09 at 08:50, Li Shaohua wrote:
> On Tue, 2004-11-09 at 06:58, Greg KH wrote:
> > On Mon, Nov 08, 2004 at 12:11:11PM +0800, Li Shaohua wrote:
> > > Hi,
> > > This is the device core change required. Add .platform_bind method for
> > > bus_type, so platform can do addition things when add a new device. A
> > > case is ACPI, we want to utilize some ACPI methods for physical devices.
> > > 1. Why doesn't use 'platform_notify'?
> > > Current device core has a 'platform_notify' mechanism, but it's not
> > > sufficient for this. Only sepcific bus type know how to parse dev.bus_id
> > > and know how to encode specific device's address into ACPI _ADR syntax.
> > 
> > I don't see why platform_notify is not sufficient.  This is the exact
> > reason it was added to the code.
> As I said in the email, we need know the bus type to decode and encode
> address. If you use platform_notify, you must do something like this:
> switch (dev->bus)
> {
> case pci_bus_type:
> bind PCI devices with ACPI devices
> break;
> case ide_bus_type:
> bind IDE devices with ACPI devices
> break;
> ....
> }
> But note this method requires all bus types are build-in. If a bus type
> is in a loadable module (such as IDE bus), the method will failed. I
> searched current tree, only ARM implemented 'platform_notify', but ARM
> only cares PCI bus, ACPI cares about all bus types.
> > 
Oops, it's my bad. we can identify the bus type from bus_type->name, but
it looks like a little ugly. Why the bus_type hasn't a flag to identify
which bus it is?
Anyway, thanks Greg. I will add as you said.

Thanks,
Shaohua
