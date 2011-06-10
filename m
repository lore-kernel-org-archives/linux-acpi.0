From: Thomas Renninger <trenn@suse.de>
Subject: Stable request for longterm support kernel 2.6.32 - git comit id: b7b30de53aef6ce773d34837ba7d8422bd3baeec
Date: Fri, 10 Jun 2011 15:49:36 +0200
Message-ID: <201106101549.36559.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50985 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932136Ab1FJNti (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Jun 2011 09:49:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, bjorn@helgaas.com

Hi,

processor objects declared under _PR. scope and not declared
with the traditional:
Processor (XXXX, 0x0F, 0x00000410, 0x06) {}
processor declaration, but with the new _HID("ACPI0007")
declaration:
Device (XXXX){
     Name (_HID, "ACPI0007")
     Name (_UID, 0x00000028)
}
are also not recognized which leads to not functioning idle
and cpufreq routines on cores.

Bjorn's patch fixes these as well and is therefore a critical
fix and justifies queueing for stable kernel.

The patch needs slight adjusting for 2.6.32.
I've backported it and will send (reply on this mail) a
patch which should apply cleanly on 2.6.32 stable kernel.

Please consider to add.

Thanks,

   Thomas
