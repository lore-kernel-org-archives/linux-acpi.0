From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi/blacklist: enable OSI(Linux) on newer eeepc
Date: Mon, 23 Nov 2009 11:24:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911231113520.858@localhost.localdomain>
References: <1258752548-9299-1-git-send-email-corentincj@iksaif.net>
 <20091121184503.GA15141@srcf.ucam.org>
 <71cd59b00911211322t45be6c92g2a0c78c03d7eb5e9@mail.gmail.com>
 <20091121232815.GA17749@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:46764 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169AbZKWQYk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2009 11:24:40 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTK00HK3LL32P2U@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 23 Nov 2009 10:24:42 -0600 (CST)
In-reply-to: <20091121232815.GA17749@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

On Sat, 21 Nov 2009, Matthew Garrett wrote:

> On Sat, Nov 21, 2009 at 10:22:45PM +0100, Corentin Chary wrote:
> 
> > I think we could add that patch to 2.6.32, then revert it in 2.6.33 (or later)
> > when a eeepc-wmi driver (or wmi support inside eeepc-laptop) is available.
> > And I don't think such a driver (patch) will be available before 2.6.32.
> > 
> > That means that owner of 1000h and 1005ha won't be able to use eeepc-laptop
> > (camera, rfkill, hotkeys) without adding acpi_osi="Linux" manually in 2.6.32.
> > 
> > I know this is not a long term solution.
> 
> The reason I'm not keen is that hardware vendors seem to continue 
> believing that Linux claims to be Linux - it's almost understandable for 
> Asus when they're shipping 2.6.remotely_exploitable on their hardware, 
> but Lenovo are still doing it for no obvious reason. I'm worried that 
> even doing a single release with this defined will result in Asus 
> pulling the same trick at some point in the future.

I agree with Matthew that this is distasteful -- particularly
since the models in question came out well after upstream Linux
stopped setting OSI(Linux) (2.6.32).

However, I think the fact that this DMI is specific to the 1000h and 
1005ha makes it less scary.

Matthew,
blacklist.c shows only 3 specific Lenovo models where we DMI enable 
OSI(Linux).  Is that causing Lenovo to ship additional models,
as yet un-documented, that depend on OSI(Linux)?

thanks,
-Len Brown
Intel Open Source Technology Center

