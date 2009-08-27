From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 5/9] acerhdf: fix fan control for AOA150 model
Date: Thu, 27 Aug 2009 14:00:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908271359590.21742@localhost.localdomain>
References: <200908062257.n76MvrRa024247@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:64536 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbZH0SBK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Aug 2009 14:01:10 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP1005VDRDJ6Q21@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Aug 2009 13:01:02 -0500 (CDT)
In-reply-to: <200908062257.n76MvrRa024247@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, peter@piie.net, andi@lisas.de, petkovbb@googlemail.com

applied to acpi-test for 2.6.32

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 6 Aug 2009, akpm@linux-foundation.org wrote:

> From: Peter Feuerer <peter@piie.net>
> 
> - Apply Borislav Petkov's patch (convert the fancmd[] array to a real
>   struct thus disambiguating command handling and making code more
>   readable.)
> 
> - Add BIOS product to BIOS table as AOA110 and AOA150 have different
>   register values
> 
> - Add force_product parameter to allow forcing different product
> 
> - fix linker warning caused by "acerhdf_drv" not being named
>   "acerhdf_driver"
> 
> Signed-off-by: Peter Feuerer <peter@piie.net>
> Cc: Andreas Mohr <andi@lisas.de>
> Cc: Borislav Petkov <petkovbb@googlemail.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/platform/x86/acerhdf.c |   97 +++++++++++++++++++++----------
>  1 file changed, 66 insertions(+), 31 deletions(-)

