From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Sun, 1 Apr 2012 22:41:25 +0800
Message-ID: <20120401144125.GA2900@localhost.amd.com>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
 <1333258053.2939.22.camel@minggr>
 <20120401055603.GA11505@localhost.amd.com>
 <1333261737.2939.84.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:13724
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898Ab2DAGmR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Apr 2012 02:42:17 -0400
Content-Disposition: inline
In-Reply-To: <1333261737.2939.84.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafeal J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>

On Sun, Apr 01, 2012 at 02:28:57PM +0800, Lin Ming wrote:
> > 
> > There is no D3 hot support for this device(from the firmware's
> > perspective), either it is at D0(via _PS0), or it will be at D3 cold(via
> > _PS3).
> 
> But this is the generic code. We can't only consider some special
> device.
Agree.

The code change I've made only affects D3 cold path, existing code path
to set device power state to D0-D3hot is not affected.

And for D3 cold path, I don't think evaluating _PS3 should do any harm
to the device, isn't it the case?

> 
> Maybe we need some flag to tell which D3 state _PS3 is used for.
Do you mean the ACPI spec needs to be updated to reflect which D3
state the device will be at once its _PS3 is evaluated?

-Aaron

