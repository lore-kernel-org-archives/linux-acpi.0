From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH 0/2] Introduding the Ambient Light Sensor (ALS) class
Date: Thu, 26 Nov 2009 14:04:41 +0200
Message-ID: <1259237081-4403-1-git-send-email-amit.kucheria@verdurent.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57693 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbZKZMEl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2009 07:04:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: List Linux Kernel <linux-kernel@vger.kernel.org>
Cc: rui.zhang@intel.com, jic23@cam.ac.uk, khali@linux-fr.org, alan@linux.intel.com, linux-acpi@vger.kernel.org, gregkh@suse.de

Introduce a new class of devices to handle ambient light sensors. Currently
only one sysfs inteface, 'illuminance' is introduced. More will be added as
drivers are ported to use this new class.

Amit Kucheria (1):
  als: add unique device-ids to the als device class

Zhang Rui (1):
  introduce ALS sysfs class

 Documentation/ABI/testing/sysfs-class-als |    9 ++
 MAINTAINERS                               |    6 ++
 drivers/Kconfig                           |    2 +
 drivers/Makefile                          |    1 +
 drivers/als/Kconfig                       |   10 +++
 drivers/als/Makefile                      |    5 +
 drivers/als/als_sys.c                     |  116 +++++++++++++++++++++++++++++
 include/linux/als_sys.h                   |   35 +++++++++
 8 files changed, 184 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-als
 create mode 100644 drivers/als/Kconfig
 create mode 100644 drivers/als/Makefile
 create mode 100644 drivers/als/als_sys.c
 create mode 100644 include/linux/als_sys.h

