From: alex@local.promotion-ie.de
Subject: [PATCH] Re: acpi shutdown problem on SMP (tyan tiger mp, athlon)
Date: Mon, 16 Aug 2004 11:16:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1092647783.8494.4.camel@pro30.local.promotion-ie.de>
References: <1092376617.8529.13.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267493AbUHPJQO@vger.kernel.org>
In-Reply-To: <1092376617.8529.13.camel@pro30.local.promotion-ie.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi

This patch fixes poweroff on my Tyan Tiger S2460 - AMP 760 MP mainboard.
I also test ist on my UP ACPI systems and none broke.

Please verify if it breaks poweroff on other systems.

Alexander

diff -u -r -N linux-2.6.8.1/drivers/acpi/hardware/hwsleep.c
linux-2.6.8.1-acpifix/drivers/acpi/hardware/hwsleep.c
--- linux-2.6.8.1/drivers/acpi/hardware/hwsleep.c	2004-08-16
09:53:05.000000000 +0200
+++ linux-2.6.8.1-acpifix/drivers/acpi/hardware/hwsleep.c	2004-08-16
10:00:41.257905209 +0200
@@ -284,6 +284,11 @@
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);
 		}
+	} else {
+		status = acpi_hw_clear_acpi_status (ACPI_MTX_DO_NOT_LOCK);
+		if (ACPI_FAILURE (status)) {
+		return_ACPI_STATUS (status);
+		}
 	}
 
 	/*

Am Fr, den 13.08.2004 schrieb Alexander Rauth um 7:56:
> this problem first appeared in vanilla-2.6.2 and is still present in
> vanilla-2.6.8-rc4 (vanilla-2.6.1 worked fine)
> 
> on shutdown the disks spin down, the VGA switches to powersave, but the
> cpu-fans and the power-supply won't power down.
