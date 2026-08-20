Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC893890F0;
	Thu, 20 Aug 2026 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205462; cv=none; b=NUWYwrW+ZYPyWpPos0S6HfOEZv5P2cXLRcAIkpnkOnp0kPMIit8nLzI7tIc5ANpHbPLJwd5XwX9HP8wuu4kdJaPDesjnnn7+WtIt2P2XcYaYs7TVTCGNM/x8l6V0PXut2K6Zgpzh7NUpQUAm4Xl8OQWZDGz8Z09fPJFAlGm9ufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205462; c=relaxed/simple;
	bh=VezqNZRWjRCRfcLFaKNfwdB6E1n8px538Qjhvan02eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hdmmjBTTVtyfcFN78AQyudbP2b9s7d7mx7uKvm0zVlQxQgTVCVtr04JE51GF5mrqUkW6jPA7maRr/KyjL5P8jekkR7ehkCeNVvWyjwd1xYRnnUj0In9PbzzdUxqeMejdvjvYAI+tXAjfQezT05L5ctTOBXZYlGS9eBHHSEYIG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=vvSps+at; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="vvSps+at"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1787205403;
	bh=bcShL4yRNMeJbaXV+VtZOq9y2o6H/8jejmpbx4U9lCg=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=vvSps+atRHksDPDdDF8uswTjzYGrwLaMDafP77ywRdkds1TReQa6N/HstmdO/+cYA
	 mVRnwY3vPYP3evicXc6wX1gR1uvYbbIFXvGBuFPljj+odE2mFwDwKPV9SDklLJgJeg
	 iLI8fIPdVU5oDkZpeVUoE5R0AQ7Dhtw0srb1JzUA=
X-QQ-mid: zesmtpgz6t1787205397tab0e3186
X-QQ-Originating-IP: x254ti6aAr8rl5Tp7c3jDE9bo3sP3cwKL05anGSe00s=
Received: from [127.0.1.1] ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Aug 2026 13:56:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11710364144512296637
EX-QQ-RecipientCnt: 8
From: Peixin Xie <peixin.xie@linux.spacemit.com>
Date: Thu, 20 Aug 2026 13:56:27 +0800
Subject: [PATCH v2] ACPI: scan: Defer device power initialization
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-acpi-power-resource-ref-fix-v2-1-29818173ea13@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBCFr0K6dghT/4or72FYlDqVMUKbFhBDu
 LsFL2BmM1/ey/dmESkwRXHJZhFo5MiuSyB3mTCN7h4EfE8sZCFPhUIEbTyDd28KECi6IRhKjwX
 LE0irD+dS2WNZ1CIZfAp42uy36sdxqJ9k+lW5NhqOvQufbX7Etfff0oiAoKSyaPYqHV5f3A1TH
 r021HKfG9eKalmWL1PL4pzhAAAA
X-Change-ID: 20260811-acpi-power-resource-ref-fix-2fa4798f590b
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Yixun Lan <dlan@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Peixin Xie <peixin.xie@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787205396; l=5271;
 i=peixin.xie@linux.spacemit.com; s=20260727; h=from:subject:message-id;
 bh=VezqNZRWjRCRfcLFaKNfwdB6E1n8px538Qjhvan02eo=;
 b=A7bKK2zQrsRaJdcNy4xZ7p4KCmUBaduS0JGzYClQBaXO5WF5C2CQPVOldehzX52xINdCib63/
 zuYjjjTEcjfBCbpw1vNfwjXiLCpYq6+nFrBTTHV7eJsvyaOYejXDZX/
