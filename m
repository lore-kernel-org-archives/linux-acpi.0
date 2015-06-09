From: "Peter Huewe" <PeterHuewe@gmx.de>
Subject: Aw: [PATCH] acpi: update ACPI tables to match TCG ACPI
 specification.
Date: Tue, 9 Jun 2015 14:07:09 +0200
Message-ID: <trinity-b5129e33-2cf5-43f9-9352-51827d9b4b8e-1433851629779@3capp-gmx-bs16>
References: <1433849475-20670-1-git-send-email-jarkko.sakkinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:63245 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933256AbbFIMHV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2015 08:07:21 -0400
In-Reply-To: <1433849475-20670-1-git-send-email-jarkko.sakkinen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: robert.moore@intel.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT AR..." <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>

> [PATCH] acpi: update ACPI tables to match TCG ACPI specification.
> Updated struct acpi_table_tpm2 and struct acpi_table_tcpa to match the
> TCG ACPI specification. Removed struct acpi_tpm2_control as this data
> structure is not part of the ACPI interface but is device interface
> used with TPM 2.0 chips possibly even without ACPI in some cases.

> That structure probably dived in by mistake because it was bundled with
> the TPM2 ACPI table in the Microsoft specification before there were
> official TPM2 interface specifications available from TCG.

> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Peter Huewe <peterhuewe@gmx.de>
Acked-by: Peter Huewe <peterhuewe@gmx.de> # for TPM subsystem
