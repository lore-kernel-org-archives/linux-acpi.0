From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH part1 0/4] PCI: pci root bus hotplug support - part1
Date: Sun,  2 Sep 2012 14:47:34 -0700
Message-ID: <1346622458-30595-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

It is based on pci/next

Add back some functions for pci remove.

could get from
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug-part1

Yinghai Lu (4):
  PCI, pciehp: Turn on link again after power off the slot
  PCI, acpiphp: Add is_hotplug_bridge detection
  PCI: Add root bus children dev's res to fail list
  PCI: Split out stop_bus_device and remove_bus_dev again.

 drivers/pci/hotplug/acpiphp_glue.c |   27 ++++++++++++-
 drivers/pci/hotplug/pciehp_hpc.c   |    2 +
 drivers/pci/remove.c               |   77 ++++++++++++++++++++++++++++-------
 drivers/pci/setup-bus.c            |    2 +-
 include/linux/pci.h                |    2 +
 5 files changed, 92 insertions(+), 18 deletions(-)

-- 
1.7.7