X-Developer-Key: i=peixin.xie@linux.spacemit.com; a=ed25519;
 pk=jczO0FmEQZBoClfXslkwCsHKDmSRchQ1hQr8W7yiiXg=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NwJg8C0xnZ9fhGo8BWyNBCzimJtZNtUoHTCWP+UECdyvt86srJwYaaG6
	w4Ypf/JKURcZG2PoPeYmmrXb4cAEsq8cc/ApP5dsdqQjCgALDOnccTwiEnMzCbzcpmil0eG
	jeUI4JJpGOotLz/68g26YAk/wM6YWk9KVZddmTlKE5mzoEavUm9tyttzGhky8a9/itk2Evf
	kownriHzA3JLXNVbjpp/FEaJ14mCGrRlMiMl1evAYNIhoY5HoUT6FGJvjfv+1BZwleIXG3l
	6q2HXVrwj1DIHuEec3kt9SA/LDNJxnNHzJez359S08xUAwa/yXAasEyjUNHv3eo23P8nd+R
	kozJfno/3OkPnjjp3FaQgDrZIJEnnLt94CepkuZXYpI5qskIuDL0SpsDPQO841WQoD8bZFe
	wteipd5XA9R74SkM5/Aem45JvRRhun06bSMi8ty2rEodBeaCUzTgwDyJ0/DnSQTw7ypUKTt
	I2KvuRGlvDjJj3W1VmgfiVkg0FSS9dW1LpDetQHWTA+CXdITisBYiJBHrWuuGzEIvWChjxu
	3z5cliITuxkOFCufPebWjEm0kWX+TQT+X1QItkbreIKntehhqFMINpcA7MENycWqM3JibPU
	tOTdVsX4VHJlo/NCNYNrnvap0h1sZQ4PgtMNVi8xMpyRq1Pwe5Bo0emqJyCzGkDKVc6BwUN
	i3KKnvi62GnOq9kIkTnj1qRXIR5VPItuUiCmqCiAEqiCiG5qx2LoXpC0yc2TJ11MiGcRU8K
	xP39pPDVHP3BpTFRNKBz4fNeCZjx3YWsz2gOmNhyAkUEPbcvkwqaRpo++RuTh+jFuD2FCLN
	U3PPqZh0csOieKdGeSh5W5h3OH/c53gxARjSfS50MxsFT6vOVL6H0lnDLQWoYuV4vXEx3AD
	GrcW62kO4/uBrab7eJ+/NWUjzhuSJcrD0RrBULk8GEvGWfz3zACr5+0qcBrKZK9eE6Ze/XJ
	Mh3ziTtcjcuz27QqcrAYU6un6pfC1VeDRWvf6X5rEQn4ZuPazdAqj3pMhZki1j66zBcWB7E
	3M0JdeOja/Y695L2diKJPpq9zYQdaoRf/KuB7mMSljfS32DS0xWm5FtLRyR7sGAVKJBD1JY
	9T41JSSxekdVngAb0RmJGbzgv2NONHL78Ls2Twg7ETn91V2vC+kTpo=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

acpi_bus_get_power_flags() initializes the device power state while the
ACPI device object is being created, before checking whether the device
is ready for enumeration.

If enumeration is deferred, acpi_bus_attach() clears the initialized and
power_manageable flags. When the dependency is later satisfied,
acpi_bus_init_power() is called again and takes additional references to
the power resources used by the device. These references prevent the
resources from being turned off when the device enters D3.

Remove the early acpi_bus_init_power() call and leave regular ACPI device
objects uninitialized until acpi_bus_attach() runs after the device is
ready for enumeration.

Power resource objects are initialized through acpi_add_power_resource()
and do not require the generic initialization in acpi_bus_attach(), so
mark them as initialized there.

This also avoids powering up devices before their dependencies are
available.

Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
---
This issue was reproduced on a SpacemiT K3 RISC-V Pico-ITX. The affected
device uses a power resource through _PR0 and has an automatically derived
dependency on its interrupt controller.

