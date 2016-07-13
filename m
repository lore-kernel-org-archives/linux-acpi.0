From: fu.wei@linaro.org
Subject: [PATCH v7 5/9] MAINTAINERS / ACPI: add the ARM64-specific ACPI
 Support maintainers
Date: Thu, 14 Jul 2016 01:53:18 +0800
Message-ID: <1468432402-4872-6-git-send-email-fu.wei@linaro.org>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, hanjun.guo@linaro.org
Cc: linaro-acpi@lists.linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, wim@iguana.be, jslaby@suse.cz, Fu Wei <fu.wei@linaro.org>, wei@redhat.com, al.stone@linaro.org, timur@codeaurora.org, linux-acpi@vger.kernel.org, kvalo@codeaurora.org, linux@roeck-us.net, harba@codeaurora.org, julien.grall@arm.com, linux-watchdog@vger.kernel.org, arnd@arndb.de, jcm@redhat.com, cov@codeaurora.org, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org, graeme.gregory@linaro.org, gregkh@linuxfoundation.org, rruigrok@codeaurora.org, leo.duran@amd.com, Suravee.Suthikulpanit@amd.com, akpm@linux-foundation.org, davem@davemloft.net, christoffer.dall@linaro.org
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patch add the ARM64-specific ACPI Support maintainers in
MAINTAINERS, according to the discussion on mailing list:
https://lkml.org/lkml/2016/6/29/580
Lorenzo Pieralisi will submit the pull requsts.

The maintainers are listed by the alphabet order of
their name.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1209323..1e03463 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -315,6 +315,14 @@ W:	https://01.org/linux-acpi
 S:	Supported
 F:	drivers/acpi/fan.c
 
+ACPI FOR ARM64 (ACPI/arm64)
+M:	Hanjun Guo <hanjun.guo@linaro.org>
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-acpi@vger.kernel.org
+S:	Supported
+F:	drivers/acpi/arm64
+
 ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
-- 
2.5.5
