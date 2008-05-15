From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware doesn't define one
Date: Thu, 15 May 2008 13:02:34 +0100
Message-ID: <20080515120234.GA23538@srcf.ucam.org>
References: <20080514010000.GB21608@srcf.ucam.org> <20080514010300.GC21608@srcf.ucam.org> <20080514010820.GD21608@srcf.ucam.org> <200805132330.20159.lenb@kernel.org> <87iqxfzt4f.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43128 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbYEOMDD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 08:03:03 -0400
Content-Disposition: inline
In-Reply-To: <87iqxfzt4f.fsf@basil.nowhere.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thu, May 15, 2008 at 01:47:28PM +0200, Andi Kleen wrote:

> Wouldn't it be possible to add a D610 specific quirk that 
> simply adds a trip point for that machine only?
> 
> As long as the problem is not wide-spread over many models
> a quirk is a reasonable solution.

There are plenty of other machines that have this issue, but there 
doesn't seem to be any especially good pattern to them. In marginal 
cases it may even depend on the manufacturing batch.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
