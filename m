From: Xie XiuQi <xiexiuqi@huawei.com>
Subject: [PATCH v2 0/3] arm64: acpi: apei: handle SEI notification type for
 ARMv8
Date: Wed, 8 Mar 2017 12:09:38 +0800
Message-ID: <1488946181-130774-1-git-send-email-xiexiuqi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: james.morse@arm.com, marc.zyngier@arm.com, fu.wei@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, zjzhang@codeaurora.org, wangkefeng.wang@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, shiju.jose@huawei.com
Cc: Xie XiuQi <xiexiuqi@huawei.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

ARM APEI extension proposal added SEI (asynchronous SError interrupt)
notification type for ARMv8.

Add a new GHES error source handling function for SEI. In firmware
first mode, if an error source's notification type is SEI. Then GHES
could parse and report the detail error information.

This series is based on Tyler's series "[PATCH V12 00/10] Add UEFI 2.6 and ACPI 6.1 updates
for RAS on ARM64" and the latest mainline.

v2: add kvm guest SEI notification support
    add nmi_{entry, exit} to protect ghes_notify_sei

Xie XiuQi (3):
  arm64: RAS: add ras extension runtime detection
  acpi: apei: handle SEI notification type for ARMv8
  arm64: KVM: add guest SEI support

 arch/arm64/include/asm/cpucaps.h     |  3 +-
 arch/arm64/include/asm/sysreg.h      |  2 ++
 arch/arm64/include/asm/system_misc.h |  1 +
 arch/arm64/kernel/cpufeature.c       | 11 +++++++
 arch/arm64/kernel/traps.c            | 31 +++++++++++++++++++
 arch/arm64/kvm/handle_exit.c         | 22 ++++++++++++--
 drivers/acpi/apei/Kconfig            | 14 +++++++++
 drivers/acpi/apei/ghes.c             | 58 +++++++++++++++++++++++++++++++++++-
 include/acpi/ghes.h                  |  1 +
 9 files changed, 139 insertions(+), 4 deletions(-)

-- 
1.8.3.1
