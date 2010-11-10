From: Alan Stern <stern@rowland.harvard.edu>
Subject: ACPI_VIDEO and BACKLIGHT_CLASS_DEVICE
Date: Wed, 10 Nov 2010 17:02:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011101646240.1587-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39301 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756937Ab0KJWCh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Nov 2010 17:02:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

Rui:

Why does CONFIG_ACPI_VIDEO depend on BACKLIGHT_CLASS_DEVICE?  Doesn't
ACPI_VIDEO apply to any sort of video adapter, including plain old VGA
adapters attached to a non-LCD device?

Alan Stern

