From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [Resend PATCH V2 3/7] usb: Set device removable state based on ACPI USB data
Date: Fri, 4 May 2012 08:24:16 +0200
Message-ID: <201205040824.17010.oneukum@suse.de>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com> <1336100803-28353-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43301 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab2EDGqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 May 2012 02:46:39 -0400
In-Reply-To: <1336100803-28353-4-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>

Am Freitag, 4. Mai 2012, 05:06:39 schrieb Lan Tianyu:
> 
> From: Matthew Garrett <mjg@redhat.com>
> 
> ACPI offers two methods that allow us to infer whether or not a USB port
> is removable. The _PLD method gives us information on whether the port is
> "user visible" or not. If that's not present then we can fall back to the
> _UPC method which tells us whether or not a port is connectable.

How does this act on bluetooth devices that are (dis)connected by switches
on laptops?

	Regards
		Oliver