Before the change, the initial power initialization acquires a power
resource reference. The device is then deferred, but that reference is not
dropped. When the dependency becomes available, power initialization
acquires another reference. Consequently, entering D3 only drops the
reference count from 2 to 1 and _OFF is not evaluated:

 [    0.314611] ACPI Debug:  "I2P2 _STA"
 [    0.318260] ACPI: \_SB_.I2P2: ACPI: PM: Power resource is on
 [    0.323998] ACPI: \_SB_.I2P2: New power resource
 [    0.382108] ACPI Debug:  "I2P2 _STA"
 [    0.478964] ACPI Debug:  "I2P2 _ON"
 [    0.482498] ACPI: \_SB_.I2P2: ACPI: PM: Power resource turned on
 [    0.488597] ACPI Debug:  "I2C2, PS0"
 [    0.863170] ACPI: \_SB_.I2P2: ACPI: PM: Power resource already on
 [    0.873686] ACPI Debug:  "I2C2, PS0"
 [    2.416055] ACPI Debug:  "I2C2, PS3"
 [    2.423397] ACPI: \_SB_.I2P2: ACPI: PM: Power resource still in use

After the change, device power state initialization is deferred until its
dependency is met. Since no reference is acquired before then, the power
resource left on by firmware is turned off as unused after the namespace
scan. Once the dependency is met, the resource is turned on once for the
device and is turned off normally when the device later enters D3:

[    0.314628] ACPI Debug:  "I2P2 _STA"
 [    0.318277] ACPI: \_SB_.I2P2: ACPI: PM: Power resource is on
 [    0.324016] ACPI: \_SB_.I2P2: New power resource
 [    0.382118] ACPI Debug:  "I2P2 _STA"
 [    0.496116] ACPI: \_SB_.I2P2: ACPI: PM: Turning OFF
 [    0.501081] ACPI Debug:  "I2P2 _OFF"
 [    0.504705] ACPI: \_SB_.I2P2: ACPI: PM: Power resource turned off
 [    1.415899] ACPI Debug:  "I2P2 _ON"
 [    1.418866] ACPI: \_SB_.I2P2: ACPI: PM: Power resource turned on
 [    1.424947] ACPI Debug:  "I2C2, PS0"
 [    2.647655] ACPI Debug:  "I2C2, PS3"
 [    2.654856] ACPI Debug:  "I2P2 _OFF"
 [    2.654866] ACPI: \_SB_.I2P2: ACPI: PM: Power resource turned off
---
Changes in v2:
- Replace the D3cold transition added in v1 with deferred device power
  initialization, as suggested by Rafael.
- Mark power resource objects as initialized in their dedicated creation
  path.
- Link to v1: https://patch.msgid.link/20260811-acpi-power-resource-ref-fix-v1-1-828f1c383831@linux.spacemit.com
---
 drivers/acpi/power.c | 1 +
 drivers/acpi/scan.c  | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index d4131c184be8..4f1479103bfe 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -955,6 +955,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	INIT_LIST_HEAD(&resource->dependents);
 	device->power.state = ACPI_STATE_UNKNOWN;
 	device->flags.match_driver = true;
+	device->flags.initialized = true;
 
 	/* Evaluate the object to get the system level and resource order. */
 	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9a7ac2eb9ce0..489352ba80e1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1141,9 +1141,6 @@ static void acpi_bus_get_power_flags(struct acpi_device *device)
 		if (!list_empty(&device->power.states[ACPI_STATE_D3_HOT].resources))
 			device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
 	}
-
-	if (acpi_bus_init_power(device))
-		device->flags.power_manageable = 0;
 }
 
 static void acpi_bus_get_flags(struct acpi_device *device)
@@ -1822,7 +1819,6 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	acpi_init_properties(device);
 	acpi_bus_get_flags(device);
 	device->flags.match_driver = false;
-	device->flags.initialized = true;
 	device->flags.enumeration_by_parent =
 		acpi_device_enumeration_by_parent(device);
 	acpi_device_clear_enumerated(device);

---
base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
change-id: 20260811-acpi-power-resource-ref-fix-2fa4798f590b

Best regards,
--  
Peixin Xie <peixin.xie@linux.spacemit.com>

