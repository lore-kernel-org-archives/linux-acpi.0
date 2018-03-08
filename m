From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] ACPI IORT updates for v4.17
Date: Thu, 8 Mar 2018 11:54:25 +0000
Message-ID: <20180308115425.GA31267@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com, catalin.marinas@arm.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jia He <jia.he@hxt-semitech.com>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, sudeep.holla@arm.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Hi Catalin, Will,

some clean-ups patches for the ACPI IORT code aimed at the v4.17 kernel
release:

- Two leftover ACPICA preprocessor guards removal (L.Pieralisi)
- Removal of IORT linker script entry re-introduced by mistake
  in clocksource driver refactoring (J.He)

Please consider pulling them, thank you very much.

Lorenzo

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/acpi/iort-for-v4.17

for you to fetch changes up to 8dc12538dd14480ffcbcbf18b80dc641ee37e9de:

  ACPI/IORT: Remove obsolete ACPI_IORT_SMMU_V3_CAVIUM_CN99XX define (2018-03-08 11:22:30 +0000)

----------------------------------------------------------------
Three ACPI IORT clean-up patches aimed at v4.17 release cycle:

- Removal of IORT linker script entry re-introduced by mistake by clocksource
  drivers refactoring (J.He)
- Two ACPICA guards removal of previously introduced guards to prevent
  ACPICA<->kernel patches dependencies (L.Pieralisi)

----------------------------------------------------------------
Jia He (1):
      ACPI/IORT: Remove linker section for IORT entries again

Lorenzo Pieralisi (2):
      ACPI/IORT: Remove temporary iort_get_id_mapping_index() ACPICA guard
      ACPI/IORT: Remove obsolete ACPI_IORT_SMMU_V3_CAVIUM_CN99XX define

 drivers/acpi/arm64/iort.c         | 12 ------------
 include/asm-generic/vmlinux.lds.h |  1 -
 2 files changed, 13 deletions(-)
