From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [Resend PATCH V2 7/7] usb/acpi: add usb check for the connect type of usb port
Date: Fri, 4 May 2012 08:37:55 +0200
Message-ID: <201205040837.55905.oneukum@suse.de>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com> <1336100803-28353-8-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43327 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab2EDGqo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 May 2012 02:46:44 -0400
In-Reply-To: <1336100803-28353-8-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com

Am Freitag, 4. Mai 2012, 05:06:43 schrieb Lan Tianyu:
> +enum usb_port_connect_type {
> +       USB_PORT_CONNECT_TYPE_UNKNOWN = 0,
> +       USB_PORT_CONNECT_TYPE_HOT_PLUG,
> +       USB_PORT_CONNECT_TYPE_HARD_WIRED,
> +       USB_PORT_NOT_USED,
> +};

Is this actually useful? If we have ports known to ACPI (eg. hotplugged PCcard)
we must assume the ports are fully hotpluggable.

	Regards
		Oliver
