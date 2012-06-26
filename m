From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 0/8] some fixes about acpi_memhotplug
Date: Tue, 26 Jun 2012 17:16:05 +0800
Message-ID: <4FE97DD5.6030205@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Wen Congyang (8):
  fix memory leak when memory device is unbound from the module
    acpi_memhotplug
  free memory device if acpi_memory_enable_device() failed
  remove memory info from list before freeing it
  donot allow to eject the memory device if it is being used
  don't print message if request_resource() failed
  bind the memory device when the driver is being loaded
  auto bind the memory device which is hotpluged before the driver is
    loaded
  release memory resources if hotadd_new_pgdat() failed

 drivers/acpi/acpi_memhotplug.c |  106 ++++++++++++++++++++++++++++++----------
 mm/memory_hotplug.c            |    3 +-
 2 files changed, 81 insertions(+), 28 deletions(-)
