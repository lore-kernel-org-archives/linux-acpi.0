From: danny@mailmij.org
Subject: Re: double proc entries
Date: Mon, 21 Aug 2006 10:50:42 +0200
Message-ID: <20060821105042.C22067@luna.ellen.dexterslabs.com>
References: <20060821044915.B18790@luna.ellen.dexterslabs.com> <200608211649.13421.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.mailmij.org ([82.93.140.149]:18371 "EHLO mail.mailmij.org")
	by vger.kernel.org with ESMTP id S965015AbWHUIun (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 04:50:43 -0400
Content-Disposition: inline
In-Reply-To: <200608211649.13421.luming.yu@intel.com>; from luming.yu@intel.com on Mon, Aug 21, 2006 at 04:49:12PM +0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@intel.com>
Cc: danny@mailmij.org, linux-acpi@vger.kernel.org, "Brown, Len" <lenb@hera.kernel.org>

On Mon, Aug 21, 2006 at 04:49:12PM +0800, Yu Luming wrote:
> On Monday 21 August 2006 10:49, danny@mailmij.org wrote:
> > Hi,
> >  Recently I noticed that unloading video.ko causes a warning from
> > remove_proc_entry because the subdir is not empty. This is related to the
> > fact that I have 2 VID entries in /proc/acpi/video, and this messes up
> > things a bit. The cause of this is that the VID entry appears both on the
> > PCI and on the AGP bus, sysfs handles this nicely:
> >  ./firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VID
> >...
>
> Yes,  This is a problem.
>
> >  More information can be found here:
> >  http://qa.mandriva.com/show_bug.cgi?id=22249
> >
> >  proc/acpi/video/ does not know about AGP or PCI. Attached patch fixes the
> > problem but is not so beautiful. Maybe it's better to make another subdir
> > in video for the parent of the device, but I thought this would be more
> > likely to break userland apps. Perhaps someone can do better.
> >
>
> The beautiful way is to completely delete /proc/acpi, and turn to sysfs. :-)
> But we still have to live with /proc/acpi for some times.
> So, I think your patch is right thing.
>
> >+        strcpy(proc_dir_name, acpi_device_bid(device));
> >+        strcat(proc_dir_name, "_");
> >+        strcat(proc_dir_name, acpi_device_bid(device->parent));
>
> but, when you are using acpi_device_bid(device->parent), you
> should have checked  device->parent is NOT NULL.
>
Yes I considered this, but then I thought, if there is actually a VID bus, it always has a parent. You cannot have a bus that correctly passes the checks for being
the acpi video device and not have a parent bus. Or can you?

Second question is the size of proc_dir_name: is 32 big enough? Should I have used strncat. I really have no idea at the maximum possible size of the names we get
from the dsdt.

Danny

