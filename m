Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18739524C;
	Fri, 20 Mar 2026 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003006; cv=none; b=d4UqGkqNA6I3g0wxOWE8oozERwI1iuCXDNNcT2ggCmO0DIHPR5N215u5ZPI6O2la62ZWSa8V41suz59LriwAePU56TCWruPpRr9An0DcsLQwk9lOLyNywjHRHd5YYQlPuhhGpJJcg6JVFBwYZM0Yi7XUiUkVTZBS8X4Spc6A1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003006; c=relaxed/simple;
	bh=llUAyfm74dfq8miM7uDlWm2HLVsRalO/jD1+2lYZtXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLLZru8W9CYWXc0n49ttgdny8IEPCthiHrtK2UYVnCNBTTVsrNkDZpmPnC+z4+b9U6AllMgozXW6OdV4rwhyNh602vYlVB9C4Dt1eLkA0FKH43RklYc3klKZ/JTxdDx6geC2nHUvYOViULP5fRoIlbJ8LI1w0h+UQ3GOLJoY4Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC04o8gl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC04o8gl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F89AC4CEF7;
	Fri, 20 Mar 2026 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774003005;
	bh=llUAyfm74dfq8miM7uDlWm2HLVsRalO/jD1+2lYZtXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XC04o8glgDhxMvY4yz5anPGlV9KOusbF029NocjvYHBfqeGSZsva3raBusBsq0imc
	 RSWr0Xcidqztgpc/BIaug/MuLLt/76s5LwCIwcNUawEJenXDwFKBxWhCn5HlcI8J3y
	 trWjVNL3lnGp/u74p+4vKQVffmecZkIYZ9qiYinbtU7Gwj7k3ifkex3oLWkr3ZOXwN
	 r62f/a2Zyz4Pk4KJrMJzg2AXNsvQmAgF4p+wYZmaCEqmFxLHEcEKbzmUosZ23bL79U
	 1p1CgFalzSCdkykuIlyjVEG6H/fdxdeHLUilGtirqCUWXbez7vA8SH+RPJksF/MngM
	 jfaIXr3cRhRMA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v4 2/5] platform/x86: panasonic-laptop: Fix OPTD notifier registration
 and cleanup
Date: Fri, 20 Mar 2026 11:31:54 +0100
Message-ID: <2411055.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5983583.DvuYhMxLoT@rafael.j.wysocki>
References: <5983583.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

An ACPI notify handler is leaked if device_create_file() returns an
error in acpi_pcc_hotkey_add().

Also, it is pointless to call pcc_unregister_optd_notifier() in
acpi_pcc_hotkey_remove() if pcc->platform is NULL and it is better
to arrange the cleanup code in that function in the same order as
the rollback code in acpi_pcc_hotkey_add().

Address the above by placing the pcc_register_optd_notifier() call in
acpi_pcc_hotkey_add() after the device_create_file() return value
check and placing the pcc_unregister_optd_notifier() call in
acpi_pcc_hotkey_remove() right before the device_remove_file() call.

Fixes: d5a81d8e864b ("platform/x86: panasonic-laptop: Add support for optical driver power in Y and W series")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4: No changes

v2 -> v3: Do not fail probing on OPTD registration errors (note that it is
   not a bug to attempt to unregister an ACPI notify handler that has not
   been registered)

v1 -> v2: New patch

---
 drivers/platform/x86/panasonic-laptop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index a481f2602ce3..56b4e61d7e5c 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -1090,9 +1090,10 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 		}
 		result = device_create_file(&pcc->platform->dev,
 			&dev_attr_cdpower);
-		pcc_register_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 		if (result)
 			goto out_platform;
+
+		pcc_register_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 	} else {
 		pcc->platform = NULL;
 	}
@@ -1126,10 +1127,10 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 	i8042_remove_filter(panasonic_i8042_filter);
 
 	if (pcc->platform) {
+		pcc_unregister_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 		device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
 		platform_device_unregister(pcc->platform);
 	}
-	pcc_unregister_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 
-- 
2.51.0




