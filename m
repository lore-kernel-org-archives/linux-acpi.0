From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/3] acpi: remove modular references from non modular code
Date: Mon, 15 Feb 2016 00:27:48 -0500
Message-ID: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Aaron Lu <aaron.lu@intel.com>, Huang Ying <ying.huang@intel.com>, Josh Triplett <josh@joshtriplett.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

An audit of i386/x86_64 allmodconfig builds found these instances of 
non-modular ACPI code needlessly using the modular equivalents of 
their built-in counterparts.

In fixing that, we get rid of some dead code, make the mandate of
the remaining code more clear, and leave behind better examples
for future ACPI code to copy/emulate.

Two of them are trivial, in that there is no binary output change.
The other has dead code removal so the binary output will be
slightly smaller.   We've done a direct mapping of module_init to
device_initcall in each instance, so there is no initcall
reordering risks here.  Overall, in all cases, the runtime should
be completely unchanged.

Where others have deployed module_param() already, we have to
leave it, because there is no equivalent builtin_param (not yet)
and we have to remain compatible with existing bootarg users.

Paul.
---

Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

Paul Gortmaker (3):
  drivers/acpi: make bgrt driver explicitly non-modular
  drivers/acpi: make apei/ghes.c more explicitly non-modular
  drivers/acpi: make pmic/intel_pmic_crc.c explicitly non-modular

 drivers/acpi/apei/ghes.c           | 23 +++++++----------------
 drivers/acpi/bgrt.c                | 10 +++-------
 drivers/acpi/pmic/intel_pmic_crc.c |  7 ++-----
 3 files changed, 12 insertions(+), 28 deletions(-)

-- 
2.6.1
