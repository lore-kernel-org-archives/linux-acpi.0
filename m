From: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH v5 0/2] support exception state migration and set VSESR_EL2 by user space
Date: Tue, 26 Jun 2018 04:58:27 +0800
Message-ID: <1529960309-2513-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rkrcmar@redhat.com, corbet@lwn.net, christoffer.dall@arm.com, marc.zyngier@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, james.morse@arm.com, gengdongjiu@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This series patch is separated from https://www.spinics.net/lists/kvm/msg168917.html

1. Detect whether KVM can set set guest SError syndrome
2. Support to Set VSESR_EL2 and inject SError by user space.
3. Support live migration to keep SError pending state and VSESR_EL2 value

The user space patch is here: https://www.mail-archive.com/qemu-devel@nongnu.org/msg539534.html

Dongjiu Geng (2):
  arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
  arm64: KVM: export the capability to set guest SError syndrome

 Documentation/virtual/kvm/api.txt    | 44 ++++++++++++++++++++++++++++++++----
 arch/arm64/include/asm/kvm_emulate.h |  5 ++++
 arch/arm64/include/asm/kvm_host.h    |  7 ++++++
 arch/arm64/include/uapi/asm/kvm.h    | 13 +++++++++++
 arch/arm64/kvm/guest.c               | 43 +++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/inject_fault.c        |  6 ++---
 arch/arm64/kvm/reset.c               |  4 ++++
 include/uapi/linux/kvm.h             |  1 +
 virt/kvm/arm/arm.c                   | 21 +++++++++++++++++
 9 files changed, 137 insertions(+), 7 deletions(-)

-- 
2.7.4
