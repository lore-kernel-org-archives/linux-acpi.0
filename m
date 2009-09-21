From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 01/17] ACPICA: fixup after acpi_get_object_info() change
Date: Mon, 21 Sep 2009 13:28:49 -0600
Message-ID: <20090921192849.21322.99657.stgit@bob.kio>
References: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:31231 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbZIUT2q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:28:46 -0400
In-Reply-To: <20090921192656.21322.23072.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Gary Hade <garyhade@us.ibm.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>

Commit 15b8dd53f5ffa changed info->hardware_id from a static array to
a pointer.  If hardware_id is non-NULL, it points to a NULL-terminated
string, so we don't need to terminate it explicitly.  However, it may
be NULL; in that case, we *can't* add a NULL terminator.

This causes a NULL pointer dereference oops for devices without _HID.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Lin Ming <ming.m.lin@intel.com>
CC: Bob Moore <robert.moore@intel.com>
CC: Gary Hade <garyhade@us.ibm.com>
---
 drivers/pci/hotplug/acpiphp_ibm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index a9d926b..e7be66d 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -406,7 +406,6 @@ static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
 			__func__, status);
 		return retval;
 	}
-	info->hardware_id.string[sizeof(info->hardware_id.length) - 1] = '\0';
 
 	if (info->current_status && (info->valid & ACPI_VALID_HID) &&
 			(!strcmp(info->hardware_id.string, IBM_HARDWARE_ID1) ||

