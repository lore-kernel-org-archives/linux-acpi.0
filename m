From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH v3 0/3] acpi: apei: Improve PCIe error handling with firmware-first
Date: Wed, 25 Apr 2018 15:39:48 -0500
Message-ID: <20180425203957.18224-1-mr.nuke.me@gmail.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416215903.7318-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-kernel@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

Or "acpi: apei: Don't trust firmware any further than you can throw it"

This is the improved implementation following feedback from James and
Borislav. This implementation is much simpler, albeit less flexible than v2.

I'm leaving this as RFC because the BIOS team is a bit scared of an OS
that won't crash when it's told to. However, if people like the idea, then
I have nothing against merging this.

Borislav, if you don't like the third patch in the series, feel free to leave
it out. THings will work beautifully with or without it.


Changes since v2:
 - Due to popular request, simple is chosen over flexible
 - Removed splitting of handlers into irq safe portion.
 - Change behavior only for PCIe errors

Changes since v1:
 - Due to popular request, the panic() is left in the NMI handler
 - GHES AER handler is split into NMI and non-NMI portions
 - ghes_notify_nmi() does not panic on deferrable errors
 - The handlers are put in a mapping and given a common call signature

Alexandru Gagniuc (3):
  EDAC, GHES: Remove unused argument to ghes_edac_report_mem_error
  acpi: apei: Do not panic() on PCIe errors reported through GHES
  acpi: apei: Warn when GHES marks correctable errors as "fatal"

 drivers/acpi/apei/ghes.c | 56 +++++++++++++++++++++++++++++++++++++++++++-----
 drivers/edac/ghes_edac.c |  3 +--
 include/acpi/ghes.h      |  5 ++---
 3 files changed, 54 insertions(+), 10 deletions(-)

-- 
2.14.3
