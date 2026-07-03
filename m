Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6723C1F2B;
	Fri,  3 Jul 2026 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078720; cv=none; b=fv/X/4x+OMrJQnuNbvpbBgVCgVNktTKIpJywniy4lNbJp1n8zP+j6fxJLHVzKPDWpq4OhbqCKUQAdFcZdyFGhuAEacgqXBoophvYF2g1SAGQYEYL1N7Ms3yNLb7MkLojJdE8KuefgSmkCI58T0jOYGGLqKTyr8XDFM9KZSLXj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078720; c=relaxed/simple;
	bh=3x5M4wuxSbJc9iPEjAQDlspfrgKAeE0Q/wVTII3vK+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTTCBr8bH6hq6sCo6YmMsljXqfdN36A9Us04wHt1BLQkXhTBc0aSiyCoAdnFADLjEwfex6+dMj+UhLvy243Xg3tofnkTvfncLIw6WpMhYQArB2h4uXIcCV/3EMktm+uAe3ZqNRWHTGljpmGP7/mqP56AOd2eFnF9+ezmJxIyztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z55+4hyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z55+4hyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA41E1F000E9;
	Fri,  3 Jul 2026 11:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078718;
	bh=rgz2wERDv4Z4W2if1sLazEfLXZxQifbs+GAbB5dR0EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z55+4hyhUOMaeJ/9V4euxjJ6maIIoVDT/hcRFGMranQm5o2ZtOLFXYMvHMEBhLyZH
	 DePY1LMx5Ouls6Vkti67cH1qg5AVaFSneHD4ulKqF6KM8KXEpIvhLyX94SUKZdtudo
	 pKtQ8J89Tls5LH4qst8cZPNossPRFz+K2n7tHXQoY1fjMxah8cIG3KjIcl3PgMrlC7
	 b7zQ+YpqRQioJPyqBjmctGyPl7uoUWkhXanNRwL1lOj8r6PMrVXFmNw+FPmhsIHWWl
	 q5+T67TzEi1AHH6KmWQiFYYZ4z3e3huzvKD+GVFU7oqE/A+sGi33O5/es6xp5J+lWB
	 82nOkEeBPbxoA==
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
 [PATCH v1 08/10] platform/x86: toshiba_acpi: Do not use uninitialized
 device_class
Date: Fri, 03 Jul 2026 13:36:05 +0200
Message-ID: <3642854.QJadu78ljV@rafael.j.wysocki>
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

The pnp.device_class string in the ACPI companion of the platform
device used for binding the driver is never initialized, so passing
it to acpi_bus_generate_netlink_event() is effectively equivalent to
passing an empty string literal to that function.

Accordingly, make the driver do the latter instead of doing the former.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/toshiba_acpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 7cecb3a70b9c..a0b8060836d0 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2505,8 +2505,7 @@ static void toshiba_acpi_kbd_bl_work(struct work_struct *work)
 				LED_FULL : LED_OFF);
 
 	/* Emulate the keyboard backlight event */
-	acpi_bus_generate_netlink_event(toshiba_acpi->acpi_dev->pnp.device_class,
-					dev_name(&toshiba_acpi->acpi_dev->dev),
+	acpi_bus_generate_netlink_event("", dev_name(&toshiba_acpi->acpi_dev->dev),
 					0x92, 0);
 }
 
@@ -3250,8 +3249,7 @@ static void toshiba_acpi_notify(acpi_handle handle, u32 event, void *data)
 		break;
 	}
 
-	acpi_bus_generate_netlink_event(acpi_dev->pnp.device_class,
-					dev_name(&acpi_dev->dev),
+	acpi_bus_generate_netlink_event("", dev_name(&acpi_dev->dev),
 					event, (event == 0x80) ?
 					dev->last_key_event : 0);
 }
-- 
2.51.0




