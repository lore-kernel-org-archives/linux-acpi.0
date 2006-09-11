From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: io-apic - no timer ticks after resume on IXP200
Date: Mon, 11 Sep 2006 12:05:30 +0100
Message-ID: <20060911110530.GA15320@srcf.ucam.org>
References: <20060910141533.GA6594@srcf.ucam.org> <20060910223308.GA1691@elf.ucw.cz> <20060911003129.GA10600@srcf.ucam.org> <200609110746.58548.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:51385 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750782AbWIKLFi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Sep 2006 07:05:38 -0400
Content-Disposition: inline
In-Reply-To: <200609110746.58548.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Sep 11, 2006 at 07:46:58AM +0200, Andi Kleen wrote:

> You forgot to mention on which kernel version you're seeing this?
> In particular did it work in some kernel version and then stop in another?

Oops, sorry. I'm using 2.6.17.11, but the problem appears to persist in 
the latest 2.6.18-rc. Does your board have a timer override?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
