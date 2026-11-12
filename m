Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482072;
	b=dcGeKemfapvVgxSwn4D03diUtJyTuYt4id3cdOpQybb2tGQf3dbfG8vZVmDRCO5WFzaf
	 BNdZsL7sWhT5/FM/IRFTK5WmbnOFP37/a3EAbbUdPRaSSOCcFgq7saLxiQcR1EiFc1xfi
	 T31IeejSyVwm0d9RHYO4g7i26aw/m1oPmFbmohzY4IZkw5plrzydd02vWVRsEU4nqEjV+
	 LKvB4GbaSkd2PZ6d/iyVEHNan9Sek3bKp5RFpiIZb9cEZDidVzfB1TD1b7kWrQ+bwL1yV
	 lSyFfDNKZwkLRDSdf9goE5Elqyotk+4GnPHUfHGLD225cZUgbYTq4R5drLeftPNcryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482072;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vhBTCgfGjK4u6xQ2T++mjQLtxlRqMmOmpCWMe7WKk5w=;
	b=qgUHqSO0ZIgiBk5168cSeiiI+t1DKuSGs7iBrHkDzVaKrZ6SweRvG0terrYHgJg5Z/2d
	 2ne9PYN5VhJ8vgH/C3/U6ENgGw52yNJ7+8zWSvQlZJwcmjw+jmYTJNVeANhfiO1b5zmSP
	 q7nY0AzUV7HnoCaOO5ObayivVBJJl+mEP3+Q8MXJcEAnzkt2mgGpAEdj2oenVXOOYuStm
	 CI6OijttSlEWvKKIn4KzLlt/QF5PWbDaKMvfUqP4bltZJhcq2adBMzin2bwTt/1kKqZX7
	 SaXJL7ojGEA8GPemOoEVriqLa1ZjJFx2bhkaaQPae/f1bLJ2WuwUNAW91ibWPAqKD5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVoIr6zI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF08606A323
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVoIr6zI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0751F00A05;
	Thu, 12 Nov 2026 11:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482072;
	bh=vhBTCgfGjK4u6xQ2T++mjQLtxlRqMmOmpCWMe7WKk5w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BVoIr6zIzfj2ME5K4TFlAtDwoDSDnwEBDTLgaC2rCXHkqYQNrYaa6xoKMskrjovph
	 3DseA3Pfkt/o6TVwHKZTvDB5ihO5ltuWBT8jOHGzNrkTrfSSgQrz95mEGUyAQDrbN1
	 WlJZ2o8IKC7L5cg2tRX8N4183gpCtDYSjTyxqdUxdw50IIJOhwSUeMAyHYFzHtCDUR
	 wnX7VrgCEr+KBUUHSr+/05g6dFY43PcrQmSu5hKJkKGE4x/zU5i6kRCt4rHiu3n3hL
	 YlCt3xJk6uNqyB9A564/Nsw9ziv1oL186CVyIk8kGXMbWK8AIOdjUt/oDaEe7mXmoL
	 w79AUG73Mh1pA==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Thu, 12 Nov 2026 11:14:08 +0000
Subject: [PATCH v2 3/3] firmware: arm_ffa: Share FF-A version negotiation
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-acpi_ffh_ffa-v2-3-575a9dbed22b@kernel.org>
References: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
In-Reply-To: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 Jamie Nguyen <jamien@nvidia.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dat Mach <dmach@nvidia.com>
X-Mailer: b4 0.16.0

ACPI FFH and the FF-A transport driver use the same Normal-world
endpoint. Independent FFA_VERSION calls can conflict with endpoint-wide
version negotiation and make initialization order matter.

Add a built-in helper to serialize and cache the FFA_VERSION result,
and use it from both clients. The transport retains its existing version
compatibility checks, while FFH continues to require v1.2.

Build the helper when either client is enabled so the transport
driver can remain modular.

Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/acpi/arm64/ffh.c           | 17 ++++++-----------
 drivers/firmware/arm_ffa/Kconfig   |  5 +++++
 drivers/firmware/arm_ffa/Makefile  |  3 ++-
 drivers/firmware/arm_ffa/driver.c  | 31 ++++++++++++++++--------------
 drivers/firmware/arm_ffa/version.c | 39 ++++++++++++++++++++++++++++++++++++++
 include/linux/arm_ffa.h            | 12 ++++++++++++
 6 files changed, 81 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/arm64/ffh.c b/drivers/acpi/arm64/ffh.c
