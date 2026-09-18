Received: from ks5.debiolley.be (ks5.debiolley.be [91.121.65.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFDB483BD4
	for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.65.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725872; cv=none; b=CSoYDheQVjg81/N6XePEvFt4B3mVCEZ6IzW6y/N+6QjmPqA6gQ34NwffY/8j6a7k+vh9gM40B14dFKzpoU/ih9UP/Tcmy/5ZQ/lN3r3bDr4Dg2nZwa3w7hmKyJBXaDkT3oBAmUqDHQdJF86oPEc+c7pEclSUjYwvo4A3epDKs00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725872; c=relaxed/simple;
	bh=hmYpp6BFTNK1eHfBBGNzDBFUFqsmDC9Af6DNScMkCwU=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=gmE5DIRAJquK/bb2KV7LZ3gqeYXVRHBNKPtuihm/qgxuZQTxnrWyoyUVwWF7igvyD4j2ZN1PTiQK/U13S3Ru2+4liqrJj2vskuLNGUQ0FNy/aXDCBUIkPqS3zgBud/vkQtdoV3cPqbzN23K/t0jjFuquZm0O6zXNjo6zpj2aDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=debiolley.be; spf=pass smtp.mailfrom=debiolley.be; dkim=pass (4096-bit key) header.d=debiolley.be header.i=@debiolley.be header.b=cf15Giy/; arc=none smtp.client-ip=91.121.65.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=debiolley.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debiolley.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=debiolley.be header.i=@debiolley.be header.b="cf15Giy/"
Received: from ks5.debiolley.be (localhost [127.0.0.1])
	by ks5.debiolley.be (Postfix) with ESMTP id 0AA984A0D9E0;
	Fri, 18 Sep 2026 11:57:52 +0200 (CEST)
Received: from debiolley.be (localhost [127.0.0.1])
	(Authenticated sender: benoit@debiolley.be)
	by ks5.debiolley.be (Postfix) with ESMTPA id AB0E94A031D0;
	Fri, 18 Sep 2026 11:57:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debiolley.be;
	s=default; t=1789725471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YvNXOsBE1bPW/z7cS8AwTGSLWQ99KZm3CV30WMRrzbU=;
	b=cf15Giy/yQzWXvt3/exMybobeeMtRfKGRlC3gKrmkitxaA768xqOx/RT3WIcZJIg8ckKnB
	6ai3IMX2ymtejJeRwOLuYQcNWUYBH3SJoyeSS3DJyHocBSwcqq0WVrUKx0MkNLBPalbH3r
	Ec+ReMF5696C9ZVaFKwwiMauT1L/CY0nBDgJNRJg7QhABjiRw9fw17XhLezm6V1yMT6Wkf
	jf+l4ijcDXKrUU1zAH5oi4tV4dU8dniDg8spmlfkCwdNJwKqzAQW4+U7rK1+LbEczp7kJA
	pcezMGi9WGWq3h2CBij0Bj4C/BA9/el5wIobpmG/4mb9mXY/mMYmYAf8Bm3LSpD12xuyJc
	DHwGXBQ9REAuvXDvRc+rzgJGLZTZy7Y5vI+eclM6Kj3p8W1ggSGShGMHmf0wZRJc61fumr
	nFqXmvHDq1dPTCERrl9vBA0fXUKFhOgES2sKfrcaRtFfm2JJ4C+cdkg82aXpRC9vcYsC30
	USV11ekMWO5WqogDDNjMKKyIAbNRQDNJFhoPFnrlThclWXP1HKLeBPXcVFsz38YjI1GNDF
	Uh/bQeJG6VhH6BV2a5VuvS46ykIZu9V8nsxMNejf83O4EafBzKOk5iU9yALWUcZQAkS95W
	qlzsxxDXSrItLXeKnAbbpwhDRJ7KcIScbZ9bAJ1w0fOuZJsSOcOiw=
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 11:57:51 +0200
From: benoit@debiolley.be
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org
Subject: ACPI: enumeration of devices declaring only _CID (no _HID/_ADR)
Message-ID: <41d7284368586f7590bfbbe7996d171d@debiolley.be>
X-Sender: benoit@debiolley.be
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On an Acer One 10 S1003 (Intel Atom x5-Z8350, Cherry Trail, Insyde BIOS V1.19)
the internal SDIO WiFi is never enumerated by Linux, while it works under
Windows. The root cause is a firmware bug, but I would like to ask whether the
kernel could reasonably be more lenient about it.

The SDIO host controller the WiFi chip sits on is declared like this:

    Device (SDHB)
    {
        Name (WADR, Zero)
        Name (WHID, "80860F14")
        Name (AHID, "INT33BB")
        Name (_CID, "PNP0D40")
        Name (_DDN, "Intel(R) SDIO Controller - 80862295")
        Name (_UID, 0x02)
        ...
        Method (_STA, 0, NotSerialized)
        {
            If (((SI0A == Zero) || (SD2D == One))) { Return (Zero) }
            Return (0x0F)
        }
        Method (_CRS, 0, NotSerialized) { ... }   /* valid MMIO + IRQ */
    }

It declares neither _HID nor _ADR, only _CID. Its two siblings SDHA (eMMC) and
SHC1 (SD card) both declare _HID "80860F14" and are enumerated normally.

iasl flags it when recompiling the untouched table:

    DSDT.dsl 9134:  Device (SDHB)
    Error 6141 - Missing dependency ^ (Device object requires a _HID or _ADR)

So this is firmware violating the spec. The node is otherwise complete and
functional: _STA returns 0x0F, and _CRS returns a valid MMIO range plus IRQ.

What happens on Linux: acpi_set_pnp_ids() sets pnp->type.platform_id only in
the ACPI_VALID_HID branch, never for _CID. acpi_bus_attach() then calls
acpi_default_enumeration() only when platform_id is set, so no platform device
is created. sdhci-acpi is never probed, no MMC host is created, the SDIO bus is
never scanned and brcmfmac never loads. The device is visible in sysfs with
hid=PNP0D40 (taken from _CID) and status=15, but with no physical_node and no
driver bound:

    $ cat /sys/bus/acpi/devices/PNP0D40:00/status
    15
    $ ls /sys/bus/acpi/devices/PNP0D40:00/
    device:1e  device:1f  hid  modalias  path  power  power_state  status
    subsystem  uevent  uid
    (no physical_node, no driver)

sdhci-acpi does list PNP0D40 in both sdhci_acpi_ids[] and sdhci_acpi_uids[], so
it would have bound had a platform device existed.

Adding "Name (_HID, \"80860F14\")" to that node via a patched DSDT loaded
through CONFIG_ACPI_TABLE_UPGRADE is sufficient to make it work: sdhci-acpi
binds, the SDIO card is found, brcmfmac loads and the interface comes up.
(The _HID value is not invented: the node already carries WHID = "80860F14"
alongside AHID = "INT33BB", evidently its "Windows" and "Android" identities,
and its existing _UID = 2 maps to sdhci_acpi_slot_int_sdio, which is correct.)

    mmc2: SDHCI controller on ACPI [80860F14:01] using ADMA
    mmc2: new high speed SDIO card at address 0001
    brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43430a0-sdio
              for chip BCM43430/0

My question: would it be acceptable for acpi_default_enumeration() to fall back
to _CID when a device declares no _HID and no _ADR but does have _STA and _CRS?
Windows evidently enumerates such nodes, and a DSDT override is a heavy
workaround to ask of users for what is a single missing name in the firmware.

I appreciate there may be good reasons not to relax this, in which case please
treat the report as documentation of the failure mode: it is silent, with no
error anywhere in dmesg, and took a full DSDT disassembly to find.

I am happy to test patches on this hardware.

Reported on 6.14.0-35-generic (Ubuntu/Mint), but the relevant logic in
drivers/acpi/scan.c is unchanged in current mainline.
