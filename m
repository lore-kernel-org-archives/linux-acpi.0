From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Subject: [PATCH v2 0/4] ACPI based NUMA support for ARM64
Date: Tue, 17 Nov 2015 23:55:29 +0530
Message-ID: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
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
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Will.Deacon@arm.com, catalin.marinas@arm.com, grant.likely@linaro.org, leif.lindholm@linaro.org, rfranz@cavium.com, ard.biesheuvel@linaro.org, msalter@redhat.com, robh+dt@kernel.org, steve.capper@linaro.org, hanjun.guo@linaro.org, al.stone@linaro.org, arnd@arndb.de, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tn@semihalf.com, rrichter@cavium.com, Prasun.Kapoor@caviumnetworks.com
Cc: gpkulkarni@gmail.com
List-Id: linux-acpi@vger.kernel.org

 -v2 rebased on arm64-numa v7 patches.
 http://www.spinics.net/lists/arm-kernel/msg460813.html

 -v1 initial patches from Hanjun Guo

Hanjun Guo (4):
  acpi, numa: Use pr_fmt() instead of printk
  acpi, numa: Replace ACPI_DEBUG_PRINT() with pr_debug()
  arm64, acpi, numa: NUMA support based on SRAT and SLIT
  acpi, numa: Enable ACPI based NUMA on ARM64

 arch/arm64/include/asm/acpi.h |   4 +
 arch/arm64/kernel/Makefile    |   1 +
 arch/arm64/kernel/acpi_numa.c | 215 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/numa.c          |   7 +-
 drivers/acpi/Kconfig          |   4 +-
 drivers/acpi/numa.c           | 106 ++++++++++++---------
 include/linux/acpi.h          |  15 +++
 7 files changed, 306 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm64/kernel/acpi_numa.c

-- 
1.8.1.4