index 7f13a6d2473a..2b6489d9800e 100644
--- a/drivers/acpi/arm64/ffh.c
+++ b/drivers/acpi/arm64/ffh.c
@@ -66,23 +66,18 @@ static int acpi_ffh_ffa_features(struct acpi_ffh_data *ffh_ctxt, u32 fid)
 
 static int acpi_ffh_ffa_init(struct acpi_ffh_data *ffh_ctxt)
 {
-	struct arm_smccc_1_2_regs args = { }, res;
+	struct arm_smccc_1_2_regs args, res;
 	u32 version;
-	int ret = 0;
+	int ret;
 
 	guard(mutex)(&acpi_ffh_ffa_lock);
 	if (acpi_ffh_ffa_initialized)
 		return 0;
 
-	args.a0 = FFA_VERSION;
-	args.a1 = FFA_VERSION_1_2;
-	acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
-	version = res.a0;
-	if ((s32)version == SMCCC_RET_NOT_SUPPORTED ||
-	    FFA_MAJOR_VERSION(version) != 1 || version < FFA_VERSION_1_2) {
-		ret = -EOPNOTSUPP;
-		return ret;
-	}
+	ret = arm_ffa_version_get(ffh_ctxt->invoke_ffh64_fn, FFA_VERSION_1_2,
+				  &version);
+	if (ret || version < FFA_VERSION_1_2)
+		return -EOPNOTSUPP;
 
 	ret = acpi_ffh_ffa_features(ffh_ctxt, FFA_MSG_SEND_DIRECT_REQ2);
 	if (ret)
diff --git a/drivers/firmware/arm_ffa/Kconfig b/drivers/firmware/arm_ffa/Kconfig
index 5e3ae5cf82e8..81be3d6dd7da 100644
--- a/drivers/firmware/arm_ffa/Kconfig
+++ b/drivers/firmware/arm_ffa/Kconfig
@@ -15,6 +15,11 @@ config ARM_FFA_TRANSPORT
 	  This driver provides interface for all the client drivers making
 	  use of the features offered by ARM FF-A.
 
+config ARM_FFA_VERSION_NEGOTIATION
+	bool
+	depends on ARM64
+	default y if ACPI_FFH || ARM_FFA_TRANSPORT
+
 config ARM_FFA_SMCCC
 	bool
 	default ARM_FFA_TRANSPORT
diff --git a/drivers/firmware/arm_ffa/Makefile b/drivers/firmware/arm_ffa/Makefile
index 168990a7e792..6bd09b81e15f 100644
--- a/drivers/firmware/arm_ffa/Makefile
+++ b/drivers/firmware/arm_ffa/Makefile
@@ -4,5 +4,6 @@ ffa-driver-y = driver.o
 ffa-transport-$(CONFIG_ARM_FFA_SMCCC) += smccc.o
 ffa-core-objs := $(ffa-bus-y)
 ffa-module-objs := $(ffa-driver-y) $(ffa-transport-y)
-obj-$(CONFIG_ARM_FFA_TRANSPORT)  = ffa-core.o
+obj-$(CONFIG_ARM_FFA_VERSION_NEGOTIATION) += version.o
+obj-$(CONFIG_ARM_FFA_TRANSPORT)  += ffa-core.o
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += ffa-module.o
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index babc5d62bdd2..b9b0f88e8f24 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -138,30 +138,33 @@ static u32 ffa_compatible_version_find(u32 version)
 	return FFA_DRIVER_VERSION;
 }
 
-static int ffa_version_check(u32 *version)
+static void ffa_version_invoke(const ffa_value_t *args, ffa_value_t *res)
 {
-	ffa_value_t ver;
+	invoke_ffa_fn(*args, res);
+}
 
