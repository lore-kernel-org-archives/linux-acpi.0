From: pingfank@linux.vnet.ibm.com
Subject: [PATCH 0/1] ACPI: Call ACPI remove handler when handling ACPI eject
Date: Wed, 19 Oct 2011 10:47:49 +0800
Message-ID: <1318992470-10195-1-git-send-email-pingfank@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, seabios@seabios.org, lenb@kernel.org, shaohua.li@intel.com
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, aliguori@us.ibm.com, dave@linux.vnet.ibm.com, Liu Ping Fan <pingfank@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

From: Liu Ping Fan <pingfank@linux.vnet.ibm.com>

When I tried to enable cpu hotplug feature for qemu-kvm, I found that the ACPI device eject event just skipped by kernel.

static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
{ 
 	case ACPI_NOTIFY_EJECT_REQUEST:
		/* TBD */---> skipped from here
}

But I notice, in drivers/acpi/dock.c, dock_notify()->handle_eject_request() will handle such event for ACPI _dock device.
So what we shall do, changing Qemu's SeaBIOS or changing the kernel?  If changing SeaBIOS, will it affect guest MS-Window?



Thanks,
ping fan
