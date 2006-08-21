From: Len Brown <len.brown@intel.com>
Subject: Re: double proc entries
Date: Mon, 21 Aug 2006 18:02:30 -0400
Message-ID: <200608211802.30792.len.brown@intel.com>
References: <20060821044915.B18790@luna.ellen.dexterslabs.com> <200608211649.13421.luming.yu@intel.com> <20060821105042.C22067@luna.ellen.dexterslabs.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52965 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751226AbWHUWAl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 18:00:41 -0400
In-Reply-To: <20060821105042.C22067@luna.ellen.dexterslabs.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: danny@mailmij.org
Cc: Yu Luming <luming.yu@intel.com>, linux-acpi@vger.kernel.org

On Monday 21 August 2006 04:50, danny@mailmij.org wrote:
> On Mon, Aug 21, 2006 at 04:49:12PM +0800, Yu Luming wrote:
> > On Monday 21 August 2006 10:49, danny@mailmij.org wrote:
> > > Hi,
> > >  Recently I noticed that unloading video.ko causes a warning from
> > > remove_proc_entry because the subdir is not empty. This is related to the
> > > fact that I have 2 VID entries in /proc/acpi/video, and this messes up
> > > things a bit. The cause of this is that the VID entry appears both on the
> > > PCI and on the AGP bus, sysfs handles this nicely:
> > >  ./firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VID
> > >...
> >
> > Yes,  This is a problem.
> >
> > >  More information can be found here:
> > >  http://qa.mandriva.com/show_bug.cgi?id=22249
> > >
> > >  proc/acpi/video/ does not know about AGP or PCI. Attached patch fixes the
> > > problem but is not so beautiful. Maybe it's better to make another subdir
> > > in video for the parent of the device, but I thought this would be more
> > > likely to break userland apps. Perhaps someone can do better.
> > >
> >
> > The beautiful way is to completely delete /proc/acpi, and turn to sysfs. :-)
> > But we still have to live with /proc/acpi for some times.
> > So, I think your patch is right thing.
> >
> > >+        strcpy(proc_dir_name, acpi_device_bid(device));
> > >+        strcat(proc_dir_name, "_");
> > >+        strcat(proc_dir_name, acpi_device_bid(device->parent));
> >
> > but, when you are using acpi_device_bid(device->parent), you
> > should have checked  device->parent is NOT NULL.
> >
> Yes I considered this, but then I thought, if there is actually a VID bus, it always has a parent. You cannot have a bus that correctly passes the checks for being
> the acpi video device and not have a parent bus. Or can you?
> 
> Second question is the size of proc_dir_name: is 32 big enough? Should I have used strncat. I really have no idea at the maximum possible size of the names we get
> from the dsdt.

Ugh, I'd rather be deleting /proc/acpi than fixing bugs in it...

but I think you're looking for this:

#define ACPI_NAME_SIZE 4
or, more specifically,
typedef char acpi_bus_id[5];
is the type returned from acpi-device_bid()

-Len
