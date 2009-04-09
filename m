From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPICA: delete check for AML access to port 0x81-83
Date: Thu, 9 Apr 2009 07:23:46 +0100
Message-ID: <20090409062346.GA8101@srcf.ucam.org>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com> <alpine.LFD.2.00.0904071754230.4799@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48021 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbZDIGXz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Apr 2009 02:23:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904071754230.4799@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Rodrigo Luiz <rodrigo@gus-mg.org>, malattia@linux.it, linux-acpi@vger.kernel.org

On Tue, Apr 07, 2009 at 05:56:09PM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Sony laptops apparently write 4-bytes (rather than 1 byte)
> to debug port 0x80, which spews error messages:

So admittedly I should just check the spec here instead, but: what does 
a 4 byte write to an io port mean? It seems a bit odd that Sonys could 
be scribbling over DMA1 without causing any problems. Is Windows turning 
this into a single byte write to the defined io port instead?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
