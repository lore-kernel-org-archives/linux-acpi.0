From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 05/18] KEVENT: add new uevent
Date: Tue, 27 Jun 2006 02:12:00 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6D8C7C0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37518 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030650AbWF0GNn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jun 2006 02:13:43 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, gregkh@suse.de

applied to acpi-test 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Saturday, June 24, 2006 7:36 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; Accardi, 
>Kristen C; gregkh@suse.de
>Subject: [patch 05/18] KEVENT: add new uevent
>
>
>From: Kristen Accardi <kristen.c.accardi@intel.com>
>
>Add dock uevents so that userspace can be notified of dock and 
>undock events.
>
>Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
>Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> include/linux/kobject.h |    2 ++
> lib/kobject_uevent.c    |    4 ++++
> 2 files changed, 6 insertions(+)
>
>diff -puN include/linux/kobject.h~kevent-add-new-uevent 
>include/linux/kobject.h
>--- devel/include/linux/kobject.h~kevent-add-new-uevent	
>2006-06-03 17:34:41.000000000 -0700
>+++ devel-akpm/include/linux/kobject.h	2006-06-03 
>17:34:41.000000000 -0700
>@@ -46,6 +46,8 @@ enum kobject_action {
> 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	
>/* umount event for block devices (broken) */
> 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	
>/* device offline */
> 	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	
>/* device online */
>+	KOBJ_UNDOCK	= (__force kobject_action_t) 0x08, 	
>/* undocking */
>+	KOBJ_DOCK	= (__force kobject_action_t) 0x09,	
>/* dock */
> };
> 
> struct kobject {
>diff -puN lib/kobject_uevent.c~kevent-add-new-uevent 
>lib/kobject_uevent.c
>--- devel/lib/kobject_uevent.c~kevent-add-new-uevent	
>2006-06-03 17:34:41.000000000 -0700
>+++ devel-akpm/lib/kobject_uevent.c	2006-06-03 
>17:34:41.000000000 -0700
>@@ -50,6 +50,10 @@ static char *action_to_string(enum kobje
> 		return "offline";
> 	case KOBJ_ONLINE:
> 		return "online";
>+	case KOBJ_DOCK:
>+		return "dock";
>+	case KOBJ_UNDOCK:
>+		return "undock";
> 	default:
> 		return NULL;
> 	}
>_
>
