Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153951EE0E
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984619; cv=none; b=eQZ1JTCWuheNxEs2tXmStvajjlCmt61vEAchRgVl+xgNcj0+Q77LQOwtqtjanuRaSwy7mjWtzxpQjMO6oaRL17miyu977mbJxXNigKr7JuFpCPLWpm/ZM5iUhqmm/Fj6M8WDMjWd7geOkYYvosJHug2VQVf3kbUBKM9mis295es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984619; c=relaxed/simple;
	bh=7xNA6AcaBXl0SlDJ5OrO1M7RnWXtSvzav/nIvyDbenE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpNBNlG2YbBRRSCe1HFvOyhLDpnk0jEMgfkx1t97XqkP3RgGCxbgU65je/iiYdGkhg0wu4WYbCGJvZyBLln7M/lYVoJX2gOhAlfXIUprURIMaag0XBFXaXFRkRegro+kNzGwEZO9D2YGO3sabNUF/cNp8uSj3aD2OVmyer6COM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KQZKtas4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HMnjyV3p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQZKtas4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HMnjyV3p"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBS40O3366698
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dhINL8qlZgm
	ADqkP9veuOfRVtRJfCiv6oCPxxzHt0Lg=; b=KQZKtas4opLab1LuLXEIRKqYBbL
	/Tztpm90KAdZqJSj8GICCzXKhfgjco2c0Y32nDhfGgqzVU6+bOIFTgh2cRU97ouB
	IItOgj578F2otdiry0bAokOZ7AUCvClqig+g5XIZ0Tl8emVa6ah4F9tZrJmRC7gC
	+P8Kuvrw1+V7//XcHWrJ2AaeP5cOIJdIYY9+pjbDxslNaJ+S3EuzWp1J8XfUPLGr
	bVXO5XhtAVbNzqAzF3Nd1MhKSe4kNgIsyp/3SNWOBjYWQgV6iQW+b09kCfN528Ur
	yWWUwQ1T0ofzTCaIGtexYZNPOOfI+q1WEkgq7Eua55av346beXBc6CDKNaw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4621srg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:30:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934963b2bc0so799510885a.3
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791984609; x=1792589409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhINL8qlZgmADqkP9veuOfRVtRJfCiv6oCPxxzHt0Lg=;
        b=HMnjyV3pmilPn5gViO5nprLNeK1oRkZiGSqqWAnvYf3hOYv1WIkUCfrZEhJ9czMDBK
         rPhRyunlNIrGku4Oo+Dw/dNP1s1dFhcV52ZJw8QvJza/GjmcvwiNjHypx9IgrVuDksk3
         pUCWCf2BWQB5fKBQcnBamGY7sQnR9AR9tN0+UAM7xaAOxS3o+4bObW0iov2GVwi25MfD
         7ToN0PBdK35//vIyYTBj91z1MCTuIaKqg0GQBarYlPXrdCaFHlFZsMXh+LLoDsjIUATJ
         vZrOr40utp3rCDNlGarKm5O23nLqaEKoUmqOqD8CkmOhumZ6KCe1jJeZsPIXlspN/Vy4
         32Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984609; x=1792589409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dhINL8qlZgmADqkP9veuOfRVtRJfCiv6oCPxxzHt0Lg=;
        b=0Q+ufjMoqEmfHCo3VfK3+2Zxw1zSFxb3Tsjuy/KKTbGJxsHvgo1QRQR8JW1S9eX7+W
         zSvbkGOzEiwiD73y+/uiD1Jf1MKEfTsxuTlMtZkPDEqgDxF1hp/RQ2UDng/7p90QFaue
         GMEo5zqUTMUMTB3ZHTK74CLlMP+/rKxVbH+Lx8IV0e8Am+uCzbCmsZJCcc/um6/FHHnN
         du4jBjuwOXaPLhr1J67zka4ScaIUY/y5rn6dF34NjHsaWJDis4rnu7xwHiCsxquDlPqv
         C13wNZ1bU0EIhhGtabE4LPyPOW0KnudUiGDeyva2keFHBhjkUOlOnVU6SAh4gz9sN2ke
         aO/Q==
