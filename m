From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [RFC PATCH v2] ARM: imx: Add basic imx6q thermal management
Date: Mon, 16 Jan 2012 22:51:37 -0600
Message-ID: <CAMXH7KEhv9LgvvJ-FnLfaFZNgvJu2gOhFDwpYHDzN9iCDXHjJw@mail.gmail.com>
References: <1326775136-32115-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:61576 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab2AQEvk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jan 2012 23:51:40 -0500
Received: by qcsf13 with SMTP id f13so1875382qcs.19
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jan 2012 20:51:39 -0800 (PST)
In-Reply-To: <1326775136-32115-1-git-send-email-rob.lee@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux@arm.linux.org.uk, s.hauer@pengutronix.de, shawn.guo@freescale.com
Cc: amit.kachhap@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

link to v1 submission:

http://www.spinics.net/lists/arm-kernel/msg155111.html

Based on v3.2 plus recently submitted cpu_cooling functionality here:

http://www.spinics.net/lists/linux-pm/msg26500.html

Changes since v1:
1. Cleaned up some style issue pointed out in v1
2. Made various other code cleanup and re-organizing
3. Added temperature sensor calibration
4. Created platform driver and device to hook into pm suspend.

Performed some basic testing to ensure proper cooling operating.  If
you want to test this, full testing requires imx6q cpufreq
implementation (not yet in v3.2) and requires an imx6q part that has
temperature sensor calibration fuse correctly burned.
