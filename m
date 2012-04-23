From: Panagiotis Papadakos <papadako@ics.forth.gr>
Subject: Sony CR21/Z laptop (Latency problems related to ACPI?)
Date: Mon, 23 Apr 2012 15:18:48 +0300
Message-ID: <5612856.clGBGkmtMC@cray-7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:32388 "EHLO
	mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab2DWM3i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Apr 2012 08:29:38 -0400
Received: from av1.ics.forth.gr (smtp-out.ics.forth.gr. [139.91.1.71])
	by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id q3NCJ48e084851
	for <linux-acpi@vger.kernel.org>; Mon, 23 Apr 2012 15:19:14 +0300 (EEST)
Received: from cray-7.localnet (mythos@mikroulhs.ics.forth.gr [139.91.183.24] (may be forged))
	(authenticated bits=0)
	by enigma.ics.forth.gr (8.14.3//ICS-FORTH/V10.3.0C-EXTNULL-SSL-SASL) with ESMTP id q3NCJDwq021387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 23 Apr 2012 15:19:14 +0300
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello.

I have been using a cr21/z laptop which probably has
acpi related problems that introduce latency. I noticed
it because a recent update in my Ubuntu precise
makes my system's clock stay behind, and freezes
my laptop when there are no mouse or keyboard actions.

Somehow it looks related to https://bugzilla.kernel.org/show_bug.cgi?id=20172
 
If I boot my kernel with noapictimer clocksource=jiffies irqpoll
options the system reacts to my actions instantly. It is the first
time that I have exprerience lag free reactions from my system.
Unfortunately there are spikes of 100% CPU usage, due to irq polling I assume,
which makes my system less power efficient.

Is there any case that we can somehow fix this problem?

I am using latest git kernel. The same problem also exists
in current Ubuntu precise 3.2 kernel.

Thank you in advance.

Panagiotis Papadakos
