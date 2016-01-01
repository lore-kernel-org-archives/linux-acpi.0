From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 0/1] fixup! ACPI / utils: Add acpi_dev_present()
Date: Fri, 1 Jan 2016 22:52:15 +0100
Message-ID: <cover.1451671935.git.lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:37820 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbcAAWCE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jan 2016 17:02:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Rafael,

I've just made the embarrassing discovery that I forgot to run checkpatch
before submitting 2d12b6b381ba ("ACPI / utils: Add acpi_dev_present()").
The commit compiles and works just fine but checkpatch complains about a
missing blank in a struct which I had moved verbatim from scan.c to
internal.h.

The commit is on your bleeding-edge and linux-next branches. If you're
still able to rebase, you may want to autosquash this fixup patch.

My apologies for the inconvenience.

Lukas


Lukas Wunner (1):
  fixup! ACPI / utils: Add acpi_dev_present()

 drivers/acpi/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.5.2 (Apple Git-48)

