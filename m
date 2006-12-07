From: Miroslav Ruda <ruda@ics.muni.cz>
Subject: suspend to RAM on lifebook 7110
Date: Thu, 7 Dec 2006 23:18:31 +0100
Message-ID: <20061207221831.GA31419@erebor.ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tirith.ics.muni.cz ([147.251.4.36]:41153 "EHLO
	tirith.ics.muni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163511AbWLGWSj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Dec 2006 17:18:39 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: seife@suse.de
Cc: linux-acpi@vger.kernel.org

Hi,

 I'm installing opensuse 10.2 on Fujitsu Siemens Lifebook 7110 (intel
dual core, intel 965 chipset, intel 945 graphics chipset ...).
Most of hardware works fine, but I have some problems with suspend to
ram - suspend/resume using s2ram works fine, but display remains nearly 
black. I can see very hardly what's on display, but machine including
network works fine.

I have tested s2ram on Suse 2.6.18.2-23-default or vanila 2.6.19+swsusp2
with the same problems.

s2ram -i returns
This machine can be identified by:
    sys_vendor   = "FUJITSU SIEMENS"
    sys_product  = "LIFEBOOK S7110"
    sys_version  = " "
    bios_version = "Version 1.18 "

s2ram -f -a[0123] gives the same result, -s -p combinations doesn't work
too. Switching back to text console doesn't help. Using xset dpms force
off doesn't help too. The same problem I have both on text console and
using Xserver.

Do you have any idea what may be wrong? 

-- 
                  Mirek Ruda 
