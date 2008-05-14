From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware doesn't define one
Date: Wed, 14 May 2008 10:33:04 +0100
Message-ID: <20080514093304.GB28678@srcf.ucam.org>
References: <20080514010000.GB21608@srcf.ucam.org> <20080514010300.GC21608@srcf.ucam.org> <20080514010820.GD21608@srcf.ucam.org> <200805132330.20159.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:57457 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756096AbYENJd0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 05:33:26 -0400
Content-Disposition: inline
In-Reply-To: <200805132330.20159.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tue, May 13, 2008 at 11:30:20PM -0400, Len Brown wrote:

> An entire new handheld product line will ship this year
> where the assumption that the processor is the primary
> contributor to heat may simply be _false_, thermal
> zones may be totally unrelated to the processor,
> and throttling the processor may be exactly the
> wrong way to handle a thermal issue.

That's fine. In the ACPI code, we currently have no support for managing 
thermal conditions through anything other than the processor. Once that 
changes, it's easy to fix this up so it doesn't interfere with thermal 
zones that are handled by throttling other devices.

Menlow has a more complex thermal model than machines we've seen up to 
now, but I was under the impression that this was to be handled by the 
new generic thermal class rather than the existing ACPI code. I don't 
see this patch as being in conflict with supporting that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
