Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33C3C9ED5;
	Fri,  3 Jul 2026 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078749; cv=none; b=mluCmQgFGB0gZUtsB5jqqrQ6DQ/03v0fqJXWJoAJXj4EDi/ahXLkttbD8Hm+2Tj0KnxiUnj83nqBFCIADeZxVhL/fnKHqNWnjw/qMcNGFQnqzbw/f8XoUFOhXLONPdg7ZSFPZjYduuLicfedMB9eZvYGGSZFkN2JviaiLlwBSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078749; c=relaxed/simple;
	bh=TYJYz/Z5jJFKzEv1oBAgZi3SBXUR44vMwYb1NjqQW5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ti4pNTcwE1bQPBE5ud05Jdtqva11PZwHLrlAZLI0YtChnCAzKCC3OEy4C8QzrlElOP8ADk5CKjW53sIIrF1LLDWrdmRKtutdsgMPt7psbD9SXCmqPKcL2ObYQadI+Q+SSVXmCdTgFTcIQH2ziwFnnfnn2OGi+COGJyLFzgau++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKeqgTUo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKeqgTUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16421F000E9;
	Fri,  3 Jul 2026 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078747;
	bh=Q5N305PE5Mqdqj+IlML2PoLMZLWDS7oyb5VKxpzDpmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gKeqgTUovS7vCqBeGVECAYNyVc7XqoJXSyQuj04Mxr/3m0eUqPVWF/eECmQhAIqYE
	 RfiUIUlNTgMBZ4XPOiWTAZJUdJbQXudgbPJ3SQK1M9sF1amyvEW7jP1wWfqBL+8cik
	 qLQuz75CIZk8TQtiP8S4O11cT9Q7ea7YrIfm4U/c8HXQPhrY+XcS8GJtBa+R/6rpzB
	 GWDLPl5RmWGnILtaFWGApW2aCmuXh5+IzeaKnhrzY+vBK2wdrP+zw2cShO5f07x2ZO
	 nKuXWgrCAqsbyhjih1BTot/gMVcHY3pW8wH8ACgikBbvfjKvsrveKKROV7mIVPTopx
	 DcoGPfegU3HLg==
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
 [PATCH v1 02/10] platform/x86: eeepc-laptop: Stop setting
 acpi_device_name/class()
Date: Fri, 03 Jul 2026 13:21:09 +0200
Message-ID: <2291726.irdbgypaU6@rafael.j.wysocki>
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

The driver sets acpi_device_name() which is never read afterward,
so make it stop doing that and drop the symbol defined specifically
for this purpose.

Likewise, acpi_device_class() set by the driver is only used for
generating ACPI netlink events, but the "hotkey" string literal may
as well be used directly for that, so make the driver do so and stop
setting acpi_device_class(), and drop the symbol defined specifically
for this purpose.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index d18a80907611..8a640c25830a 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -34,8 +34,6 @@
 #define EEEPC_LAPTOP_NAME	"Eee PC Hotkey Driver"
 #define EEEPC_LAPTOP_FILE	"eeepc"
 
-#define EEEPC_ACPI_CLASS	"hotkey"
-#define EEEPC_ACPI_DEVICE_NAME	"Hotkey"
 #define EEEPC_ACPI_HID		"ASUS010"
 
 MODULE_AUTHOR("Corentin Chary, Eric Cooper");
@@ -1214,8 +1212,7 @@ static void eeepc_acpi_notify(acpi_handle handle, u32 event, void *data)
 	if (event > ACPI_MAX_SYS_NOTIFY)
 		return;
 	count = eeepc->event_count[event % 128]++;
-	acpi_bus_generate_netlink_event(device->pnp.device_class,
-					dev_name(&device->dev), event,
+	acpi_bus_generate_netlink_event("hotkey", dev_name(&device->dev), event,
 					count);
 
 	/* Brightness events are special */
@@ -1376,8 +1373,6 @@ static int eeepc_acpi_probe(struct platform_device *pdev)
 	if (!eeepc)
 		return -ENOMEM;
 	eeepc->handle = device->handle;
-	strscpy(acpi_device_name(device), EEEPC_ACPI_DEVICE_NAME);
-	strscpy(acpi_device_class(device), EEEPC_ACPI_CLASS);
 	eeepc->device = device;
 
 	platform_set_drvdata(pdev, eeepc);
-- 
2.51.0




