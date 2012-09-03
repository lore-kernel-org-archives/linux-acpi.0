From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 0/5] acpi: remove some legacy procfs interfaces
Date: Mon, 03 Sep 2012 02:03:18 +0200
Message-ID: <1346630598.3170.28.camel@offbook>
Reply-To: dave@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

This patchset is a first attempt to remove some of the deprecated procfs
ACPI interfaces - in the final overall idea to remove /proc/acpi entirely. 
Based on the feature removal file, the CONFIG_ACPI_PROCFS_POWER and CONFIG_ACPI_PROC_EVENT
options are dropped.

patch 1: removes CONFIG_ACPI_PROCFS_POWER
patch 2-5: removes CONFIG_ACPI_PROC_EVENT for acpi and respective drivers
that use /proc/acpi/event.

The set applies ontop of Linus' latest.

Thanks,
Davidlohr
