From: Yu Luming <luming.yu@intel.com>
Subject: Re: double proc entries
Date: Mon, 21 Aug 2006 16:49:12 +0800
Message-ID: <200608211649.13421.luming.yu@intel.com>
References: <20060821044915.B18790@luna.ellen.dexterslabs.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64887 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030364AbWHUIn1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 04:43:27 -0400
In-Reply-To: <20060821044915.B18790@luna.ellen.dexterslabs.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: danny@mailmij.org
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <lenb@hera.kernel.org>

On Monday 21 August 2006 10:49, danny@mailmij.org wrote:
> Hi,
>  Recently I noticed that unloading video.ko causes a warning from
> remove_proc_entry because the subdir is not empty. This is related to the
> fact that I have 2 VID entries in /proc/acpi/video, and this messes up
> things a bit. The cause of this is that the VID entry appears both on the
> PCI and on the AGP bus, sysfs handles this nicely:
>  ./firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VID
>...

Yes,  This is a problem.

>  More information can be found here:
>  http://qa.mandriva.com/show_bug.cgi?id=22249
>
>  proc/acpi/video/ does not know about AGP or PCI. Attached patch fixes the
> problem but is not so beautiful. Maybe it's better to make another subdir
> in video for the parent of the device, but I thought this would be more
> likely to break userland apps. Perhaps someone can do better.
>

The beautiful way is to completely delete /proc/acpi, and turn to sysfs. :-)
But we still have to live with /proc/acpi for some times.
So, I think your patch is right thing.

>+        strcpy(proc_dir_name, acpi_device_bid(device));
>+        strcat(proc_dir_name, "_");
>+        strcat(proc_dir_name, acpi_device_bid(device->parent));
 
but, when you are using acpi_device_bid(device->parent), you 
should have checked  device->parent is NOT NULL.

-- 
Thanks,
Luming
