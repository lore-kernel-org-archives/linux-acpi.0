From: Colin Laurie <c_lauire@mypostoffice.co.uk>
Subject: How do I do an acpidump
Date: Fri, 15 Aug 2008 18:41:22 +0100
Message-ID: <200808151841.22788.c_lauire@mypostoffice.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nixdata3.netintelligence.com ([62.128.193.7]:60676 "helo
	mailfilter.iomart.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753937AbYHORqe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 13:46:34 -0400
Received: from gs-smta-02.broadbandscope.net (gs-smta-02-2.broadbandscope.net [81.140.160.216])
	by rbmf02.netintelligence.com (8.12.8/8.12.8) with ESMTP id m7FHfN0V017615
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2008 18:41:23 +0100
Received: from linux-gidt.localnet (host81-141-170-179.wlms-broadband.com [81.141.170.179])
	by gs-smta-02.broadbandscope.net (Postfix) with ESMTP id AE8273C003
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2008 18:41:23 +0100 (BST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello there you may/may not be interested in this:


Aug 15 16:18:48 linux-gidt kernel: Clocksource tsc unstable (delta = -124697887 ns)
Aug 15 16:18:48 linux-gidt kernel: nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
Aug 15 16:18:50 linux-gidt kernel: ACPI Exception (thermal-0458): AE_ERROR, ACPI thermal trip point 
state changed
Aug 15 16:18:50 linux-gidt kernel: Please send acpidump to linux-acpi@vger.kernel.org
Aug 15 16:18:50 linux-gidt kernel:  [20070126]
Aug 15 16:18:50 linux-gidt powersaved[2326]: WARNING (continueEvent:250) Could not execute program 
/usr/lib/powersave/scripts for event daemon.scheme.change: No such file or directory
Aug 15 16:19:06 linux-gidt nm-dispatcher.action: Script '/etc/NetworkManager/dispatcher.d/autofs' 
exited with error status 1.
Aug 15 16:19:07 linux-gidt ntpd[2492]: unable to bind to wildcard socket address 0.0.0.0 - another 
process may be running - EXITING
Aug 15 16:19:07 linux-gidt nm-dispatcher.action: Script '/etc/NetworkManager/dispatcher.d/nfs' 
exited with error status 2.
Aug 15 16:19:49 linux-gidt python: hp-systray(init)[2691]: warning: No hp: or hpfax: devices found 
in any installed CUPS queue. Exiting.
Aug 15 16:22:03 linux-gidt smartd[3144]: Problem creating device name scan list
Aug 15 17:52:28 linux-gidt kernel: hub 6-0:1.0: unable to enumerate USB device on port 5
Aug 15 17:52:29 linux-gidt hp: io/hpmud/pp.c 627: unable to read device-id ret=-1


-- 
E greetings from
	Colin Laurie

c_lauire@mypostoffice.co.uk or else the address used herewith


