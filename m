From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI error messages
Date: Thu, 3 Jun 2010 15:16:43 +0100
Message-ID: <20100603141643.GA768@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1006021105590.1992-100000@iolanthe.rowland.org> <1275527406.9119.8724.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44575 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab0FCOQv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2010 10:16:51 -0400
Content-Disposition: inline
In-Reply-To: <1275527406.9119.8724.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Jun 03, 2010 at 09:10:06AM +0800, Zhang Rui wrote:

> This is a BIOS bug to me. The code runs in this way:
> 
> if (not Win7)
>   good BIOS code
> else
>   buggy BIOS code
> 
> This is a regression because ACPI declares it's win7 compatible in
> 2.6.31. I'm afraid we can do nothing in Linux kernel to fix/workaround
> it. IMO, we should ping Asus to fix it in their new BIOS release.

So if you install Windows 7 on these machines, backlight control doesn't 
work?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
