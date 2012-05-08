From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Resend PATCH V2 3/7] usb: Set device removable state based on
 ACPI USB data
Date: Tue, 8 May 2012 10:31:54 -0700
Message-ID: <20120508173154.GA9171@kroah.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
 <1336100803-28353-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37786 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab2EHRb7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 May 2012 13:31:59 -0400
Received: by pbbrp8 with SMTP id rp8so8299862pbb.19
        for <linux-acpi@vger.kernel.org>; Tue, 08 May 2012 10:31:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336100803-28353-4-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>

On Fri, May 04, 2012 at 11:06:39AM +0800, Lan Tianyu wrote:
> From: Matthew Garrett <mjg@redhat.com>
> 
> ACPI offers two methods that allow us to infer whether or not a USB port
> is removable. The _PLD method gives us information on whether the port is
> "user visible" or not. If that's not present then we can fall back to the
> _UPC method which tells us whether or not a port is connectable.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/usb/core/usb-acpi.c |   56 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)

This is getting frustrating...

After this patch I get the following build error:
	ERROR: "acpi_get_physical_device_location" [drivers/usb/core/usbcore.ko] undefined!

Lan, please retest these, and resend them, with Matthew's other ACPI
patch, after it's all working properly, and you have fixed this all up.
I've dropped all of these from my mailboxes now, you need to start over.

Also, when you forward on a patch like this, and the others, please also
sign-off-by: on it, or at least Ack: it, to keep you in the chain of bug
reporting and stuff.

greg k-h
