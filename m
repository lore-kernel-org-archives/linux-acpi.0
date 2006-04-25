From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] reverse pci config space restore order
Date: Tue, 25 Apr 2006 12:01:06 +0100
Message-ID: <20060425110106.GA26217@srcf.ucam.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD13D48A5@pdsmsx411.ccr.corp.intel.com> <20060425104800.GA26109@srcf.ucam.org> <1145962261.3114.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:5601 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932200AbWDYLBR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Apr 2006 07:01:17 -0400
Content-Disposition: inline
In-Reply-To: <1145962261.3114.23.camel@laptopd505.fenrus.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Yu, Luming" <luming.yu@intel.com>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:51:01PM +0200, Arjan van de Ven wrote:

> it has a second drawback: it assumes all devices HAVE a driver, which
> isn't normally the case...

Yeah, I guess there's a call for keeping a pci_save_entire_state type 
call and getting pci_device_suspend to use that in the no-driver case 
(also for the "Make my driver work again quickly" case, but still)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
