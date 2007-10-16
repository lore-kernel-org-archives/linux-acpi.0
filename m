From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/2] Export a func to find the corresponding PCI
	bus:seg.func of an ACPI device
Date: Tue, 16 Oct 2007 09:12:33 +0800
Message-ID: <1192497153.16109.1.camel@sli10-conroe.sh.intel.com>
References: <1192465985.9847.585.camel@queen.suse.de>
	 <20071015164816.GA5021@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29733 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973AbXJPBOO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Oct 2007 21:14:14 -0400
In-Reply-To: <20071015164816.GA5021@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Christian Birchinger <joker@netswarm.net>, Len Brown <lenb@kernel.org>, ibm-acpi-devel <ibm-acpi-devel@lists.sourceforge.net>

On Mon, 2007-10-15 at 17:48 +0100, Matthew Garrett wrote:
> Why not just call acpi_get_pyhsical_device() on the appropriate handle 
> and look at the struct device you get back? Remember to put_device()
> it 
> once you're done.
Yes, for PCI bus, we already had a method to bind native device to ACPI
device. Other bus not.

Thanks,
Shaohua
