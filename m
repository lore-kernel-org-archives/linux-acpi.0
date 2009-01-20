From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] eeepc-laptop: split eeepc_backlight_exit()
Date: Tue, 20 Jan 2009 11:40:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901201137350.5575@localhost.localdomain>
References: <1232301715-20292-1-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-2-git-send-email-corentincj@iksaif.net>
 <200901181911.05619.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38458 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088AbZATQk2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jan 2009 11:40:28 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDS00DOX3NFKUD2@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 20 Jan 2009 10:40:27 -0600 (CST)
In-reply-to: <200901181911.05619.corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org



--
Len Brown, Intel Open Source Technology Center

On Sun, 18 Jan 2009, Corentin Chary wrote:

> Arg .. don't know what I did, but I clearly messed up with git-send-email.
> 
> Isn't git send-email --compose --to linux-acpi@vger.kernel.org --cc 
> lenb@kernel.org  *patch the right command line ?
> 
> It seems the intro email was lost in the process:
> 
> > Hi Len,
> > Here are some patch for asus platform drivers.
> > The last one is the most interesting, it adds 
> > input layer support for reporting hotkeys.


yes, it is correct, and I received the intro message.
I use this.

git send-email --from "Len Brown <lenb@kernel.org>" --compose --to 
linux-acpi@vger.kernel.org  --suppress-from --no-chain-reply-to 
patch-release

Note that you can assume i'm on linux-acpi, so you don't
have to cc me.  The intro message is helpful, however,
so I know if you think the patches are for testing
or you think they're ready for release.

cheers,
-Len

