From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci
	devices on bus 0
Date: Mon, 22 Dec 2008 10:56:19 +0800
Message-ID: <1229914579.562.150.camel@rzhang-dt>
References: <Pine.LNX.4.44L0.0812191005310.2453-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0812191005310.2453-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2008-12-19 at 23:09 +0800, Alan Stern wrote:
> On Fri, 19 Dec 2008, Zhang Rui wrote:
> 
> > device parallel resume support for PCI devices
> 
> There are some PCI devices which won't work right if they are resumed
> in parallel.  The example I have in mind is a USB host controller
> device with both a high-speed EHCI controller function and some
> companion low/full-speed UHCI or OHCI controller functions.  The EHCI
> driver relies on the fact that the EHCI controller has a higher
> function number and therefore is resumed _after_ the companion
> controllers.
> 
well, I never got this problem before.
is this normal? does this exist on the Intel hardware?
I'd like to do some test if I have chance.

> We need a way to express dependencies like this between devices.  Or at 
> least, there has to be a way to prevent certain devices from resuming 
> in parallel.
> 
agree.
Just like the case above, can you give me a lspci output and show me
what exactly the dependency is?

thanks,
rui
