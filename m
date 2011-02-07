From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/5] ACPI: Tie ACPI backlight devices to PCI devices if possible
Date: Mon, 7 Feb 2011 23:04:56 +0100
Message-ID: <201102072304.57030.rjw@sisk.pl>
References: <1295033065-13450-1-git-send-email-mjg@redhat.com> <201102071432.35656.bjorn.helgaas@hp.com> <20110207213426.GA23843@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110207213426.GA23843@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, dri-devel@lists.freedesktop.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, February 07, 2011, Matthew Garrett wrote:
> On Mon, Feb 07, 2011 at 02:32:35PM -0700, Bjorn Helgaas wrote:
> 
> > I'm not familiar with video devices, but I agree, this situation does
> > feel broken.  Is it the case that there's a PCI device as well as an
> > ACPI namespace Device for the same piece of hardware?  If so, I assume
> > the reason for the ACPI Device is to have a "standard" interface to
> > a platform knob like backlight control.
> > 
> > In that case, it seems like we should rely on PCI for enumeration and
> > driver binding, have some sort of hook the PCI driver could use to
> > twiddle that knob (using the ACPI methods), and make the ACPI Device
> > ineligible for driver binding.  In other words, it sounds like part
> > of the problem is that we have two drivers binding to what's really
> > a single piece of hardware.
> 
> Part of the problem is that ACPI video devices aren't inherently PCI 
> devices.

To me, this really isn't about video devices.  The problem is that objects
of type struct acpi_device are treated _differently_ depending on the context.

In the meantime I've reviewed the code a bit and noticed that there's a
parent pointer in struct acpi_device, which basically duplicates the device
tree dependency, so it looks like the embedded dev in struct acpi_device is
really redundant.
