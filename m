From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/60] lock-less NULL terminated single list implementation
Date: Mon, 25 Oct 2010 02:20:54 -0400
Message-ID: <e42a2308904d7ab7f6dcc7fe4f770de842ccdb6d.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63717 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab0JYILF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 04:11:05 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00AR06QCM6U2@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 03:11:04 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <len.brown@intel.com>

From: Huang Ying <ying.huang@intel.com>

Cmpxchg is used to implement adding new entry to list, deleting first
entry of the list and some other operations.

Because this is a single list, so the tail can not be accessed in O(1).

This can be used in NMI handler.

Signed-off-by: Huang Ying <ying.huang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/llist.h |   64 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig           |    3 ++
 lib/Makefile          |    2 +
 lib/llist.c           |   78 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/llist.h
 create mode 100644 lib/llist.c

diff --git a/include/linux/llist.h b/include/linux/llist.h
new file mode 100644
index 0000000..53be9b5
--- /dev/null
+++ b/include/linux/llist.h
@@ -0,0 +1,64 @@
+#ifndef LLIST_H
+#define LLIST_H
+
+/* lock-less NULL terminated single linked list */
+struct llist_head {
+	struct llist_head *next;
+};
+
+#define LLIST_HEAD_INIT(name) { NULL }
+
+#define LLIST_HEAD(name)				\
+	struct llist_head name = LLIST_HEAD_INIT(name)
+
+/**
+ * init_llist_head - initialize lock-less list head
+ * @head:	the head for your lock-less list
+ */
+static inline void init_llist_head(struct llist_head *list)
+{
+	list->next = NULL;
+}
+
+/**
+ * llist_entry - get the struct of this entry
+ * @ptr:	the &struct llist_head pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the llist_head within the struct.
+ */
+#define llist_entry(ptr, type, member)		\
+	container_of(ptr, type, member)
+
+/**
+ * llist_for_each - iterate over a lock-less list
+ * @pos:	the &struct llist_head to use as a loop cursor
+ * @head:	the head for your lock-less list
+ */
+#define llist_for_each(pos, head)					\
+	for (pos = (head)->next; pos; pos = pos->next)
+
+/**
+ * llist_for_each_entry - iterate over lock-less list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your lock-less list.
+ * @member:	the name of the llist_head with the struct.
+ */
+#define llist_for_each_entry(pos, head, member)				\
+	for (pos = llist_entry((head)->next, typeof(*pos), member);	\
+	     &pos->member != NULL;					\
+	     pos = llist_entry(pos->member.next, typeof(*pos), member))
+
+/**
+ * llist_empty - tests whether a lock-less list is empty
+ * @head:	the list to test
+ */
+static inline int llist_empty(const struct llist_head *head)
+{
+	return head->next == NULL;
+}
+
+void llist_add(struct llist_head *new, struct llist_head *head);
+struct llist_head *llist_del_first(struct llist_head *head);
+void llist_move_all(struct llist_head *list, struct llist_head *head);
+
+#endif /* LLIST_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index fa9bf2c..948b50b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -210,4 +210,7 @@ config GENERIC_ATOMIC64
 config LRU_CACHE
 	tristate
 
+config LLIST
+	bool
+
 endmenu
diff --git a/lib/Makefile b/lib/Makefile
index e6a3763..7696e8d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -106,6 +106,8 @@ obj-$(CONFIG_GENERIC_ATOMIC64) += atomic64.o
 
 obj-$(CONFIG_ATOMIC64_SELFTEST) += atomic64_test.o
 
+obj-$(CONFIG_LLIST) += llist.o
+
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
diff --git a/lib/llist.c b/lib/llist.c
new file mode 100644
index 0000000..22264d9
--- /dev/null
+++ b/lib/llist.c
@@ -0,0 +1,78 @@
+/*
+ * Simple lock-less NULL terminated single list implementation
+ *
+ * Copyright 2010 Intel Corp.
+ *   Author: Huang Ying <ying.huang@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation;
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/llist.h>
+#include <linux/errno.h>
+
+#include <asm/system.h>
+
+/**
+ * llist_add - add a new entry
+ * @new:	new entry to be added
+ * @head:	the head for your lock-less list
+ */
+void llist_add(struct llist_head *new, struct llist_head *head)
+{
+	struct llist_head *entry;
+
+	do {
+		entry = head->next;
+		new->next = entry;
+	} while (cmpxchg(&head->next, entry, new) != entry);
+}
+EXPORT_SYMBOL_GPL(llist_add);
+
+/**
+ * llist_del_first - delete the first entry of lock-less list
+ * @head:	the head for your lock-less list
+ *
+ * If list is empty, return NULL, otherwise, return the first entry deleted
+ */
+struct llist_head *llist_del_first(struct llist_head *head)
+{
+	struct llist_head *entry;
+
+	do {
+		entry = head->next;
+		if (entry == NULL)
+			return NULL;
+	} while (cmpxchg(&head->next, entry, entry->next) != entry);
+
+	return entry;
+}
+EXPORT_SYMBOL_GPL(llist_del_first);
+
+/**
+ * llist_move_all - delete all entries from one list and add them to another list
+ * @list:	the head of lock-less list to delete all entries
+ * @head:	the head of lock-less list to add the entries
+ *
+ * Remove all entries from @list lock-lessly, then add the entries to
+ * lock-less list @head.
+ */
+void llist_move_all(struct llist_head *list, struct llist_head *head)
+{
+	struct llist_head *entry;
+
+	entry = xchg(&list->next, NULL);
+	head->next = entry;
+}
+EXPORT_SYMBOL_GPL(llist_move_all);
-- 
1.7.3.2.90.gd4c43

