From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 08:37:13 +0100
Message-ID: <20060420073713.GA25735@srcf.ucam.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:8872 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750742AbWDTHhS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 03:37:18 -0400
Content-Disposition: inline
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 01:45:27PM +0800, Yu, Luming wrote:

> Do you plan to port the whole acpi event interface into input layer?
> If so,  keycode is NOT a right way.

Not really, though it would be one possibility. However, the input layer 
doesn't really provide the flexibility needed for certain events. I'm 
not sure what the right answer is for other events, but I'm pretty sure 
the button driver maps onto the input layer sensibly.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
