From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 0/4] ACPI, APEI, Add APEI related _OSC support
Date: Mon, 27 Jun 2011 16:25:56 +0800
Message-ID: <1309163160-3201-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org
List-Id: linux-acpi@vger.kernel.org

Changes:

- Change error message for WHEA _OSC call according to Matthew's comments

[PATCH -v2 1/4] ACPI, APEI, GHES, Prevent GHES to be built as module
[PATCH -v2 2/4] ACPI, APEI, GHES, Support disable GHES at boot time
[PATCH -v2 3/4] ACPI, APEI, Add APEI bit support in generic _OSC call
[PATCH -v2 4/4] ACPI, APEI, Add WHEA _OSC support