-	invoke_ffa_fn((ffa_value_t){
-		      .a0 = FFA_VERSION, .a1 = FFA_DRIVER_VERSION,
-		      }, &ver);
+static int ffa_version_check(u32 *version)
+{
+	int ret;
+	u32 ver;
 
-	if ((s32)ver.a0 == FFA_RET_NOT_SUPPORTED) {
+	ret = arm_ffa_version_get(ffa_version_invoke, FFA_DRIVER_VERSION, &ver);
+	if (ret) {
 		pr_info("FFA_VERSION returned not supported\n");
-		return -EOPNOTSUPP;
+		return ret;
 	}
 
-	if (FFA_MAJOR_VERSION(ver.a0) > FFA_MAJOR_VERSION(FFA_DRIVER_VERSION)) {
+	if (FFA_MAJOR_VERSION(ver) > FFA_MAJOR_VERSION(FFA_DRIVER_VERSION)) {
 		pr_err("Incompatible v%d.%d! Latest supported v%d.%d\n",
-		       FFA_MAJOR_VERSION(ver.a0), FFA_MINOR_VERSION(ver.a0),
+		       FFA_MAJOR_VERSION(ver), FFA_MINOR_VERSION(ver),
 		       FFA_MAJOR_VERSION(FFA_DRIVER_VERSION),
 		       FFA_MINOR_VERSION(FFA_DRIVER_VERSION));
 		return -EINVAL;
 	}
 
-	if (ver.a0 < FFA_MIN_VERSION) {
+	if (ver < FFA_MIN_VERSION) {
 		pr_err("Incompatible v%d.%d! Earliest supported v%d.%d\n",
-		       FFA_MAJOR_VERSION(ver.a0), FFA_MINOR_VERSION(ver.a0),
+		       FFA_MAJOR_VERSION(ver), FFA_MINOR_VERSION(ver),
 		       FFA_MAJOR_VERSION(FFA_MIN_VERSION),
 		       FFA_MINOR_VERSION(FFA_MIN_VERSION));
 		return -EINVAL;
@@ -169,9 +172,9 @@ static int ffa_version_check(u32 *version)
 
 	pr_info("Driver version %d.%d\n", FFA_MAJOR_VERSION(FFA_DRIVER_VERSION),
 		FFA_MINOR_VERSION(FFA_DRIVER_VERSION));
-	pr_info("Firmware version %d.%d found\n", FFA_MAJOR_VERSION(ver.a0),
-		FFA_MINOR_VERSION(ver.a0));
-	*version = ffa_compatible_version_find(ver.a0);
+	pr_info("Firmware version %d.%d found\n", FFA_MAJOR_VERSION(ver),
+		FFA_MINOR_VERSION(ver));
+	*version = ffa_compatible_version_find(ver);
 
 	return 0;
 }
diff --git a/drivers/firmware/arm_ffa/version.c b/drivers/firmware/arm_ffa/version.c
new file mode 100644
index 000000000000..f5c973710dff
--- /dev/null
+++ b/drivers/firmware/arm_ffa/version.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt) "ARM FF-A: " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/arm_ffa.h>
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+static DEFINE_MUTEX(ffa_version_lock);
+static int ffa_version;
+
+int arm_ffa_version_get(void (*invoke)(const struct arm_smccc_1_2_regs *args,
+				       struct arm_smccc_1_2_regs *res),
+			u32 input_version, u32 *version)
+{
+	struct arm_smccc_1_2_regs args = {
+		.a0 = FFA_VERSION,
+		.a1 = input_version,
+	}, res;
+
+	guard(mutex)(&ffa_version_lock);
+	if (!ffa_version) {
+		invoke(&args, &res);
+
+		if ((s32)res.a0 == FFA_RET_NOT_SUPPORTED)
+			ffa_version = -EOPNOTSUPP;
+		else
+			ffa_version = res.a0;
+	}
+
+	if (ffa_version < 0)
+		return ffa_version;
+
+	*version = ffa_version;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arm_ffa_version_get);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 3831fbe244c1..039308a41cdb 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -6,6 +6,7 @@
 #ifndef _LINUX_ARM_FFA_H
 #define _LINUX_ARM_FFA_H
 
+#include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -179,6 +180,17 @@ static inline void *ffa_dev_get_drvdata(struct ffa_device *fdev)
 
 struct ffa_partition_info;
 
+#if IS_BUILTIN(CONFIG_ARM_FFA_VERSION_NEGOTIATION)
+int arm_ffa_version_get(void (*invoke)(const struct arm_smccc_1_2_regs *args,
+				       struct arm_smccc_1_2_regs *res),
+			u32 input_version, u32 *version);
+#else
+static inline int arm_ffa_version_get(
+	void (*invoke)(const struct arm_smccc_1_2_regs *args,
+		       struct arm_smccc_1_2_regs *res),
+	u32 input_version, u32 *version) { return -EOPNOTSUPP; }
+#endif /* CONFIG_ARM_FFA_VERSION_NEGOTIATION */
+
 #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
 struct ffa_device *
 ffa_device_register(const struct ffa_partition_info *part_info,

-- 
2.43.0

