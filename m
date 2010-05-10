From: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Subject: [Patch-next] Oops caused by ERST Table not supported.
Date: Mon, 10 May 2010 17:04:32 +0900
Message-ID: <4BE7BE10.8080000@np.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57923 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab0EJIFt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2010 04:05:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKLM <linux-kernel@vger.kernel.org>
Cc: lenb <lenb@kernel.org>, Andi Kleen <ak@linux.intel.com>, Huang Ying <ying.huang@intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, ACPI <linux-acpi@vger.kernel.org>

On my server(x86_64) when the mcelog is executed, it will cause oops. And
following information could be gotten.

Call Trace:
  [<ffffffff812ceefd>] ? avc_has_perm_noaudit+0x4d/0x680
  [<ffffffff812ceefd>] ? avc_has_perm_noaudit+0x4d/0x680
  [<ffffffff8142492b>] erst_read_next+0x3b/0x100
  [<ffffffff81028def>] apei_read_mce+0x2f/0x170
  [<ffffffff811bfc5d>] ? check_object+0x36d/0x430
  [<ffffffff811c059c>] ? init_object+0x9c/0xe0
  [<ffffffff811c38ef>] ? __slab_alloc+0x7cf/0x8b0
  [<ffffffff81025cba>] ? mce_read+0x4a/0x510
  [<ffffffff811c49ab>] ? __kmalloc+0x2db/0x390
  [<ffffffff81025cba>] ? mce_read+0x4a/0x510
  [<ffffffff811bf81d>] ? check_bytes_and_report+0x3d/0x110
  [<ffffffff816caf1e>] ? _cond_resched+0x3e/0x80
  [<ffffffff8102613b>] mce_read+0x4cb/0x510
  [<ffffffff812cb9f2>] ? security_file_permission+0x122/0x130
  [<ffffffff811dff16>] ? rw_verify_area+0x196/0x210
  [<ffffffff811e0e7b>] vfs_read+0x1bb/0x2f0
  [<ffffffff811e172d>] sys_read+0x8d/0xe0
  [<ffffffff81003c9b>] system_call_fastpath+0x16/0x1b

This is because of the ERST Table not supported on my server and it
makes the variable "ctx" used by erst_read_nextis NULL. So I make
the patch to solve this problem.

And I confirmed it on my server(x86_64).

Signed-off-by: Jin Dongming <jin.dongming@np.css.fujitsu.com>
---
 drivers/acpi/apei/erst.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 5fe5c0f..2ebc391 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -698,6 +698,9 @@ ssize_t erst_read_next(struct cper_record_header *record, size_t buflen)
 	unsigned long flags;
 	u64 record_id;
 
+	if (erst_disable)
+		return -ENODEV;
+
 	spin_lock_irqsave(&erst_lock, flags);
 	rc = __erst_get_next_record_id(&record_id);
 	if (rc) {
-- 
1.7.0.3

