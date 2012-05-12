From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Resend PATCH V3 0/8]  usb/acpi: Add binding usb device with acpi
Date: Fri, 11 May 2012 17:26:15 -0700
Message-ID: <20120512002615.GA4203@kroah.com>
References: <1336723712-7686-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35544 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891Ab2ELA0T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 May 2012 20:26:19 -0400
Received: by dady13 with SMTP id y13so3694042dad.19
        for <linux-acpi@vger.kernel.org>; Fri, 11 May 2012 17:26:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336723712-7686-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com

On Fri, May 11, 2012 at 04:08:24PM +0800, Lan Tianyu wrote:
> This patchset's purppose is to bind usb device with associated
> acpi node. The ACPI method "_PLD" and "_UPC" can be used to
> identify usb port's connect type(hot-plug, hard-wired and
> not-used). The patchset also can work on the port without device
> connected.

I've applied the first 6 of these patches, see the review comment on the
7th one for why I stopped there.

thanks,

greg k-h
