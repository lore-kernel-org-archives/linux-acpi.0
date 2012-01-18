From: Robert Lee <rob.lee@linaro.org>
Subject: [RFC PATCH v3] ARM: imx: Add basic imx6q thermal management
Date: Tue, 17 Jan 2012 22:48:06 -0600
Message-ID: <1326862087-17816-1-git-send-email-rob.lee@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:42164 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756831Ab2AREsL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 23:48:11 -0500
Received: by obcva7 with SMTP id va7so6705660obc.19
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 20:48:10 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux@arm.linux.org.uk, s.hauer@pengutronix.de, shawn.guo@freescale.com
Cc: amit.kachhap@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

Based on v3.2 plus recently submitted cpu_cooling functionality here:

http://www.spinics.net/lists/linux-pm/msg26500.html

link to v2 submission:

http://www.spinics.net/lists/arm-kernel/msg155790.html

Changes since v2:
1. Fixed the various issues pointed out in v2
2. Made other code cleanup and a bit of re-organizing
3. Removed unecessary platform driver and device.

Performed some basic testing to ensure proper cooling operating.  If
you want to test this, full testing requires imx6q cpufreq
implementation (not yet in v3.2) and requires an imx6q part that has
temperature sensor calibration fuses correctly burned.

Robert Lee (1):
  ARM: imx: Add basic imx6q thermal management

 arch/arm/boot/dts/imx6q.dtsi    |    1 +
 drivers/thermal/Kconfig         |    6 +
 drivers/thermal/Makefile        |    1 +
 drivers/thermal/imx6q_thermal.c |  520 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 528 insertions(+), 0 deletions(-)
 create mode 100644 drivers/thermal/imx6q_thermal.c

