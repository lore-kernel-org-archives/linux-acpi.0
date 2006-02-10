From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: some new unaligned access while booting ia64 (HP rx2620)
Date: Fri, 10 Feb 2006 15:58:41 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05AD5D9F@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr21.intel.com ([143.183.121.13]:22998 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932256AbWBJX6p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2006 18:58:45 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org

> This only contains the output of stores to the ACPI "debug"
> object, not the full trace output. However, "_CRS 0" may help

Ah yes.  I'd dropped the acpi_dbg_level = 0xffffff; while trying
to figure out what was going wrong with CONFIG_ACPI_DEBUG=y.

Putting it back in, 16MB is not enough for log_buf :-(

-Tony
