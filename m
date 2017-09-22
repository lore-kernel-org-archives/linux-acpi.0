From: Mourad De Clerck <bugs-kernel@aquazul.com>
Subject: ASMedia ahci only works with pci=noacpi
Date: Fri, 22 Sep 2017 16:20:07 +0200
Message-ID: <73d6c9a1-c62f-0ddc-32e6-971513f2f711@aquazul.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gretel.risen.be ([176.9.154.119]:55050 "EHLO gretel.risen.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751928AbdIVO0n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Sep 2017 10:26:43 -0400
Received: from oz.risen.be (d5152d4f6.static.telenet.be [81.82.212.246])
        by gretel.risen.be (Postfix) with ESMTPSA id 99466340616
        for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2017 14:20:08 +0000 (UTC)
Received: from [10.20.1.116] (d5152d5b4.static.telenet.be [81.82.213.180])
        by oz.risen.be (Postfix) with ESMTPSA id 04836140FA9
        for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2017 16:20:07 +0200 (CEST)
Content-Language: fr
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm running stock Debian on a QNAP-453B mini device, an Apollo
Lake-based NAS.

Two of the SATA ports are using the Intel SATA controller, and the other
two are using an unidentified ASMedia SATA controller.

01:00.0 SATA controller [0106]: ASMedia Technology Inc. Device
[1b21:0625] (rev ff)

Sadly, the ASMedia fails to initialize on bootup, giving errors like:

[    4.553800] ahci 0000:01:00.0: failed to stop engine (-5)
<snip>
[   19.553318] ahci 0000:01:00.0: failed to stop engine (-5)
[   19.554075] ahci 0000:01:00.0: AHCI ffff.ffff 32 slots 32 ports ?
Gbps 0xffffffff impl unknown mode

The Intel SATA controller works.

However, when I pass the pci=noacpi parameter on the kernel command
line, the ASMedia controller also works correctly.

Is this an ACPI or firmware issue? Is there a better way to work around
or fix it?

dmesg, dsdt lspci and more details at:
https://bugzilla.kernel.org/show_bug.cgi?id=196805

Thank you,

-- Mourad DC
