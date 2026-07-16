Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3213911C6;
	Thu, 16 Jul 2026 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784245554; cv=none; b=CAfZ0uY7+zAihP5ItzEaOp2d9YwhXZh3rJk1h3E3rXnMmzMa6JoBDc9Kra3buR1x0eg7JPKtbLM826RJTAPvd7pQ+UCBSK+JMlSHApBesn3fT55Qfl8hVoIXe/12kxptqjuE9xbUBOobIQiSsREnp6CMN6h+lF9KKxhQjGHar/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784245554; c=relaxed/simple;
	bh=abCHIlldQQtt7s1CFRAZ5pcNm1oweXARv4WgS38jA3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6W40y/l6GJs8wwIrYEcVlPMGg+pNv61xovivHJXLL11kYtqJW0YDZkTqysvECMNJgigI89zCO/XyTYobMh8tREZpWqOcYCIc3MznEeHjzFPHqLtn/gOSAFH7+cJmhplYndRNuO/PrfZfX5Cswhz3b9P+stLBbUOk+4HIOMWG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=steFCfxW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="steFCfxW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784245550; x=1784850350; i=w_armin@gmx.de;
	bh=qDb/5jHjmIciW6o8UFVRtYtF3ZZRAHGy4KPssHhH96g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=steFCfxW3IO/awVCUPdclzUiHQTxlebJ+rsU6bBFRO6qtIcVRWsOOORiOe1W9yWa
	 DZAYHu3s8uFylRfyxuAeSpbxYjmR+GwMppNhnfGf+l8fHHd1iHNf/lh/uEqRClSwz
	 bNQdw4I5NxM59o4xeh4oAXXXgMVxat6we3wPmOYAb+yHVI+HIYevCPzww97A6ck6z
	 NjXE2engjf4ZW8RM57anq7fkqpxt153ONYYw4SHtb+wbkFbGo3wmQppqCbydHi1pw
	 M0BOdYjpownnslO8Q/nxHtptQ2TRyQOXtxRP39v5z6opJN++Ek5z5FLtwLJQdZAB0
	 642/DMUi+QQC7/vmZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1wfqwh0YMr-0081pI; Fri, 17
 Jul 2026 01:45:50 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: wmi-bmof: Move to generic WMI code
Date: Fri, 17 Jul 2026 01:45:38 +0200
Message-Id: <20260716234538.1303811-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260716234538.1303811-1-W_Armin@gmx.de>
References: <20260716234538.1303811-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q7wV5GjO2o5WQpGTy8j30DvAly4ckKSglqoXXsIM1D+Vo+PrXI9
 rvU2LyYhxQrflCTgTHaQAaWpXJIy3cWXtyWyw0EtmOodzTqpZ6dQkmLaJHwrok2fqQbd4Pf
 Kb5FPAsZWY0yuxmQL2s7WMZSLWfxbPu5k+jyTQBuQbIss/ymSvT0iDiTI00J545oXC1hLd9
 T3nLJpHMvMxjgL783YFsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MFKd/0iSoJ8=;DN8yHG3HzxoOGrSHRWvdiZMqwSF
 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

Some Windows-on-Arm notebooks contain embedded Binary MOF data,
accessible using the WMI-ACPI interface. Move the associated driver
to the generic WMI code to make it possible to build it on arm64.
Also rework the Kconfig help text a bit.

Link: https://lists.linaro.org/archives/list/aarch64-laptops@lists.linaro.=
org/thread/U2IZENSIOOHZHGXVN7GM5HX5O3FD5KCF/
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 MAINTAINERS                                     |  2 +-
 drivers/platform/wmi/Kconfig                    | 12 ++++++++++++
 drivers/platform/wmi/Makefile                   |  4 ++++
 drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} |  0
 drivers/platform/x86/Kconfig                    | 12 ------------
 drivers/platform/x86/Makefile                   |  3 ---
 6 files changed, 17 insertions(+), 16 deletions(-)
 rename drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3820b286f09f..bbae729a6012 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29106,7 +29106,7 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/stable/sysfs-platform-wmi-bmof
 F:	Documentation/wmi/devices/wmi-bmof.rst
-F:	drivers/platform/x86/wmi-bmof.c
+F:	drivers/platform/wmi/bmof.c
=20
 WOLFSON MICROELECTRONICS DRIVERS
 L:	patches@opensource.cirrus.com
diff --git a/drivers/platform/wmi/Kconfig b/drivers/platform/wmi/Kconfig
index 36934b5f0194..11c221a58e04 100644
=2D-- a/drivers/platform/wmi/Kconfig
+++ b/drivers/platform/wmi/Kconfig
@@ -34,4 +34,16 @@ config ACPI_WMI_LEGACY_DEVICE_NAMES
=20
 source "drivers/platform/wmi/tests/Kconfig"
=20
+config WMI_BMOF
+	tristate "WMI embedded Binary MOF driver"
+	default ACPI_WMI
+	help
+	  Say Y here if you want to be able to read the firmware-embedded
+	  WMI Binary MOF (Managed Object Format) data. Using this requires
+	  userspace tools, see Documentation/wmi/devices/wmi-bmof.rst for
+	  details.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called wmi-bmof.
+
 endif # ACPI_WMI
diff --git a/drivers/platform/wmi/Makefile b/drivers/platform/wmi/Makefile
index 2feff94a5594..ee2f27ea20d1 100644
=2D-- a/drivers/platform/wmi/Makefile
+++ b/drivers/platform/wmi/Makefile
@@ -9,3 +9,7 @@ obj-$(CONFIG_ACPI_WMI)	+=3D wmi.o
=20
 # Unit tests
 obj-y			+=3D tests/
+
+# Binary MOF driver
+wmi-bmof-y		:=3D bmof.o
+obj-$(CONFIG_WMI_BMOF)	+=3D wmi-bmof.o
diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/wmi/bmof.c
similarity index 100%
rename from drivers/platform/x86/wmi-bmof.c
rename to drivers/platform/wmi/bmof.c
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 957034f39e4e..889979034391 100644
=2D-- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -16,18 +16,6 @@ menuconfig X86_PLATFORM_DEVICES
=20
 if X86_PLATFORM_DEVICES
=20
-config WMI_BMOF
-	tristate "WMI embedded Binary MOF driver"
-	depends on ACPI_WMI
-	default ACPI_WMI
-	help
-	  Say Y here if you want to be able to read a firmware-embedded
-	  WMI Binary MOF (Managed Object Format) data. Using this requires
-	  userspace tools and may be rather tedious.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called wmi-bmof.
-
 config HUAWEI_WMI
 	tristate "Huawei WMI laptop extras driver"
 	depends on ACPI_BATTERY
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 872ac3842391..94a5fe4075cb 100644
=2D-- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -4,9 +4,6 @@
 # x86 Platform-Specific Drivers
 #
=20
-# Windows Management Interface
-obj-$(CONFIG_WMI_BMOF)		+=3D wmi-bmof.o
-
 # WMI drivers
 obj-$(CONFIG_HUAWEI_WMI)		+=3D huawei-wmi.o
 obj-$(CONFIG_MXM_WMI)			+=3D mxm-wmi.o
=2D-=20
2.39.5

