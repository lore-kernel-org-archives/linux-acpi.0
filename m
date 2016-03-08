From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [RESEND PATCH 1/2] device property: fwnode->secondary may contain ERR_PTR(-ENODEV)
Date: Tue,  8 Mar 2016 15:44:36 +0200
Message-ID: <1457444677-25645-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1457444677-25645-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21596 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932366AbcCHNoo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Mar 2016 08:44:44 -0500
In-Reply-To: <1457444677-25645-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Youn <John.Youn@synopsys.com>, linux-acpi@vger.kernel.org

This fixes BUG that is trickered when fwnode->secondary is not null,
but has ERR_PTR(-ENODEV) instead.

BUG: unable to handle kernel paging request at ffffffffffffffed
IP: [<ffffffff81677b86>] __fwnode_property_read_string+0x26/0x160
PGD 200e067 PUD 2010067 PMD 0
Oops: 0000 [#1] SMP KASAN
Modules linked in: dwc3_pci(+) dwc3
CPU: 0 PID: 1138 Comm: modprobe Not tainted 4.5.0-rc5+ #61
task: ffff88015aaf5b00 ti: ffff88007b958000 task.ti: ffff88007b958000
RIP: 0010:[<ffffffff81677b86>]  [<ffffffff81677b86>] __fwnode_property_read_string+0x26/0x160
RSP: 0018:ffff88007b95eff8  EFLAGS: 00010246
RAX: fffffbfffffffffd RBX: ffffffffffffffed RCX: ffff88015999cd37
RDX: dffffc0000000000 RSI: ffffffff81e11bc0 RDI: ffffffffffffffed
RBP: ffff88007b95f020 R08: 0000000000000000 R09: 0000000000000000
R10: ffff88007b90f7cf R11: 0000000000000000 R12: ffff88007b95f0a0
R13: 00000000fffffffa R14: ffffffff81e11bc0 R15: ffff880159ea37a0
FS:  00007ff35f46c700(0000) GS:ffff88015b800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffffffffffed CR3: 000000007b8be000 CR4: 00000000001006f0
Stack:
 ffff88015999cd20 ffffffff81e11bc0 ffff88007b95f0a0 ffff88007b383dd8
 ffff880159ea37a0 ffff88007b95f048 ffffffff81677d03 ffff88007b952460
 ffffffff81e11bc0 ffff88007b95f0a0 ffff88007b95f070 ffffffff81677d40
Call Trace:
 [<ffffffff81677d03>] fwnode_property_read_string+0x43/0x50
 [<ffffffff81677d40>] device_property_read_string+0x30/0x40
...

Fixes: 362c0b30249e (device property: Fallback to secondary fwnode if primary misses the property)
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c359351..a163f2c 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -218,7 +218,7 @@ bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
 	bool ret;
 
 	ret = __fwnode_property_present(fwnode, propname);
-	if (ret == false && fwnode && fwnode->secondary)
+	if (ret == false && fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
 		ret = __fwnode_property_present(fwnode->secondary, propname);
 	return ret;
 }
@@ -423,7 +423,7 @@ EXPORT_SYMBOL_GPL(device_property_match_string);
 	int _ret_;									\
 	_ret_ = FWNODE_PROP_READ(_fwnode_, _propname_, _type_, _proptype_,		\
 				 _val_, _nval_);					\
-	if (_ret_ == -EINVAL && _fwnode_ && _fwnode_->secondary)			\
+	if (_ret_ == -EINVAL && _fwnode_ && !IS_ERR_OR_NULL(_fwnode_->secondary))	\
 		_ret_ = FWNODE_PROP_READ(_fwnode_->secondary, _propname_, _type_,	\
 				_proptype_, _val_, _nval_);				\
 	_ret_;										\
@@ -593,7 +593,7 @@ int fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 	int ret;
 
 	ret = __fwnode_property_read_string_array(fwnode, propname, val, nval);
-	if (ret == -EINVAL && fwnode && fwnode->secondary)
+	if (ret == -EINVAL && fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
 		ret = __fwnode_property_read_string_array(fwnode->secondary,
 							  propname, val, nval);
 	return ret;
@@ -621,7 +621,7 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 	int ret;
 
 	ret = __fwnode_property_read_string(fwnode, propname, val);
-	if (ret == -EINVAL && fwnode && fwnode->secondary)
+	if (ret == -EINVAL && fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
 		ret = __fwnode_property_read_string(fwnode->secondary,
 						    propname, val);
 	return ret;
-- 
2.7.0

