From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 06/11] misc,acpi,backlight: compal Laptop Extras
Date: Tue, 10 Jun 2008 12:55:20 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806101253390.14381@localhost.localdomain>
References: <200806092322.m59NMNs9013970@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:49413 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbYFJQ6Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jun 2008 12:58:24 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K29006EZAP9UFCH@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 10 Jun 2008 11:48:47 -0500 (CDT)
In-reply-to: <200806092322.m59NMNs9013970@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, cezary.jackiewicz@gmail.com, aystarik@gmail.com, hmh@hmh.eng.br, rpurdie@rpsys.net



On Mon, 9 Jun 2008, akpm@linux-foundation.org wrote:

> From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
> 
> This is driver for Compal Laptop: FL90/IFL90, based on MSI driver.
> 
> This driver exports a few files in /sys/devices/platform/compal-laptop/:
>  lcd_level - screen brightness: contains a single integer in the range 0..7 (rw)

why is it a good idea to implement this platform specific lcd_level API
and at the same time implement the generic backlight API?

thanks,
-Len
