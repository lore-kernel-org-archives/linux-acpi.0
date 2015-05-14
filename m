From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: Re: Debugging spurious wakeup
Date: Thu, 14 May 2015 14:51:48 +0200
Message-ID: <20150514125148.GA9039@sottospazio.it>
References: <20150513065825.GA10680@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m-r2.th.seeweb.it ([5.144.164.171]:57756 "EHLO
	m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688AbbENMvx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2015 08:51:53 -0400
Received: from fseek.strangled.net (host112-190-dynamic.24-79-r.retail.telecomitalia.it [79.24.190.112])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 276773F43F
	for <linux-acpi@vger.kernel.org>; Thu, 14 May 2015 14:51:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150513065825.GA10680@sottospazio.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Wed, May 13, 2015 at 08:58:25AM +0200, Gianluca Anzolin wrote:
> So I'm here to ask if there is a way to get the source/cause of the last
> wakeup by setting some ACPI debug option. This way I could at least pinpoint
> the device/interface that caused the spontaneous wakeup and then debug
> further or at least disable it.
> 
> I've tried to enable the ACPI hardware-related messages with the kernel
> arguments: acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
> 

Hello,

I'm sorry to bother again but since the previous debug aids didn't go anywhere
I'm here to ask again if there is a command, a debug parameter, something that
could tell me the cause of the last system wake up.

I'm aware that in Windows there is the command "powercfg -lastwake", I need
something similar for linux, since this issue is linux specific (I can't
reproduce it in Windows).

Thank you,

Gianluca

