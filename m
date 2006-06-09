From: akpm@osdl.org
Subject: [patch 05/10] KEVENT: add new uevent
Date: Thu, 08 Jun 2006 22:06:27 -0700
Message-ID: <200606090506.k5956Rub031318@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:15832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965193AbWFIFGg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jun 2006 01:06:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, kristen.c.accardi@intel.com, gregkh@suse.de


From: Kristen Accardi <kristen.c.accardi@intel.com>

Add dock uevents so that userspace can be notified of dock and undock events.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/kobject.h |    2 ++
 lib/kobject_uevent.c    |    4 ++++
 2 files changed, 6 insertions(+)

diff -puN include/linux/kobject.h~kevent-add-new-uevent include/linux/kobject.h
--- devel/include/linux/kobject.h~kevent-add-new-uevent	2006-06-03 17:34:41.000000000 -0700
+++ devel-akpm/include/linux/kobject.h	2006-06-03 17:34:41.000000000 -0700
@@ -46,6 +46,8 @@ enum kobject_action {
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices (broken) */
 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* device offline */
 	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* device online */
+	KOBJ_UNDOCK	= (__force kobject_action_t) 0x08, 	/* undocking */
+	KOBJ_DOCK	= (__force kobject_action_t) 0x09,	/* dock */
 };
 
 struct kobject {
diff -puN lib/kobject_uevent.c~kevent-add-new-uevent lib/kobject_uevent.c
--- devel/lib/kobject_uevent.c~kevent-add-new-uevent	2006-06-03 17:34:41.000000000 -0700
+++ devel-akpm/lib/kobject_uevent.c	2006-06-03 17:34:41.000000000 -0700
@@ -50,6 +50,10 @@ static char *action_to_string(enum kobje
 		return "offline";
 	case KOBJ_ONLINE:
 		return "online";
+	case KOBJ_DOCK:
+		return "dock";
+	case KOBJ_UNDOCK:
+		return "undock";
 	default:
 		return NULL;
 	}
_
