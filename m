From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 13:15:07 -0700
Message-ID: <20120511201507.GG18754@xanatos>
References: <4FAD3A51.4010803@intel.com>
 <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
 <4CFBC02C07DA244CA19D6815A05BE6EE0A6910@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63280 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932805Ab2EKUPL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 16:15:11 -0400
Content-Disposition: inline
In-Reply-To: <4CFBC02C07DA244CA19D6815A05BE6EE0A6910@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lan, Tianyu" <tianyu.lan@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "lenb@kernel.org" <lenb@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Fri, May 11, 2012 at 07:54:04PM +0000, Lan, Tianyu wrote:
> On 2012/5/12 1:44, Alan Stern wrote:
> > This doesn't matter.  Disconnections will be handled by 
> > usb_reset_and_verify_device(), when it is called by 
> > finish_port_resume().
> This will cause the device to be re-enumerated. Just like
> unplugged and plugged a device. I think this is not what
> we want.  Disconnect and create the same device. device
> num is also change.

Tianyu, do you have CONFIG_USB_PERSIST turned on?

Alan, do you know if that will that only help in this case after the
host controller PCI device is in D3hot?

Sarah Sharp
