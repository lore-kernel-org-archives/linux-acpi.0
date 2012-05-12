From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Sun, 13 May 2012 02:04:25 +0800
Message-ID: <4FAEA629.4080005@intel.com>
References: <Pine.LNX.4.44L0.1205111605560.1865-100000@iolanthe.rowland.org> <4FAEA23B.1010009@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29914 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064Ab2ELSE1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2012 14:04:27 -0400
In-Reply-To: <4FAEA23B.1010009@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On 2012/5/13 1:47, Lan Tianyu wrote:
> My main question is that how does usb_port_debounce() prevent the
> connect-change and enable-change bits to be off.
Sorry. a typo.
My main question is that how usb_port_debounce() prevents the
connect-change and enable-change bits to be on.

-- 
Best Regards
Tianyu Lan
linux kernel enabling team