X-Forwarded-Encrypted: i=1; AKwUvByGuG3RaUGeWCBxFDZdYiE6VobSxua+vRwM+1/NwimD341OQUdw7QCEynDHHgSu9B1arwLF8f/EhM7w@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0VvNZeTf0tI6t4SmKvXk5NthVP4p2TF53cG8XBTWBfrgA1hnL
	9Q58W/n7gdLbdobLu1cv0fRScC55/n7ZP++X+UuLlCPohKDBXeWhQwB0fRgHV18fz5vSXg/gKfs
	gzUyNHS+OWKSh+gJfKTQPnWWUSK49aGnkdBcTjsPx5fsFQzKyKby8tUk7GUd9kWOY
X-Gm-Gg: AYBFou03VhFKhF0s47tpkSkTxpR91/HZJYzSL/j9tzjKl0m0U98Iq3V0I34lZQQQcap
	HpNTFpnuWHCnSBUF4rLzjqatwuUyc4O0zwFFgpbhFZ9CBm837mjN3ou5+S9a/QJJy33nLPn+fwi
	I6gukTh+HpF277O1holJikLMuWHK125VV6VOega3K3HHJ2Z0ibUkJJa2tVp4josabUxq4io7Adv
	C/jO4zOdfxgFQqsNk4g558n4u3IJ2U0GS5/v8+atKTHN+HI4wf60nhiJoWCGSMGGizjvm0xAgK/
	bfrRyGd1rfCl4DpF+gHNJbwkhWcAWAKBzPQyZ4Vgm1DAsUOvoo+c0xfhzuXMMl4yYxOVtoR9ofm
	ZZAebsSw1Qcq4Ouo+SfzI4yD1ezE=
X-Received: by 2002:a05:620a:c50:b0:93c:c7c6:90b5 with SMTP id af79cd13be357-93ebd0df5abmr2614338085a.9.1791984608685;
        Wed, 14 Oct 2026 06:30:08 -0700 (PDT)
X-Received: by 2002:a05:620a:c50:b0:93c:c7c6:90b5 with SMTP id af79cd13be357-93ebd0df5abmr2614328185a.9.1791984608016;
        Wed, 14 Oct 2026 06:30:08 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcf552e8sm2027155e9.13.2026.10.14.06.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:30:07 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Armin Wolf <W_Armin@gmx.de>, Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 2/4] platform profile: Extract the core from ACPI
Date: Wed, 14 Oct 2026 15:24:45 +0200
Message-ID: <20261014132500.3817549-3-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OQW6IRLhW5oE_hmPSKVo4WuFzn4ICDdf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX4IXzH1HBiQVY
 wruH/f+cSynktOHlsZJ244yrfCCnnPYwXYEcKC4A6aIGYk+ZX2Ed0vkK9wzLveqIJqiEbGR+HM+
 PRMXuUlgx3R+Ff6XUFoNkH8WpcUpPr1MqNQLOnFDRpP+DFxlOmbShXTf73a5dx/wfIw5exfYSnf
 DzwWpoCqgFhvWfoRJtdwHs7YDChbOuRjp+2W6fxEqqHOBDMdXvKS6azClAFDwVciDIZ29M+UH49
 wpWISrvakzt1RXv0kxcB/xG8OrcKpa15/fKqa91W8+uOobT/CgT1zQnpx3nXMlw/jhcCNyzaayZ
 d2zW1TAzsAQ/rN/38u3AIzoT+ofJgBmfZzugKD7DJuc2GDB3vwyL7XW/E/teOYvX5+LVcKm6rDo
 q6l2qS390G3Q+goOAhhZpL/wngqylipBN1ILXY+hOfdO+GLpdg14/UsXakKgAUCP0CqXGQzuB5g
 vXpYeGSACq5v0idqDww==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acf83e1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=8k6WQxmsAAAA:8
 a=H7UWxkn5qGMa_TAHyjEA:9 a=-Z-CRQebJS9Ciu3_:21 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX2y/9OyIpXDS1
 zXTU6EtVV811FU/6WVKZ6Po6gs1k6n5U3bJGCi8ZL939sbNrIOx+Q9chpxQiL6qMBLZtdBY6Z1l
 zm3PuoVWNXKyyj0qycBMp2vgbvCt3XA=
