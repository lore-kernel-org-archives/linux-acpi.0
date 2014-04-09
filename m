From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH 0/7] APEI: Make APEI architecture independent.
Date: Wed,  9 Apr 2014 17:14:28 +0200
Message-ID: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, bp@suse.de, m.chehab@samsung.com
Cc: linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>
List-Id: linux-acpi@vger.kernel.org

APEI is currently implemented so that it depends on x86 hardware.
The primary dependency is that GHES uses the x86 NMI for hardware
error notification. These patches remove that dependency.

Other APEI features such as error reporting via external IRQ, error
serialization, or error injection, do not require changes to use them
on non-x86 architectures.

The following patch set eliminates the APEI Kconfig x86 dependency
by making these changes:
- replace arch specific calls with more generic one
- treat NMI notification as GHES feature - CONFIG_ACPI_APEI_NMI
- isolate NMI related code
- reorganize function logic 

NMI code is kept in ghes.c file since NMI and IRQ context are tightly coupled.

Note, these patches introduce no functional changes for x86. The NMI notification
feature is selected for x86 by default. Architectures that want to use this
feature should also provide NMI code infrastructure.

Tomasz Nowicki (7):
  apei, mce: Call MCE-specific code only for X86 architecture.
  acpi, apei, ghes: Introduce more generic mechanism to init/deinit
    GHES error notifications.
  ACPI, APEI, GHES: Introduce ACPI_NMI to make NMI error notification a
    GHES feature.
  acpi, apei, ghes: Factor out NMI error notification context.
  acpi, apei, ghes: Attach NMI init/deinit functions while
    CONFIG_ACPI_NMI is enabled.
  acpi, apei, ghes: Make unmapping functionality independent from
    architecture.
  acpi, apei, ghes: Factor out ioremap virtual memory for IRQ and NMI
    context.

 drivers/acpi/apei/Kconfig |   10 +-
 drivers/acpi/apei/ghes.c  |  329 ++++++++++++++++++++++++++++-----------------
 drivers/acpi/apei/hest.c  |    8 +-
 3 files changed, 218 insertions(+), 129 deletions(-)

-- 
1.7.9.5
