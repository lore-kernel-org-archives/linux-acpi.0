From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: Re: Debugging spurious wakeup
Date: Fri, 15 May 2015 09:52:36 +0200
Message-ID: <20150515075236.GA14918@sottospazio.it>
References: <20150513065825.GA10680@sottospazio.it>
 <20150514125148.GA9039@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m-r2.th.seeweb.it ([5.144.164.171]:58298 "EHLO
	m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030224AbbEOHwx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2015 03:52:53 -0400
Received: from fseek.strangled.net (host112-190-dynamic.24-79-r.retail.telecomitalia.it [79.24.190.112])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 71C143F498
	for <linux-acpi@vger.kernel.org>; Fri, 15 May 2015 09:52:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150514125148.GA9039@sottospazio.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Thu, May 14, 2015 at 02:51:48PM +0200, Gianluca Anzolin wrote:
> I'm sorry to bother again but since the previous debug aids didn't go
> anywhere I'm here to ask again if there is a command, a debug parameter,
> something that could tell me the cause of the last system wake up.
> 
> I'm aware that in Windows there is the command "powercfg -lastwake", I need
> something similar for linux, since this issue is linux specific (I can't
> reproduce it in Windows).
> 
> Thank you,
> 
> Gianluca
> 

Hello,

since I can reproduce the issue so easily I tried to take the output of lspci
-vvvxxx when the system stays off and when it turns on by itself.

The diff between the two outputs is mainly due to changes of IRQs and
addresses but there is something else:

-               RootSta: PME ReqID 0000, PMEStatus- PMEPending-
+               RootSta: PME ReqID 0400, PMEStatus- PMEPending-

for this entry:

00:1c.5 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI
Express Root Port 6 (rev b5) (prog-if 00 [Normal decode])

Basically when PME ReqID is 0400 the system turn on. I don't really know what
that means but I noticed that the PCIe port is connected to the network
controller.

This is the output of lspci -t:

-[0000:00]-+-00.0
           +-01.0-[01]--+-00.0
           |            \-00.1
           +-06.0-[02]--
           +-16.0
           +-1a.0
           +-1b.0
           +-1c.0-[03]--
           +-1c.5-[04]----00.0
           +-1c.6-[05]----00.0
           +-1c.7-[06]----00.0
           +-1d.0
           +-1e.0-[07]----03.0
           +-1f.0
           +-1f.2
           \-1f.3


And this is the entry 04:00.0:

04:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
Connection

So it's really the ethernet driver that's misbehaving?

Thank you,

Gianluca
