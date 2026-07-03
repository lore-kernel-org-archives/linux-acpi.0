Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AFC38E8A0;
	Fri,  3 Jul 2026 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078739; cv=none; b=oFSWX+F/J/ZS+tdsg+vrDV6s2NyQWPNMgqk9cZy12b0NkppblJ2QhHsoXX3L6mEPoP9gNxGsV1Acr3gAXeo0lQ3gySfNgZ5iU7W2BH+1Xd22J52+ovCZc5l+wSTklAmImmCNcaDsTyuMTRZJkGqMhSRgJoKMIvXwGIc7dbg7h24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078739; c=relaxed/simple;
	bh=a5Qpc9DVimR/8kcSPVCsLVjfVGfJlg5KZjN6/fwdFdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYGUusf3KFCAdJEi5wq1hUQ2e1QUmn5YyBYDWZlrbL6WG9WZn5QoYSjPDrhLTRJtqU21n282mhJIlC2NBolN+ySNAjeK9b4IvFZ9MBYRwKF055cPc/tbh0Tho28Kzgd4OGif5xA8BENCz2z6/6+YO+U8ISoMIvhFI5wZEFvVogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heRxJECA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heRxJECA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3939B1F000E9;
	Fri,  3 Jul 2026 11:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078738;
	bh=LaqcQM23O9VJnJeccqtlldxfRZe/a0ieEx374T6ST60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=heRxJECAorOsaSV63jssGcYgnjFL2doZMoz8R4XQXUYcj7cmvD/N/B6kOmyPoE2SF
	 b+t0S1ta8q3N3SaFMsjZrEoUXbWGz+TCgfDr1nYa0OJZ59mY2TpKNHgs8lOtkN6TEH
	 MUEqEKhGIfmRPuW3dNne23OVAGUBRFcvj/Go8e4YW6an1e91rF8Jtsvgb2dfV7oJWA
	 BAvZDx9z8xuGJzcZ8o3sU+V+JT8YMCZuR9XAb/lhuNNvqRtdMdrStQR8/0S+aPxVv5
	 fUNqvXCih4nOiG2mYmxV0dIYTCobH9nHKZZ39Un16iPFC8QUSbdgfoO0ZBkoj/MTUX
	 3LFBIe+85sUnA==
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
 [PATCH v1 04/10] platform/x86: fujitsu-tablet: Stop setting
 acpi_device_name/class()
Date: Fri, 03 Jul 2026 13:28:41 +0200
Message-ID: <2378407.iZASKD2KPV@rafael.j.wysocki>
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

The driver sets acpi_device_class() which is never read afterward,
so make it stop doing that and drop the symbol defined specifically
for this purpose.

For consistency, also make it stop setting acpi_device_name() and add
a name field to the "fujitsu" structure for storing the name string
used during input class device initialization.

While at it, use scnprintf() instead of snprintf() for populating the
name and phys fields of the "fujitsu" structure.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/fujitsu-tablet.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-tablet.c b/drivers/platform/x86/fujitsu-tablet.c
index 2f8c1b89cbca..386ad3aaace8 100644
--- a/drivers/platform/x86/fujitsu-tablet.c
+++ b/drivers/platform/x86/fujitsu-tablet.c
@@ -22,8 +22,6 @@
 
 #define MODULENAME "fujitsu-tablet"
 
-#define ACPI_FUJITSU_CLASS "fujitsu"
-
 #define INVERT_TABLET_MODE_BIT      0x01
 #define INVERT_DOCK_STATE_BIT       0x02
 #define FORCE_TABLET_MODE_IF_UNDOCK 0x04
@@ -160,6 +158,7 @@ static struct {
 	struct fujitsu_config config;
 	unsigned long prev_keymask;
 
+	char name[17];
 	char phys[21];
 
 	int irq;
@@ -458,14 +457,10 @@ static int acpi_fujitsu_probe(struct platform_device *pdev)
 	if (ACPI_FAILURE(status) || !fujitsu.irq || !fujitsu.io_base)
 		return -ENODEV;
 
-	sprintf(acpi_device_name(adev), "Fujitsu %s", acpi_device_hid(adev));
-	sprintf(acpi_device_class(adev), "%s", ACPI_FUJITSU_CLASS);
-
-	snprintf(fujitsu.phys, sizeof(fujitsu.phys),
-			"%s/input0", acpi_device_hid(adev));
+	scnprintf(fujitsu.name, sizeof(fujitsu.name), "Fujitsu %s", acpi_device_hid(adev));
+	scnprintf(fujitsu.phys, sizeof(fujitsu.phys), "%s/input0", acpi_device_hid(adev));
 
-	error = input_fujitsu_setup(&pdev->dev,
-		acpi_device_name(adev), fujitsu.phys);
+	error = input_fujitsu_setup(&pdev->dev, fujitsu.name, fujitsu.phys);
 	if (error)
 		return error;
 
-- 
2.51.0




