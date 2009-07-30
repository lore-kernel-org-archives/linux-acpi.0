From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: USB runtime D3
Date: Thu, 30 Jul 2009 03:56:57 +0100
Message-ID: <20090730025657.GE26389@srcf.ucam.org>
References: <20090730020623.GB26389@srcf.ucam.org> <20090730023313.GA27493@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49162 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZG3C46 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2009 22:56:58 -0400
Content-Disposition: inline
In-Reply-To: <20090730023313.GA27493@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Jul 30, 2009 at 10:33:13AM +0800, Shaohua Li wrote:

> There are patches to support both ACPI based wakeup event and PCIe native
> wakeup event in below bugzilla, but it never gets into upstream. One problem
> is how to check which device under a bridge generates a wakeup event, because
> pci devices can share a wakeup event.
> There are discussion in pm list about the patches too, please search.

Yes, that would basically work for me. I'm still slightly curious as to 
why my hardware's not giving me the correct ACPI notification, though - 
I guess this may be entirely untested under Windows.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
