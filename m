From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci devices
 on bus 0
Date: Fri, 19 Dec 2008 10:09:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812191005310.2453-100000@iolanthe.rowland.org>
References: <1229668453.562.92.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1229668453.562.92.camel@rzhang-dt>
Sender: linux-pci-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, "Barnes, Jesse" <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, 19 Dec 2008, Zhang Rui wrote:

> device parallel resume support for PCI devices

There are some PCI devices which won't work right if they are resumed
in parallel.  The example I have in mind is a USB host controller
device with both a high-speed EHCI controller function and some
companion low/full-speed UHCI or OHCI controller functions.  The EHCI
driver relies on the fact that the EHCI controller has a higher
function number and therefore is resumed _after_ the companion
controllers.

We need a way to express dependencies like this between devices.  Or at 
least, there has to be a way to prevent certain devices from resuming 
in parallel.

Alan Stern