X-Proofpoint-GUID: OQW6IRLhW5oE_hmPSKVo4WuFzn4ICDdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140053

Platform profile providers already use device-based callbacks and do not
need ACPI types. The core is nevertheless confined to the ACPI build and
refuses to initialize when ACPI is disabled.

Move the implementation to drivers/platform/profile and introduce the
firmware-independent PLATFORM_PROFILE symbol. Update all provider
selectors. Keep provider-specific ACPI dependencies and the
platform_profile module name.

Isolate access to the legacy ACPI kobject in an optional compatibility
object linked into the same module. Retain the legacy ABI on active ACPI
systems, and initialize the class even when ACPI is absent or disabled.

Use subsys_initcall_sync so the class is ready before built-in thermal
and CPUFreq providers, but after ACPI has initialized its compatibility
kobject.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/acpi/Kconfig                          |  3 -
 drivers/acpi/Makefile                         |  1 -
 drivers/cpufreq/Kconfig.x86                   |  2 +-
 drivers/platform/Kconfig                      | 16 +++++
 drivers/platform/Makefile                     |  2 +
 drivers/platform/profile/Makefile             |  5 ++
 drivers/platform/profile/acpi.c               | 15 +++++
 .../profile/core.c}                           | 64 +++++++++++++------
 drivers/platform/profile/profile.h            | 17 +++++
 drivers/platform/surface/Kconfig              |  6 +-
 drivers/platform/x86/Kconfig                  | 10 +--
 drivers/platform/x86/amd/pmf/Kconfig          |  2 +-
 drivers/platform/x86/dell/Kconfig             |  4 +-
 drivers/platform/x86/hp/Kconfig               |  2 +-
 drivers/platform/x86/lenovo/Kconfig           |  6 +-
 drivers/thermal/intel/int340x_thermal/Kconfig |  2 +-
 16 files changed, 118 insertions(+), 39 deletions(-)
 create mode 100644 drivers/platform/profile/Makefile
 create mode 100644 drivers/platform/profile/acpi.c
 rename drivers/{acpi/platform_profile.c => platform/profile/core.c} (94%)
 create mode 100644 drivers/platform/profile/profile.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..dd00312217de 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -351,9 +351,6 @@ config ACPI_THERMAL
 	  To compile this driver as a module, choose M here:
 	  the module will be called thermal.
 
-config ACPI_PLATFORM_PROFILE
-	tristate
-
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
 	default ""
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d1b0affb844f..f8af27341805 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -91,7 +91,6 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI)		+= container.o
 obj-$(CONFIG_ACPI_THERMAL_LIB)	+= thermal_lib.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
-obj-$(CONFIG_ACPI_PLATFORM_PROFILE) 	+= platform_profile.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit/
 obj-$(CONFIG_ACPI_NHLT)		+= nhlt.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa/
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index d6190b8dde4b..9e1e3391a084 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -39,7 +39,7 @@ config X86_AMD_PSTATE
 	select ACPI_PROCESSOR
 	select ACPI_CPPC_LIB if X86_64
 	select CPU_FREQ_GOV_SCHEDUTIL if SMP
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	select POWER_SUPPLY
 	help
 	  This driver adds a CPUFreq driver which utilizes a fine grain
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 312788f249c9..bc5acd3ebd2f 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -1,4 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config PLATFORM_PROFILE
+	tristate "Platform profile support"
+	help
+	  Provide a common sysfs interface for selecting platform power,
+	  performance and cooling profiles. Platform-specific provider drivers
+	  map their operating modes onto standard profile names, independently
+	  of the firmware interface they use.
+
+	  The core exposes per-provider controls and a system-wide interface
+	  for profiles supported by all registered providers. A provider driver
+	  must register before profile attributes become available. ACPI is not
+	  required; on ACPI systems the legacy sysfs interface is also provided.
+
+	  To compile this as a module, choose M here: the module will be called
+	  platform_profile.
+
 source "drivers/platform/mips/Kconfig"
 
 source "drivers/platform/loongarch/Kconfig"
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index fa322e7f8716..b6732f2f3c85 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -3,6 +3,8 @@
 # Makefile for linux/drivers/platform
 #
 
