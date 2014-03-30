From: Stephen Hemminger <stephen@networkplumber.org>
Subject: pci_hp_register failed with error -16 (3.10.33)
Date: Sun, 30 Mar 2014 11:49:18 -0700
Message-ID: <20140330114918.4f8cfcca@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38165 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaC3StW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Mar 2014 14:49:22 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so6960326pde.24
        for <linux-acpi@vger.kernel.org>; Sun, 30 Mar 2014 11:49:21 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

Looks like this error has already been fixed upstream.

Should this fix be added to 3.10-stable kernel?

commit 3dc48af310709b85d07c8b0d3aa8f1ead02829d3
Author: Neil Horman <nhorman@tuxdriver.com>
Date:   Thu Aug 29 16:17:05 2013 -0400

    PCI/ACPI: Fix _OSC ordering to allow PCIe hotplug use when available
