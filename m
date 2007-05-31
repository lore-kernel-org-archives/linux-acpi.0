From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [KJ] [PATCH] drivers/acpi: sizeof/sizeof array size calculations replaced with ARRAY_SIZE
Date: Thu, 31 May 2007 10:56:03 +0100
Message-ID: <20070531095603.GA24654@infradead.org>
References: <200705261239.27485.lists-receive@programmierforen.de> <46581C06.7000005@student.ltu.se> <200705261558.24912.lists-receive@programmierforen.de> <200705301525.05905.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:52049 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757368AbXEaJ4K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 May 2007 05:56:10 -0400
Content-Disposition: inline
In-Reply-To: <200705301525.05905.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Drebes <lists-receive@programmierforen.de>, kernel-janitors@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 30, 2007 at 03:25:05PM -0400, Len Brown wrote:
>  
> > > Any reason to not just replace ACPI_RSD_TABLE_SIZE with ARRAY_SIZE?
> 
> Probably because ARRAY_SIZE doesn't exist in ACPICA, which is
> where this code comes from...
> 
> When we change syntax in ACPICA files in Linux to make it more "beautiful",
> then it creates more work for me -- as forever on, that syntax difference
> must be manually compared to upstream ACPICA and Linux -- and that syntax
> difference causes upstream patches to no longer apply and require
> hand merging.

Or we could stop that ACPCICA crap ASAP.  The acpi code not only looks
like crap because of that but it's buggy as hell now.

Intel is claiming how great linux is and how supportive is to it, but
can't even write proper code for their abomination of a firmware standard.
This is really more than dishonest.  Please take patches to get acpi into
shape and stop this complaining.

