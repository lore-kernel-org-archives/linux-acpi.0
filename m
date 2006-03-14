From: Danny Brow <dan@fullmotions.com>
Subject: Powers off after suspen to mem
Date: Mon, 13 Mar 2006 22:05:14 -0500
Message-ID: <1142305514.5275.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fms.tor.istop.com ([66.11.182.43]:57741 "EHLO
	resurrection.fullmotions.com") by vger.kernel.org with ESMTP
	id S932459AbWCNDBv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Mar 2006 22:01:51 -0500
Received: from offlander.local ([192.168.0.10])
	by resurrection.fullmotions.com (8.12.11/8.12.11) with ESMTP id k2E3BA3g018827
	for <linux-acpi@vger.kernel.org>; Mon, 13 Mar 2006 22:11:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

If I suspend to memory, ie. echo -n "mem" > /sys/power/state, upon a
resume (when I hit any key) my laptop just powers off, I see my X
session and the it drops to console and turns off. I'm running a 2.6.15
kernel with acpi patch for 2.6.15. My system is an Acer aspire 1694wlmi,
custom dsdt file.

Thanks,
Dan.

ps. I'm not on the list could you please cc me on your reply.


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

