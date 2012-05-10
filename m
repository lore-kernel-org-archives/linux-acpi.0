From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 3/8] usb: Bind devices to ACPI devices when possible
Date: Thu, 10 May 2012 16:01:42 -0700
Message-ID: <20120510230142.GA11125@kroah.com>
References: <1336575635-13120-1-git-send-email-tianyu.lan@intel.com>
 <1336575635-13120-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63826 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932783Ab2EJXBr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 May 2012 19:01:47 -0400
Received: by pbbrp8 with SMTP id rp8so2490913pbb.19
        for <linux-acpi@vger.kernel.org>; Thu, 10 May 2012 16:01:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336575635-13120-4-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>

On Wed, May 09, 2012 at 11:00:30PM +0800, Lan Tianyu wrote:
> From: Matthew Garrett <mjg@redhat.com>
> 
> Built-in USB devices will typically have a representation in the system
> ACPI tables. Add support for binding the two together so the USB code can
> make use of the associated methods.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

This patch doesn't apply to my usb-next branch.

Last time around, I hand-edited the patch, but I'm tired of doing that
with this series, and it shows you didn't test it against my latest
tree.

This is getting annoying, what would you do in my situation?

Please try again...

greg k-h
