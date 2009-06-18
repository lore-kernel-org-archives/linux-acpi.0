From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/15] acpi4asus updates
Date: Wed, 17 Jun 2009 22:41:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906172241040.8921@localhost.localdomain>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:57242 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbZFRDPx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jun 2009 23:15:53 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLE00EK7Y4SRSM1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 17 Jun 2009 21:41:22 -0500 (CDT)
In-reply-to: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org

applied

thanks,
Len Brown, Intel Open Source Technology Center

On Tue, 16 Jun 2009, Corentin Chary wrote:

> Hi Len,
> It's mainly new features for eeepc-laptop and bugfix.
> 
> There is also some change for asus-laptop, which is no
> longer marked as EXPERIMENTAL, when asus_acpi is now
> DEPRECATED.
> 
> You can directly pull from the git tree if you want
>   git://git.iksaif.net/acpi4asus.git for-next
> 
> Thanks
> 
> Corentin Chary (11):
>   asus-laptop: platform dev as parent for led and backlight
>   acpi4asus: update MAINTAINER and KConfig links
>   asus_acpi: Deprecate in favor of asus-laptop
>   asus-laptop: use pr_fmt and pr_<level>
>   eeepc-laptop: rfkill refactoring
>   eeepc-laptop: right parent device
>   eeepc-laptop: sync eeepc-laptop with asus_acpi
>   eeepc-laptop: makes get_acpi() returns -ENODEV
>   eeepc-laptop: get the right value for CMSG
>   eeepc-laptop: add rfkill support for the 3G modem in Eee PC 901 Go
>   eeepc-laptop: cpufv updates
> 
> Joe Perches (1):
>   eeepc-laptop.c: use pr_fmt and pr_<level>
> 
> Matthew Garrett (1):
>   eeepc-laptop: Register as a pci-hotplug device
> 
> Pekka Enberg (1):
>   eeepc-laptop: enable camera by default
> 
> Randy Dunlap (1):
>   eeepc: fix kconfig selects
> 
>  MAINTAINERS                         |    8 +-
>  drivers/platform/x86/Kconfig        |   17 +-
>  drivers/platform/x86/asus-laptop.c  |   92 ++++----
>  drivers/platform/x86/eeepc-laptop.c |  502 +++++++++++++++++++++++++----------
>  4 files changed, 428 insertions(+), 191 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
