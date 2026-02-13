Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F7F21B9DA;
	Fri, 13 Feb 2026 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007147; cv=none; b=jkRuLXDxvM1IhjlPfUZWp5FLqX/e0H2fwtxkZeyyDynT/mWhWYzYLGsnuARZgVMA/+iVDCFO+DKafQsac5yG7DT5EHKsoQXeeQF0+/OOHEbSsfgkMs8/Qmn0EnqFgmx/wtBwnx3n7lZ849HuOI1L34D8NbT2AX+mH8wD2mdIM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007147; c=relaxed/simple;
	bh=jwX9Lvz055na9QcVYDpA9G3IVm4kPPp0U1fKYtwF1Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K07/x1Anj35XIyP3pCtMTgw/xdEQmT7deR7NSvm3ODSK6rDU9THyF0a1LVZkXmpRgVfUx0pmPGuOZ3GSQ4tUW8eMpEpDox0r6EPzB/YznXvCVk3lKDwip32Xg9LnQmMeBV6gBhBrULJ4lmDLeTTiiBVsddr3Qv+qMAEB++Qn02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBWIjTJp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBWIjTJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851DFC116C6;
	Fri, 13 Feb 2026 18:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771007146;
	bh=jwX9Lvz055na9QcVYDpA9G3IVm4kPPp0U1fKYtwF1Zo=;
	h=From:To:Cc:Subject:Date:From;
	b=YBWIjTJp+N3Ib7PJq6aMUyXcj2pmqrQSp5DsSz1qoX6/LQxXNEobPaZWtAC/2dFS4
	 hI0R0g/+/EIT//6oHcLVp6EniKG7l/QcGIgzDk1+Uu7snmA7iMFw3rfBTIi6+NOW7s
	 6q56If+nX0IAFJkRLAT89xZ1v21tp72WrlY2r7zTQ3Hu51swctOd4+RnVy+4gyskkD
	 wr4PVSRXZayGww/NKS/pYsQYBglVVdffpirKauq9K/hgpeMV2WigNWkbHdrGwwj+Lp
	 qhtGwRycxasXkZw7CWTjZxgHH+MAOPFS680TD4BzU2q6q5880FTWDAK8+5GVn0N3E3
	 EUkDj8XVXhx2Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1] ACPI: video: Clear driver_data pointer on remove
Date: Fri, 13 Feb 2026 19:25:43 +0100
Message-ID: <12840288.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 02c057ddefef ("ACPI: video: Convert the driver to a
platform one") the driver_data pointer in the ACPI companion device
object is not cleared automatically on driver remove any more, so
clear it directly in acpi_video_bus_remove().

Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Applies on top of the current mainline.

---
 drivers/acpi/acpi_video.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2116,6 +2116,7 @@ static void acpi_video_bus_remove(struct
 
 	kfree(video->attached_array);
 	kfree(video);
+	device->driver_data = NULL;
 }
 
 static int __init is_i740(struct pci_dev *dev)