+obj-$(CONFIG_PLATFORM_PROFILE)	+= profile/
+
 obj-$(CONFIG_X86)		+= x86/
 obj-$(CONFIG_LOONGARCH)		+= loongarch/
 obj-$(CONFIG_MELLANOX_PLATFORM)	+= mellanox/
diff --git a/drivers/platform/profile/Makefile b/drivers/platform/profile/Makefile
new file mode 100644
index 000000000000..ae95ba09383c
--- /dev/null
+++ b/drivers/platform/profile/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PLATFORM_PROFILE) += platform_profile.o
+
+platform_profile-y := core.o
+platform_profile-$(CONFIG_ACPI) += acpi.o
diff --git a/drivers/platform/profile/acpi.c b/drivers/platform/profile/acpi.c
new file mode 100644
index 000000000000..ff925dedacaf
--- /dev/null
+++ b/drivers/platform/profile/acpi.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Compatibility with the original ACPI platform profile sysfs ABI. */
+
+#include <linux/acpi.h>
+#include <linux/kobject.h>
+
+#include "profile.h"
+
+struct kobject *platform_profile_compat_kobj(void)
+{
+	if (acpi_disabled)
+		return NULL;
+
+	return kobject_get(acpi_kobj);
+}
diff --git a/drivers/acpi/platform_profile.c b/drivers/platform/profile/core.c
similarity index 94%
rename from drivers/acpi/platform_profile.c
rename to drivers/platform/profile/core.c
index f98ce4cda02c..f18fd96b942c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/platform/profile/core.c
@@ -4,21 +4,36 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/acpi.h>
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/init.h>
+#include <linux/idr.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_profile.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
 
+#include "profile.h"
+
 #define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, dev))
 
 static DEFINE_MUTEX(profile_lock);
 /* Serialize registration and sysfs updates without blocking sysfs callbacks. */
 static DEFINE_MUTEX(profile_registration_lock);
 static LIST_HEAD(profile_handlers);
+static struct kobject *compat_kobj;
+
+static void profile_notify(void)
+{
+	if (compat_kobj)
+		sysfs_notify(compat_kobj, NULL, "platform_profile");
+}
+
+static int profile_update(void);
 
 struct platform_profile_handler {
 	struct list_head node;
@@ -237,7 +252,7 @@ static ssize_t profile_store(struct device *dev,
 			return ret;
 	}
 
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	profile_notify();
 
 	return count;
 }
@@ -452,7 +467,7 @@ static ssize_t platform_profile_store(struct kobject *kobj,
 			return ret;
 	}
 
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	profile_notify();
 
 	return count;
 }
@@ -478,6 +493,14 @@ static const struct attribute_group platform_profile_group = {
 	.is_visible = profile_class_is_visible,
 };
 
