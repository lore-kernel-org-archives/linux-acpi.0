From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/3] New dock patches (v2)
Date: Thu, 23 Feb 2006 11:56:11 -0800
Message-ID: <1140724571.11750.15.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:11229 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751769AbWBWTvD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Feb 2006 14:51:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Cc: greg@kroah.com, len.brown@intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz

Revised with yesterday's feedback.  Fixed bug in the dock patch which
incorrectly used list_for_each_entry to free memory, updated text in
Kconfig for the removal of docking support from ibm_acpi, and exported
the acpi_bus_trim symbol GPL.

Thanks for reviewing,
Kristen
