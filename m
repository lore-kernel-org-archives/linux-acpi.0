From: Rui Wang <rui.y.wang@intel.com>
Subject: Re: [PATCH 2/2] x86/ioapic: Fix wrong pointers in ioapic_setup_resources()
Date: Wed,  8 Jun 2016 08:07:19 +0800
Message-ID: <1465344439-3373-1-git-send-email-rui.y.wang@intel.com>
References: <alpine.DEB.2.11.1606071111100.28031@nanos>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51007 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287AbcFHAXs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jun 2016 20:23:48 -0400
In-Reply-To: <alpine.DEB.2.11.1606071111100.28031@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de
Cc: rjw@rjwysocki.net, tony.luck@intel.com, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rui.y.wang@intel.com

On Tuesday, June 7, 2016 5:17 PM, Thomas Gleixner wrote:
> On Tue, 7 Jun 2016, Rui Wang wrote:
> > Also simplify the function by removing the redundant 'num' variable.

> Please don't do that. This makes the patch hard to read. Split this into a
> minimal bugfix, which can be backported and a cleanup patch which gets rid of
> the extra variable.
 
> > -		ioapics[i].iomem_res = res;
> > +		ioapics[i].iomem_res = &res[i];
>
> If I read the patch correctly, then this is the fix. Right? So please make it
> a one liner and send a cleanup patch seperately.

Hi Thomas,

Yes exactly. I'll send a v2.

Thanks
Rui


