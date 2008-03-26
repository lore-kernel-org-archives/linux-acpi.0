From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Determine power-on cause?
Date: Wed, 26 Mar 2008 17:15:39 +0100
Message-ID: <20080326161539.GA2757@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:44206
	"EHLO schlidder.svs.informatik.uni-oldenburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756531AbYCZQl2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Mar 2008 12:41:28 -0400
Received: from walker.pmhahn.de (walker.svs.informatik.uni-oldenburg.de [134.106.22.73])
	by schlidder.svs.informatik.uni-oldenburg.de (Postfix) with ESMTP id CEDAF54085
	for <linux-acpi@vger.kernel.org>; Wed, 26 Mar 2008 17:15:39 +0100 (CET)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello!

Is it possible to determine the cause for power-on, that is
	push of power-button on chassis
	automatic power-on after power-loss (BIOS: return to previous state/on)
	wake-on-lan
	wake by RTC / ACPI-alarm
	etc...

I ask because I have a PC which I use for desktop work and for video
recording. I'd like my PC to
1. power on via RTC just before a scheduled recording, not starting any
desktop environment or server software,
2. start my desktop environment when I push the power-on-button
3. start some server-software when I wake up the PC via wake-on-lan
4. check for scheduled recordings after a power failure and power-off
until than.

	dmidecode -t 1 | grep "Wake-up Type"
seems to be static and never changes on my 2 test-pcs and 2 laptops.

That you for your advice in advance.
Please cc-me on replies since I'm not subscribed to linux-acpi.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
