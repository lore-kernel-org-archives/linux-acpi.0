From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: export ACPI events via netlink
Date: Wed, 16 May 2007 16:28:30 +0800
Message-ID: <1179304110.7707.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7809 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754241AbXEPI3X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 May 2007 04:29:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Export ACPI events via netlink.
A netlink message is broadcasted when an ACPI event is generated.

Note:	The behaviour of how ACPI event works nowadays is not changed.
	Netlink is used to export ACPI event instead of
	/proc/acpi/event someday, but not now.
	This patch only adds the function of sending netlink messages
	when an ACPI event is generated.
	Following is an example of how to receive ACPI event messages.

#include <linux/socket.h>
#include <linux/netlink.h>
#include "stdio.h"

#define NETLINK_ACPI_EVENT	20
#define SOCK_RAW		3

struct acpi_event{
	char device_class[20];
	char bus_id[15];
	unsigned int type;
	unsigned int data;
};

struct sockaddr_nl src_addr, dest_addr;
int sock_fd;
struct msghdr msg;
struct iovec iov;


int main (void){
	int i = 10;
	int result;
	struct acpi_event event;

	sock_fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_ACPI_EVENT);
	if (sock_fd == -1) {
		printf("Socket faied!\n");
		return 0;
	}

	src_addr.nl_family = AF_NETLINK;
	src_addr.nl_pid = getpid();

	src_addr.nl_groups = 1;

	result = bind(sock_fd, (struct sockaddr*)&src_addr, sizeof(src_addr));
	if (result) {
		printf("Bind faied! %d.\n", result);
		return result;
	}

	iov.iov_base = (void *)&event;
	iov.iov_len = sizeof(struct acpi_event);

	msg.msg_name = (void *)&dest_addr;
	msg.msg_namelen = sizeof(dest_addr);
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;

	while(i > 0) {
		printf("Wait...\n");
		result = recvmsg(sock_fd, &msg, 0);
		if (result == -1) {
			printf("Rui: recvmsg failed, error is %d\n", result);
			return result;
		}
		printf("%20s %15s %08x %08x\n",
			event.device_class, event.bus_id, event.type, event.data);
		i--;
	}

	close(sock_fd);
	return 0;
}

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/bus.c      |   34 ++++++++++++++++++++++++++++++++++
 drivers/acpi/event.c    |   19 +++++++++++++++++++
 include/acpi/acpi_bus.h |    1 +
 include/linux/netlink.h |    1 +
 4 files changed, 55 insertions(+)

Index: linux-2.6.22-rc1/drivers/acpi/bus.c
===================================================================
--- linux-2.6.22-rc1.orig/drivers/acpi/bus.c	2007-05-16 13:41:30.000000000 +0800
+++ linux-2.6.22-rc1/drivers/acpi/bus.c	2007-05-16 15:36:47.000000000 +0800
@@ -37,6 +37,7 @@
 #endif
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <linux/netlink.h>
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME("bus");
@@ -275,6 +276,37 @@
 /* --------------------------------------------------------------------------
                                 Event Management
    -------------------------------------------------------------------------- */
+struct acpi_bus_netlink_event {
+	acpi_device_class device_class;
+	char bus_id[15];
+	u32 type;
+	u32 data;
+};
+
+static int acpi_bus_generate_netlink_event(struct acpi_device *device,
+						u8 type, int data)
+{
+	struct sk_buff *skb = NULL;
+	struct acpi_bus_netlink_event *event = NULL;
+
+	skb = alloc_skb(sizeof(struct acpi_bus_event), GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	event = (struct acpi_bus_netlink_event *)
+			skb_put(skb, sizeof(struct acpi_bus_netlink_event));
+	strcpy(event->device_class, device->pnp.device_class);
+	strcpy(event->bus_id, device->dev.bus_id);
+	event->type = type;
+	event->data = data;
+
+	NETLINK_CB(skb).dst_group = 1;
+
+	if (netlink_broadcast(acpi_event_sock, skb, 0, 1, GFP_ATOMIC))
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Failed to send a netlink message for ACPI event\n"));
+	return 0;
+}
 
 static DEFINE_SPINLOCK(acpi_bus_event_lock);
 
@@ -292,6 +324,8 @@
 	if (!device)
 		return -EINVAL;
 
+	acpi_bus_generate_netlink_event(device, type, data);
+
 	/* drop event on the floor if no one's listening */
 	if (!event_is_open)
 		return 0;
Index: linux-2.6.22-rc1/drivers/acpi/event.c
===================================================================
--- linux-2.6.22-rc1.orig/drivers/acpi/event.c	2007-05-16 13:40:25.000000000 +0800
+++ linux-2.6.22-rc1/drivers/acpi/event.c	2007-05-16 13:55:05.000000000 +0800
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <acpi/acpi_drivers.h>
+#include <linux/netlink.h>
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("event");
@@ -106,6 +107,18 @@
 	.poll = acpi_system_poll_event,
 };
 
+struct sock* acpi_event_sock;
+static int acpi_event_netlink_init(void)
+{
+	acpi_event_sock = netlink_kernel_create(NETLINK_ACPI_EVENT, 1, NULL,
+						NULL, THIS_MODULE);
+
+	if (!acpi_event_sock)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int __init acpi_event_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -115,6 +128,12 @@
 	if (acpi_disabled)
 		return 0;
 
+	/* create netlink for acpi event */
+	error = acpi_event_netlink_init();
+	if (error)
+		printk(KERN_WARNING PREFIX
+		       "Failed to create netlink for ACPI event\n");
+
 	/* 'event' [R] */
 	entry = create_proc_entry("event", S_IRUSR, acpi_root_dir);
 	if (entry)
Index: linux-2.6.22-rc1/include/linux/netlink.h
===================================================================
--- linux-2.6.22-rc1.orig/include/linux/netlink.h	2007-05-16 13:41:33.000000000 +0800
+++ linux-2.6.22-rc1/include/linux/netlink.h	2007-05-16 13:43:53.000000000 +0800
@@ -24,6 +24,7 @@
 /* leave room for NETLINK_DM (DM Events) */
 #define NETLINK_SCSITRANSPORT	18	/* SCSI Transports */
 #define NETLINK_ECRYPTFS	19
+#define NETLINK_ACPI_EVENT	20	/* acpi event notifications */
 
 #define MAX_LINKS 32		
 
Index: linux-2.6.22-rc1/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.22-rc1.orig/include/acpi/acpi_bus.h	2007-05-16 13:41:33.000000000 +0800
+++ linux-2.6.22-rc1/include/acpi/acpi_bus.h	2007-05-16 13:44:14.000000000 +0800
@@ -322,6 +322,7 @@
 
 extern struct kset acpi_subsys;
 
+extern struct sock* acpi_event_sock;
 /*
  * External Functions
  */
