From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Date: Wed, 30 Aug 2006 20:43:17 +0100
Message-ID: <20060830194317.GA9116@srcf.ucam.org>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:61836 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751396AbWH3ToG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Aug 2006 15:44:06 -0400
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Adam Belay <abelay@novell.com>, "Brown, Len" <len.brown@intel.com>, ACPI ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org

On Wed, Aug 30, 2006 at 11:40:16AM -0700, Pallipadi, Venkatesh wrote:

(Added devel@laptop.org to the Cc:)

> While we are at cleaning up the code, I think it will be much better to 
> move out C-state policy out of this acpi code altogether. We should have

That would be helpful. For the One Laptop Per Child project (or whatever 
it's called today), it would be advantageous to run without acpi. At the 
moment that would cost us deeper C states, so an interface to allow a 
platform driver to register and provide the same functionality without 
code duplication would be helpful.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
