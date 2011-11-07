From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] X86: Solve Dell Latitudes do not reboot on x86_64 more
 generally
Date: Mon, 7 Nov 2011 15:12:13 +0000
Message-ID: <20111107151213.GA20270@srcf.ucam.org>
References: <4EB39139.3090709@suse.de>
 <201111071525.14255.trenn@suse.de>
 <20111107142740.GA17686@srcf.ucam.org>
 <201111071609.54731.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38887 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab1KGPMQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Nov 2011 10:12:16 -0500
Content-Disposition: inline
In-Reply-To: <201111071609.54731.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, stable@kernel.org

On Mon, Nov 07, 2011 at 04:09:54PM +0100, Thomas Renninger wrote:
> On Monday, November 07, 2011 03:27:40 PM Matthew Garrett wrote:
> > Tear down VT-D state before reboot.
> But doing this for all X86 machines because of a handful of
> Dells with broken SMM code sounds wrong as well.

We've already torn everything down at this point. What's the downside?

> Doesn't Dell ship with Ubuntu pre-loaded?
> Can't someone point them to this to get this fixed in BIOS?

I've been trying.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
