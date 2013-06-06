From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH RFC v2 0/3] add cpu physically hotplug driver
Date: Thu, 6 Jun 2013 09:40:32 +0800
Message-ID: <1370482835-764-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, liguang <lig.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

This patch-set try to support physically hot-plug/unplug
a cpu automatically, that is:
if you offline a cpu, it will automatically actually remove
a cpu, and if you hot-plug a cpu, then it will online this
cpu automatically.
so, offline is just like eject, but eject attribute seems not
available since recent kernel(can't figure out when), with
this driver, if allowed, it will trigger a eject cpu process.
and for automatically online, it was said there are objections,
don't know the reason, so, send this patch-set boldly.

of course, this approach is for QEMU 's hotplug cpu emulation 
only, but not limited, if someone like to explore ec space to
implment cpu hot-plug/unplug for real platform please
feel free to continue.

Li Guang (3)
	 drivers/platform/x86: add cpu physically hotplug driver
	 ec: add ec space notifier
	 cpu_physic_hotplug: register handler for ec space notifier

drivers/acpi/ec.c                         | 32 ++++++++++++++++++++++++++++++++
drivers/platform/x86/Kconfig              |  8 ++++
drivers/platform/x86/Makefile             |  1 +
drivers/platform/x86/cpu_physic_hotplug.c | 90 +++++++++++++++++++++++++++++
include/linux/acpi.h                      |  2 ++
5 files changed, 130 insertions(+), 3 deletions(-)
 create mode 100644 drivers/platform/x86/cpu_physic_hotplug.c
