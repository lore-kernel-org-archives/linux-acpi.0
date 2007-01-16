From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [0/5] remove ACPI motherboard driver, use PNP system driver instead
Date: Tue, 16 Jan 2007 10:28:09 -0700
Message-ID: <200701161028.10109.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:58301 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933AbXAPR2b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jan 2007 12:28:31 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

The ACPI motherboard driver is mostly redundant with the PNP system
driver.  This series moves the little bit of ACPI-specific stuff out
of the motherboard driver into acpi/osl.c, adds a little bit to the
PNP system driver so it covers all the remaining functionality of
the ACPI driver, and removes the ACPI driver.

Feedback welcome.

Bjorn
