From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/2] [RFC] Overriding of arbitrary ACPI tables via initrd
Date: Sat, 25 Jun 2011 22:13:02 +0200
Message-ID: <201106252213.03325.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48557 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab1FYUNR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Jun 2011 16:13:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, x86@kernel.org, hpa@zytor.com

The patches are against 3.0-rc3.

They are not intended for queuing yet, further work is needed.

Patches to be able to override the DSDT via initrd existed already and
it came out that they are very convenient if one works on ACPI related
Linux kernel or BIOS problems.

Unfortunately they never went mainline and even worse, due to
moving populate_rootfs, they do not work anymore for some time.

If these are accepted, I'll rework them and address remaining issues
and will happily repost.

Thanks,

    Thomas
