From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] - restore i8259A eoi status on resume
Date: Tue, 12 Sep 2006 14:40:50 +0100
Message-ID: <20060912134050.GA31858@srcf.ucam.org>
References: <20060910141533.GA6594@srcf.ucam.org> <20060912091906.GB19482@elf.ucw.cz> <20060912124742.GB31344@srcf.ucam.org> <200609121411.36913.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:8579 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030243AbWILNk4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Sep 2006 09:40:56 -0400
Content-Disposition: inline
In-Reply-To: <200609121411.36913.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Sep 12, 2006 at 02:11:36PM +0200, Andi Kleen wrote:

> Yes. I already have it queued for .19 at least. Not sure it's critical enough 
> for .18, especially since it doesn't seem to be a regression.

Yeah, I'd tend to agree.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
