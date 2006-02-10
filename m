From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: some new unaligned access while booting ia64 (HP rx2620)
Date: Fri, 10 Feb 2006 13:15:39 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05AD5A66@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr22.intel.com ([143.183.121.14]:16082 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750956AbWBJVPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2006 16:15:45 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org

> Enabling debugging in the ACPI subsystem will certainly give this
> information. AcpiDebugLevel = 0x00FFFFFF works nicely, although
> a lot of trace info is produced.

There is no AcpiDebugLevel in the Linux kernel.  I did find a
variable "acpidbg_level" ... so I set CONFIG_ACPI_DEBUG=y and
added
	acpi_dbg_level = 0x00FFFFFF;
at the start of init/main.c/start_kernel()

But then my system didn't boot at all :-(

Tried again w/o the "acpi_dbg_level = 0x00FFFFFF;", and that didn't
boot either.  So there is something bad in the CONFIG_ACPI_DEBUG
code.

-Tony
