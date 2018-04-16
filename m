From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH v2 0/4] acpi: apei: Improve error handling with firmware-first
Date: Mon, 16 Apr 2018 16:58:59 -0500
Message-ID: <20180416215903.7318-1-mr.nuke.me@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com, linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org, mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Or "acpi: apei: Don't let puny firmware crash us with puny errors"

This is the improved implementation following feedback from James Morse
(thanks James!). This implementation, I think, is more modular, and easier to
follow, and just makes more sense.

I'm leaving this as RFC because the BIOS team is a bit scared of an OS
that won't crash when it's told to. However, if people like the idea, then
I have nothing against merging this.

Changes since v1:
 - Due to popular request, the panic() is left in the NMI handler
 - GHES AER handler is split into NMI and non-NMI portions
 - ghes_notify_nmi() does not panic on deferrable errors
 - The handlers are put in a mapping and given a common call signature

Alexandru Gagniuc (4):
  EDAC, GHES: Remove unused argument to ghes_edac_report_mem_error
  acpi: apei: Split GHES handlers outside of ghes_do_proc
  acpi: apei: Do not panic() when correctable errors are marked as
    fatal.
  acpi: apei: Warn when GHES marks correctable errors as "fatal"

 drivers/acpi/apei/ghes.c | 132 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/edac/ghes_edac.c |   3 +-
 include/acpi/ghes.h      |   5 +-
 3 files changed, 117 insertions(+), 23 deletions(-)

-- 
2.14.3
