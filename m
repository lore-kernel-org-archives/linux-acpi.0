Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676D38E8A0;
	Fri,  3 Jul 2026 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078734; cv=none; b=RxMHd5USj2r88kVKGBvocBW1PEk/dWPzu8eN/9X4t7UDEm99vNmhjeBWuAQTZyeBc+4KZsu1yYWQYCpP+jEtNb7jDnRCyuyAdrSPtvdARX/z1zShFHmiHDPF4BbiPDUb0aTlwVEZxshwgoapkWEQOLirFI70zDnQe8hUSWswmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078734; c=relaxed/simple;
	bh=ffY4N6iLgbxfnm55JLKkXlEZCBBBJIENWoC1U1o4LIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDGxfIidcgl7x97nFTqF5ZdLqF9JxfaM+GIm9KeUvMaDbf2RKph4mJOz2jdGyMA5FjlSTGqzVeLBaropQpd3jez/8a4EHqqG50Tp96+pSqMSDCFJPmDMGsh/cppDLxmv0cOZJO8NrW6mTEmCZzzg3O10kWkrBjktRwHU6u3UL/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQmcrkvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQmcrkvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5326E1F000E9;
	Fri,  3 Jul 2026 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078733;
	bh=IJFfte6+tCEfx+eo8/28AZzmGGDzDaHYwir6QRpTcFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hQmcrkvTih28rTAEEoGk3L/KwMLXRSoUeQj6fYIW2D4UNA6ItV/wdd9jwz3T1dFOJ
	 J00/r12dR+/zfxA8Nxf2OLsRIrQQTieZeXicXUEqYPwOr9V52z9BciMnrONJ3FzFp7
	 qErOPbc7cfvAsFIMSZdQnT0ycaCIVDbe4Ad/GSgeAOT99tuqnk3dQQP6ReXWXWyFAT
	 rxqfZ94JdkmmyvKYlTc9ZeWCd2Z5zjX1tU2Wn5t3FJ7mKJlFd/kf9XUEAE4mG748/5
	 LSHirE7NrE1rV8q3DL8EH3sN4UOV87vRnOlj3088pYnnym+8t0WVqyQSuUwNDc25d7
	 eykFRRUKk494A==
From: "Rafael J.  Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <denis.benato@linux.dev>, Jonathan Woithe <jwoithe@just42.net>,
 Robert Gerlach <khnz@gmx.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, Mattia Dongili <malattia@linux.it>,
 Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 05/10] platform/x86: thinkpad_acpi: Stop setting
 acpi_device_class()
Date: Fri, 03 Jul 2026 13:30:00 +0200
Message-ID: <23182921.EfDdHjke4D@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5135166.31r3eYUQgx@rafael.j.wysocki>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate the removal of device_class from struct acpi_device_pnp
in the future, make the driver store the device class string used for
generating ACPI netlink events in a new device_class field in struct
ibm_struct.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/lenovo/thinkpad_acpi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
index 445e1403308e..f614b2701d48 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -309,6 +309,7 @@ struct tp_acpi_drv_struct {
 
 struct ibm_struct {
 	char *name;
+	acpi_device_class device_class;
 
 	int (*read) (struct seq_file *);
 	int (*write) (char *);
@@ -838,9 +839,8 @@ static int __init setup_acpi_notify(struct ibm_struct *ibm)
 	}
 
 	ibm->acpi->device->driver_data = ibm;
-	scnprintf(acpi_device_class(ibm->acpi->device),
-		  sizeof(acpi_device_class(ibm->acpi->device)),
-		  "%s/%s", TPACPI_ACPI_EVENT_PREFIX, ibm->name);
+	scnprintf(ibm->device_class, sizeof(ibm->device_class), "%s/%s",
+		  TPACPI_ACPI_EVENT_PREFIX, ibm->name);
 
 	status = acpi_install_notify_handler(*ibm->acpi->handle,
 			ibm->acpi->type, dispatch_acpi_notify, ibm);
@@ -3869,7 +3869,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		pr_err("unknown HKEY notification event %d\n", event);
 		/* forward it to userspace, maybe it knows how to handle it */
 		acpi_bus_generate_netlink_event(
-					ibm->acpi->device->pnp.device_class,
+					ibm->device_class,
 					dev_name(&ibm->acpi->device->dev),
 					event, 0);
 		return;
@@ -3949,7 +3949,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		/* netlink events */
 		if (send_acpi_ev) {
 			acpi_bus_generate_netlink_event(
-					ibm->acpi->device->pnp.device_class,
+					ibm->device_class,
 					dev_name(&ibm->acpi->device->dev),
 					event, hkey);
 		}
-- 
2.51.0