+static int profile_update(void)
+{
+	if (compat_kobj)
+		return sysfs_update_group(compat_kobj, &platform_profile_group);
+
+	return 0;
+}
+
 /**
  * platform_profile_notify - Notify class device and legacy sysfs interface
  * @dev: The class device
@@ -487,7 +510,7 @@ void platform_profile_notify(struct device *dev)
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
 		_notify_class_profile(dev, NULL);
 	}
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	profile_notify();
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
 
@@ -534,7 +557,7 @@ int platform_profile_cycle(void)
 			return err;
 	}
 
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	profile_notify();
 
 	return 0;
 }
@@ -609,9 +632,9 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	scoped_guard(mutex, &profile_lock)
 		list_add_tail(&to_pprof_handler(ppdev)->node, &profile_handlers);
 
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	profile_notify();
 
-	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
+	err = profile_update();
 	if (err)
 		goto cleanup_cur;
 
@@ -650,8 +673,8 @@ void platform_profile_remove(struct device *dev)
 	ida_free(&platform_profile_ida, pprof->minor);
 	device_unregister(&pprof->dev);
 
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-	sysfs_update_group(acpi_kobj, &platform_profile_group);
+	profile_notify();
+	profile_update();
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
 
@@ -699,28 +722,33 @@ static int __init platform_profile_init(void)
 {
 	int err;
 
-	if (acpi_disabled)
-		return -EOPNOTSUPP;
-
 	err = class_register(&platform_profile_class);
 	if (err)
 		return err;
 
-	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err)
-		class_unregister(&platform_profile_class);
+	compat_kobj = platform_profile_compat_kobj();
+	if (compat_kobj) {
+		err = sysfs_create_group(compat_kobj, &platform_profile_group);
+		if (err) {
+			kobject_put(compat_kobj);
+			class_unregister(&platform_profile_class);
+		}
+	}
 
 	return err;
 }
 
 static void __exit platform_profile_exit(void)
 {
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	if (compat_kobj) {
+		sysfs_remove_group(compat_kobj, &platform_profile_group);
+		kobject_put(compat_kobj);
+	}
 	class_unregister(&platform_profile_class);
 }
-module_init(platform_profile_init);
+subsys_initcall_sync(platform_profile_init);
 module_exit(platform_profile_exit);
 
 MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
-MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
+MODULE_DESCRIPTION("Platform profile sysfs interface");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/profile/profile.h b/drivers/platform/profile/profile.h
new file mode 100644
index 000000000000..910c9f7da6a0
--- /dev/null
+++ b/drivers/platform/profile/profile.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _PLATFORM_PROFILE_INTERNAL_H
+#define _PLATFORM_PROFILE_INTERNAL_H
+
+#include <linux/kconfig.h>
+#include <linux/kobject.h>
+
+#ifdef CONFIG_ACPI
+struct kobject *platform_profile_compat_kobj(void);
+#else
+static inline struct kobject *platform_profile_compat_kobj(void)
+{
+	return NULL;
+}
+#endif
+
+#endif
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index f775c6ca1ec1..08f15f72f8ed 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -203,12 +203,12 @@ config SURFACE_PLATFORM_PROFILE
 	tristate "Surface Platform Profile Driver"
 	depends on ACPI
 	depends on SURFACE_AGGREGATOR_REGISTRY
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	help
-	  Provides support for the ACPI platform profile on 5th- and later
+	  Provides support for platform profiles on 5th- and later
 	  generation Microsoft Surface devices.
 
-	  More specifically, this driver provides ACPI platform profile support
+	  More specifically, this driver provides platform profile support
 	  on Microsoft Surface devices with a Surface System Aggregator Module
 	  (SSAM) connected via the Surface Serial Hub (SSH / SAM-over-SSH). In
 	  other words, this driver provides platform profile support on the
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b54b5212b204..76b42f68c9cc 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -120,7 +120,7 @@ config BITLAND_MIFS_WMI
 	depends on INPUT
 	depends on LEDS_CLASS
 	depends on POWER_SUPPLY
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	select INPUT_SPARSEKMAP
 	help
 	  This is a driver for Bitland MiInterface based laptops.
@@ -180,7 +180,7 @@ config ACER_WMI
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	help
 	  This is a driver for newer Acer (and Wistron) laptops. It adds
 	  wireless radio and bluetooth control, and on some laptops,
@@ -279,7 +279,7 @@ config ASUS_WMI
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	help
 	  Say Y here if you have a WMI aware Asus laptop (like Eee PCs or new
 	  Asus Notebooks).
@@ -646,7 +646,7 @@ config SAMSUNG_GALAXYBOOK
 	depends on INPUT
 	depends on LEDS_CLASS
 	depends on SERIO_I8042
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	select FW_ATTR_CLASS
 	help
 	  This is a driver for Samsung Galaxy Book series notebooks. It adds
@@ -906,7 +906,7 @@ config TOUCHSCREEN_DMI
 config INSPUR_PLATFORM_PROFILE
 	tristate "Inspur WMI platform profile driver"
 	depends on ACPI_WMI
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	help
 	This will allow users to determine and control the platform modes
 	between low-power, balanced and performance modes.
diff --git a/drivers/platform/x86/amd/pmf/Kconfig b/drivers/platform/x86/amd/pmf/Kconfig
index 25b8f7ae3abd..a0bdd85db6a0 100644
--- a/drivers/platform/x86/amd/pmf/Kconfig
+++ b/drivers/platform/x86/amd/pmf/Kconfig
@@ -8,7 +8,7 @@ config AMD_PMF
 	depends on ACPI && PCI
 	depends on POWER_SUPPLY
 	depends on AMD_NODE
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	depends on TEE && AMDTEE
 	depends on AMD_SFH_HID
 	depends on HAS_IOMEM
diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index 9f0016056d7e..f6acf1cc2a2f 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -44,7 +44,7 @@ config ALIENWARE_WMI_WMAX
 	bool "Alienware WMAX WMI device driver"
 	default y
 	depends on ALIENWARE_WMI
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	help
 	 Alienware WMI driver with AlienFX LED, HDMI, amplifier, deep sleep and
 	 AWCC thermal control capabilities.
@@ -120,7 +120,7 @@ config DELL_PC
 	depends on ACPI
 	depends on DMI
 	depends on DELL_SMBIOS
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	help
 	This driver adds support for controlling the fan modes via platform_profile
 	on supported Dell systems regardless of formfactor.
diff --git a/drivers/platform/x86/hp/Kconfig b/drivers/platform/x86/hp/Kconfig
index dd51491b9bcd..81a52194ff42 100644
--- a/drivers/platform/x86/hp/Kconfig
+++ b/drivers/platform/x86/hp/Kconfig
@@ -43,7 +43,7 @@ config HP_WMI
 	depends on RFKILL || RFKILL = n
 	select POWER_SUPPLY
 	select INPUT_SPARSEKMAP
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	select HWMON
 	help
 	  Say Y here if you want to support WMI-based hotkeys on HP laptops and
diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/lenovo/Kconfig
index 4443f40ef8aa..c8606ad56139 100644
--- a/drivers/platform/x86/lenovo/Kconfig
+++ b/drivers/platform/x86/lenovo/Kconfig
@@ -12,7 +12,7 @@ config IDEAPAD_LAPTOP
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on ACPI_WMI || ACPI_WMI = n
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	select INPUT_SPARSEKMAP
 	select NEW_LEDS
 	select LEDS_CLASS
@@ -63,7 +63,7 @@ config THINKPAD_ACPI
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on I2C
 	depends on DRM
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	select DRM_PRIVACY_SCREEN
 	select HWMON
 	select NVRAM
@@ -250,7 +250,7 @@ config LENOVO_WMI_GAMEZONE
 	tristate "Lenovo GameZone WMI Driver"
 	depends on ACPI_WMI
 	depends on DMI
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	select LENOVO_WMI_EVENTS
 	select LENOVO_WMI_HELPERS
 	help
diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 4ced7bdcd62c..3026a0a8d073 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -12,7 +12,7 @@ config INT340X_THERMAL
 	select ACPI_THERMAL_LIB
 	select INTEL_SOC_DTS_IOSF_CORE
 	select INTEL_TCC
-	select ACPI_PLATFORM_PROFILE
+	select PLATFORM_PROFILE
 	select PROC_THERMAL_MMIO_RAPL if POWERCAP
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
-- 
2.43.0

