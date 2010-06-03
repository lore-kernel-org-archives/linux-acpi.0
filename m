From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ACPI error messages
Date: Wed, 2 Jun 2010 21:52:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006022152080.24772-100000@netrider.rowland.org>
References: <1275527406.9119.8724.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:35695 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932590Ab0FCBwq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 21:52:46 -0400
In-Reply-To: <1275527406.9119.8724.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 3 Jun 2010, Zhang Rui wrote:

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

Okay.  Thanks for the help.

Alan Stern

