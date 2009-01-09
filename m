From: akpm@linux-foundation.org
Subject: [patch 6/6] acpi dock: terminate eject request is the dock is not present
Date: Fri, 09 Jan 2009 12:17:13 -0800
Message-ID: <200901092017.n09KHEqd015005@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52434 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755044AbZAIUSS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 15:18:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, marvin@mydatex.cz, hmacht@suse.de, rui.zhang@intel.com, shaohua.li@intel.com, stable@kernel.org

From: Daniel Smolik <marvin@mydatex.cz>

Taken from http://bugzilla.kernel.org/show_bug.cgi?id=12360

nfi if it's right - I merged it so it wouldn't get lost.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Li, Shaohua" <shaohua.li@intel.com>
Cc: <hmacht@suse.de>
Cc: <stable@kernel.org>		[2.6.26.x, 2.6.27.x, 2.6.28.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/dock.c |    3 +++
 1 file changed, 3 insertions(+)

diff -puN drivers/acpi/dock.c~acpi-dock-terminate-eject-request-is-the-dock-is-not-present drivers/acpi/dock.c
--- a/drivers/acpi/dock.c~acpi-dock-terminate-eject-request-is-the-dock-is-not-present
+++ a/drivers/acpi/dock.c
@@ -668,6 +668,9 @@ EXPORT_SYMBOL_GPL(unregister_hotplug_doc
  */
 static int handle_eject_request(struct dock_station *ds, u32 event)
 {
+	if (!dock_present(ds))
+		return -ENODEV;
+
 	if (dock_in_progress(ds))
 		return -EBUSY;
 
_
