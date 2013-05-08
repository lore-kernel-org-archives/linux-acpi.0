From: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Subject: ACPI battery driver loading failed..
Date: Wed, 8 May 2013 05:48:07 +0000
Message-ID: <D854C92F57B1B347B57E531E78D05EAD2DB9A150@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41980 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab3EHFsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 May 2013 01:48:25 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Westerberg, Mika" <mika.westerberg@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi All,

Kernel acpi battery driver loading fails eventhouh I have FW entry for PNP0C0A. but I see acpi ac driver is getting loaded without any issue.

One thing I observed is FW doesn't implement the _CSR method which is being implemented by most of PNP devices.

I have enabled the following driver in kernel config.

CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS is not set
CONFIG_ACPI_PROCFS_POWER=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_PROC_EVENT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y

CONFIG_PNPACPI=y

Also does acpi battery depends on BIOS for loading?

Thanks,
Ram
