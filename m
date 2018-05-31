From: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH v1 0/2] Add NOTIFY_SEI notification type support
Date: Thu, 31 May 2018 20:41:44 +0800
Message-ID: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com, erik.schmauss@intel.com, mark.rutland@arm.com, dave.martin@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, gengdongjiu@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This series patch is separated from https://www.spinics.net/lists/kvm/msg168917.html

1. CPI 6.1 adds support for NOTIFY_SEI as a GHES notification mechanism, so this patch supports this
   notification in software

Dongjiu Geng (2):
  ACPI / APEI: Add SEI notification type support for ARMv8
  arm64: handle NOTIFY_SEI notification by the APEI driver

 arch/arm64/kernel/traps.c | 15 ++++++++++++++
 drivers/acpi/apei/Kconfig | 15 ++++++++++++++
 drivers/acpi/apei/ghes.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h       |  1 +
 4 files changed, 84 insertions(+)

-- 
1.9.1
