From: Panagiotis Papadakos <papadako@ics.forth.gr>
Subject: Re: Sony CR21/Z laptop (Latency problems related to ACPI?)
Date: Mon, 23 Apr 2012 22:37:56 +0300
Message-ID: <3016996.TpuJ1apcko@cray-7>
References: <5612856.clGBGkmtMC@cray-7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:16330 "EHLO
	mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab2DWTiP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Apr 2012 15:38:15 -0400
Received: from av1.ics.forth.gr (smtp-out.ics.forth.gr. [139.91.1.71])
	by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id q3NJcBqa093805
	for <linux-acpi@vger.kernel.org>; Mon, 23 Apr 2012 22:38:13 +0300 (EEST)
Received: from cray-7.localnet (mythos@mikroulhs.ics.forth.gr [139.91.183.24] (may be forged))
	(authenticated bits=0)
	by enigma.ics.forth.gr (8.14.3//ICS-FORTH/V10.3.0C-EXTNULL-SSL-SASL) with ESMTP id q3NJcB3t017859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 23 Apr 2012 22:38:11 +0300
In-Reply-To: <5612856.clGBGkmtMC@cray-7>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Well, it seems that I only need noapic in my kernel options.
Also I guess this is a motherboard or BIOS bug right?

Thanks in advance.

On Monday 23 of April 2012 15:18:48 Panagiotis Papadakos wrote:
> Hello.
> 
> I have been using a cr21/z laptop which probably has
> acpi related problems that introduce latency. I noticed
> it because a recent update in my Ubuntu precise
> makes my system's clock stay behind, and freezes
> my laptop when there are no mouse or keyboard actions.
> 
> Somehow it looks related to
> https://bugzilla.kernel.org/show_bug.cgi?id=20172
> 
> If I boot my kernel with noapictimer clocksource=jiffies irqpoll
> options the system reacts to my actions instantly. It is the first
> time that I have exprerience lag free reactions from my system.
> Unfortunately there are spikes of 100% CPU usage, due to irq polling I
> assume, which makes my system less power efficient.
> 
> Is there any case that we can somehow fix this problem?
> 
> I am using latest git kernel. The same problem also exists
> in current Ubuntu precise 3.2 kernel.
> 
> Thank you in advance.
> 
> Panagiotis Papadakos
