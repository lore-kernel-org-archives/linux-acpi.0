From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/10] acpi4asus updates (eeepc-laptop,
 asus_acpi and asus-laptop)
Date: Tue, 20 Jan 2009 14:41:22 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901201438310.5575@localhost.localdomain>
References: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37014 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbZATTlr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jan 2009 14:41:47 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDS002J2C10XUN4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 20 Jan 2009 13:41:25 -0600 (CST)
In-reply-to: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org


Thanks for the refresh Corentin.  I've checked these into the ACPI tree.
Given that they are driver specific, I think I'll ask forgivness
for missing the merge window and submit them for upstream with
the next batch.
--
Len Brown, Intel Open Source Technology Center

On Tue, 20 Jan 2009, Corentin Chary wrote:

> Hi len,
> Here is a group of update for asus related platform drivers.
> You can also pull  git://git.iksaif.net/acpi4asus.git acpi4asus
> Thanks
> 
> Corentin Chary (7):
>   eeepc-laptop: split eeepc_backlight_exit()
>   asus_acpi: Add R1F support
>   asus-laptop: use generic netlink interface
>   asus-laptop: hotkeys via the generic input interface
>   asus-laptop: update Kconfig for input layer
>   asus-laptop: fix label indentation
>   eeepc-laptop: use netlink interface
> 
> Matthew Garrett (3):
>   eeepc-laptop: Add support for extended hotkeys
>   eeepc-laptop: Check return values from rfkill_register
>   eeepc-laptop: Implement rfkill hotplugging in eeepc-laptop
> 
>  drivers/platform/x86/Kconfig        |    1 +
>  drivers/platform/x86/asus-laptop.c  |  176 ++++++++++++++++++++++++++++++++--
>  drivers/platform/x86/asus_acpi.c    |   16 +++-
>  drivers/platform/x86/eeepc-laptop.c |  161 ++++++++++++++++++++++++++++----
>  4 files changed, 323 insertions(+), 31 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
