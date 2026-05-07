Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2CD37BE66;
	Thu,  7 May 2026 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184911; cv=none; b=U4NmHqAMJEmnyexATE3DQZAtErLrngyl1LCktFv6nSTkCJjFLxoz7d8a9ktvVlTqFQWPqevqNZY55GUSIjIVUiRflIq8nXQr1rKG7iUpgXuW05HR9NNTun6qjLiwECwYxhxk5OMKydufiD2L3z4ACU/Oh4Bc19DG31t8FHiNET8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184911; c=relaxed/simple;
	bh=fJEM3KPikfriIkd+qR5h2fgNDPuFi8Nf+lzoFQ0Mg8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzzVgyK3ig6+PZoM2jJE9biHKlB9fgrgeCFmDZvfHvl7daC8hi6r6Obp68FIXZayJjMonaHfUkn+OvMm/lHaoyMMSKmUWOFzDN3e+7Is3cXpmRDteAkgs9hH+BXU6tqT4Ll6tbwQ9n+Jq+e0UrPI8GwxcCiqDIwWVpJqelz2jyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt6oaQjW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt6oaQjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870CDC2BCB8;
	Thu,  7 May 2026 20:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778184910;
	bh=fJEM3KPikfriIkd+qR5h2fgNDPuFi8Nf+lzoFQ0Mg8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mt6oaQjWpATpiONpCbW15SDGNmtKB3AkN8USrmpY+QkFicMsgr077tuBjJwoyNMBA
	 4WxWades2ljZvvo40ZcCXSgEk1H4Obr+MBNkl5tBn+jxg4qupWqgHHG0ifdjogBvpC
	 QePur9HI+MPetYHxbmNFzHk6AvacMSCM8RNtmMprPjDWsWyrZl9qSKFPxNgZWdqFg9
	 eg6MEPkA4U20KNwaxhZmJFlhM2++SRW9fHjRKAI3h2Bx/qKZQyTnFgcNnl0udIk/Y1
	 /rsQJsy7ILTCa6U9wyQMUrTcX7EsXkTNUmAPudSEMoKH/PiM7CB23KKFzvnmotRqtv
	 aAqKGmMoNgOpA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v1 01/10] platform/x86: classmate-laptop: Address memory leaks on
 driver removal
Date: Thu, 07 May 2026 22:00:11 +0200
Message-ID: <14005591.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <1956046.tdWV9SEqCh@rafael.j.wysocki>
References: <1956046.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Update cmpc_accel_remove_v4() and cmpc_accel_remove() to free memory
allocated in cmpc_accel_add_v4() and cmpc_accel_add(), respectively.

Fixes: 529aa8cb0a59 ("classmate-laptop: add support for Classmate PC ACPI devices")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/classmate-laptop.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index e6eed3d65580..218834ddddc3 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -441,9 +441,13 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 
 static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 {
+	struct input_dev *inputdev = dev_get_drvdata(&acpi->dev);
+	struct cmpc_accel *accel = dev_get_drvdata(&inputdev->dev);
+
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	cmpc_remove_acpi_notify_device(acpi);
+	kfree(accel);
 }
 
 static SIMPLE_DEV_PM_OPS(cmpc_accel_pm, cmpc_accel_suspend_v4,
@@ -680,8 +684,12 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 
 static void cmpc_accel_remove(struct acpi_device *acpi)
 {
+	struct input_dev *inputdev = dev_get_drvdata(&acpi->dev);
+	struct cmpc_accel *accel = dev_get_drvdata(&inputdev->dev);
+
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 	cmpc_remove_acpi_notify_device(acpi);
+	kfree(accel);
 }
 
 static const struct acpi_device_id cmpc_accel_device_ids[] = {



