From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] ACPI: Fix problem with GPE storm from buttons
Date: Mon, 14 Jul 2014 22:39:32 +0200
Message-ID: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52009 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756932AbaGNUXe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jul 2014 16:23:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Lan Tianyu <tianyu.lan@intel.com>

Hi All,

This patch series attempts to fix a problem with GPE storms from
buttons described in the changelog of patch [3/3].

Patches [1/3] and [2/3] are ACPICA material, patch [3/3] is for Linux/ACPI.

Thanks,
Rafael

