From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Mutex not acquired on Dell 700m
Date: Wed, 5 Jul 2006 09:07:36 +0000 (UTC)
Message-ID: <e8fvgo$n73$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:23001 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964929AbWGERuG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2006 13:50:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FyBVi-0005Qg-9Y
	for linux-acpi@vger.kernel.org; Wed, 05 Jul 2006 19:50:02 +0200
Received: from mail.globalcapital.cc ([80.85.66.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 05 Jul 2006 19:50:02 +0200
Received: from wildfire by mail.globalcapital.cc with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 05 Jul 2006 19:50:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

When I suspend/resume my laptop (to memory) I get the following messages
(via dmesg):

ACPI Error (exmutex-0248): Cannot release Mutex [MUTX], not acquired [20060608]
ACPI Error (psparse-0523): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.RAMR] (Node b18b59dc), AE_AML_MUTEX_NOT_ACQUIRED
ACPI Error (psparse-0523): Method parse/execution failed [\_TZ_.THRC._TMP] (Node b18bd93c), AE_AML_MUTEX_NOT_ACQUIRED

Whilst I have a Dell 700m, I have the had the motherboard replaced to
correct for the sound design flaw (so the motherboard self-identifies as a
710m).  Otherwise this is stock BIOS and 2.6.17 - let me know (via a CC)
if any further information is required to track this done.

Cheers,
Anand

