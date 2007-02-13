From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/41] ACPI: bay: fix wrong order of kzalloc arguments
Date: Tue, 13 Feb 2007 00:49:26 -0500
Message-ID: <11713458143449-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39554 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751061AbXBMFuP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:15 -0500
In-Reply-To: <11713458132236-git-send-email-lenb@kernel.org>
Message-Id: <a3c94e5c5921b0fd75b33042ca598aee52f1f7b9.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Al Viro <viro@ftp.linux.org.uk>, Al Viro <viro@zeniv.linux.org.uk>, Len Brown <len.brown@intel.com>

From: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 9fdee61..73dc10d 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -276,7 +276,7 @@ static int bay_add(acpi_handle handle, int id)
 	/*
 	 * Initialize bay device structure
 	 */
-	new_bay = kzalloc(GFP_ATOMIC, sizeof(*new_bay));
+	new_bay = kzalloc(sizeof(*new_bay), GFP_ATOMIC);
 	INIT_LIST_HEAD(&new_bay->list);
 	new_bay->handle = handle;
 	new_bay->name = (char *)nbuffer.pointer;
-- 
1.5.0.rc4.345.gb4d2
