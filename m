From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] reverse pci config space restore order
Date: Tue, 25 Apr 2006 11:48:00 +0100
Message-ID: <20060425104800.GA26109@srcf.ucam.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD13D48A5@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:30592 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932182AbWDYKsG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Apr 2006 06:48:06 -0400
Content-Disposition: inline
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD13D48A5@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 02:50:57PM +0800, Yu, Luming wrote:

> -	for (i = 0; i < 16; i++)
> +	for (i = 15; i >= 0 ; i--)

We certainly need to do /something/ here, but I'm not sure this is it. 
Adam Belay has code to limit PCI state restoration to the PCI-specified 
registers, with the idea being that individual drivers fix things up 
properly. While this has the obvious drawback that almost every PCI 
driver in the tree would then need fixing up, it's also probably the 
right thing.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
