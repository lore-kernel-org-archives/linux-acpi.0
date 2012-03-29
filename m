From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH v3 0/3] ACPI/PM D3Cold state support
Date: Thu, 29 Mar 2012 14:09:37 +0800
Message-ID: <1333001380-6050-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The ZPODD patch set involves 4 subsystems: ACPI, Generic PM, SATA and SCSI.
This makes it hard to push upstream.

So I decide to seprate it to two patch sets, one for ACPI/PM and the other
for SATA/SCSI.

You can find the SATA/SCSI part at:
[PATCH v3 0/7] SATA ZPODD support
https://lkml.org/lkml/2012/3/28/20

[PATCH v3 1/3] ACPI: Introduce ACPI D3_COLD state support
[PATCH v3 2/3] ACPI: Add interface to register/unregister device to/from power resources
[PATCH v3 3/3] PM / Runtime: Add may_power_off flag to subsys data

Rafael,

Would you ack PATCH 3?
I renamed the flag to may_power_off according to Alan's suggestion.

Thanks,
Lin Ming
