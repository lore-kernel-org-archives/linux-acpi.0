From: Martin Larsson <morg@borgeby.se>
Subject: C-States problems with Zepto
Date: Wed, 11 Jul 2007 18:48:41 +0200
Message-ID: <469509E9.1020401@borgeby.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:37902 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbXGKRJq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jul 2007 13:09:46 -0400
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP id B9E8438016
	for <linux-acpi@vger.kernel.org>; Wed, 11 Jul 2007 18:49:04 +0200 (CEST)
Received: from borgeby (h191n1fls32o985.telia.com [213.65.17.191])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id A3B1C37E47
	for <linux-acpi@vger.kernel.org>; Wed, 11 Jul 2007 18:49:04 +0200 (CEST)
Received: from [192.168.1.4] (my.router [192.168.1.1])
	by borgeby (Postfix) with ESMTP id 58535BC588
	for <linux-acpi@vger.kernel.org>; Wed, 11 Jul 2007 18:49:04 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi

I don't think this is a problem that can or should be fixed by the acpi
team, but I was hoping for some advice and maybe someone knows a solution.

I have a Zepto Znote 6024W with an intel core 2 duo T7100 and intel
965gm chipset. The problem is that it only reports down to C2 state, ie
i get this message in dmesg:
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: CPU1 (power states: C1[C1] C2[C2])

I have the bios set to default and it says extended (or enhanced, not
sure which word was used) c-states are enabled. I also boot without
ac-adapter. If i boot with processor.nocst=1, I get C3-state, but the
cpu never leaves C0 mode.

When looking at the dsdt i can't find any _CST method or anything else
for that matter that i can see is related to c-states. It does compile
with warnings running "iasl -w3 dsdt.dsl" (output, see next link)

I have uploaded dmesg output, dsdt etc to http://www.borgeby.se/laptop .
dmesg is with acpi.debug_level=0x200f. If something other would be
better, please tell me.

Anyone with experience interested in taking a quick look at this and try
to help me? Maybe some advice what i shall tell Zepto if i contact them?

Regards
/Martin
