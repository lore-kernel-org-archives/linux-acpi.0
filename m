From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Quirking acpi_enforce_resources
Date: Mon, 1 Mar 2010 22:04:18 +0000
Message-ID: <20100301220418.GA24957@srcf.ucam.org>
References: <1267477297.15581.152.camel@cndougla-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49696 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab0CAWEU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 17:04:20 -0500
Content-Disposition: inline
In-Reply-To: <1267477297.15581.152.camel@cndougla-ubuntu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chase Douglas <chase.douglas@ubuntu.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Mar 01, 2010 at 04:01:37PM -0500, Chase Douglas wrote:
> Hello,
> 
> I've noticed there are a lot of bugs filed against Ubuntu due to the
> changes that introduced strict resource checking between the acpi driver
> and legacy hardware monitor drivers [1]. Although I understand the
> reason for the strict checking, the legacy drivers seemed to work fine.
> I'm unaware of any real issues that were caused by using them.

They'll work absolutely fine until both ACPI and the native driver 
attempt to use the bus simultaneously, at which point there's a risk 
that you'll end up writing to the wrong register and causing hardware 
damage. The probability of this is tiny - you'd need two uncommon things 
to happen at exactly the same time. That doesn't mean it's safe.

> Thus, I'm wondering if it would be worthwhile to whitelist machines 
> that are known to work OK even with the resources being doubly held by 
> both the acpi driver and a legacy driver. It certainly does not seem 
> prudent to set acpi_enforce_resources=lax across the board, but the 
> change to strict resource checking seems to have done more harm than 
> good for the average user.

The average user now has no chance of this causing a spurious system 
shutdown due to a false temperature reading, and also no chance of this 
causing invalid values to be written to a device causing it to brick the 
hardware. If users are willing to accept the (admittedly small) risk, 
they get to pass the argument. It's not reasonable for the upstream 
kernel to do this.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
