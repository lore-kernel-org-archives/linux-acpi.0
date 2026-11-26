Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713693;
	b=DgetywCSE6wTNPFU/wa5nsJihdH3L/CPpFI2VF2h/vJTEfR6knM4SNqWJWHWvJ25S6Xa
	 O7/Y5gZBjC7zw3FB+2lZjTh2rwwBKVZ6kb+GbGpuqMdAXh6jCOyjcxUf7mufnFf3qy2Go
	 4yySACHLRbqaldpLPwygLQBsk0DZjcdw7C/Fsi+HdV+I/XNqA5LDLd7/tvgtxGIsVA9eI
	 WN11CQr+vardByd5zcqrq/aGIYM0xsA12LFgRiw+RP//CjT+kBhV8gZiCoj9RL124yBVw
	 Wza3A5XlZmIr1VLglc5WEbHy13AQpHE4coaYMIwNDfJQJXBF2Sl2giIotJVTMLtjsrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=PfNgmba12Q/4pv9fP06XSiAZ4Zk40dNRsJAuWaJ8SFA=;
	b=put7Vj9vGKwm5pgA1evp4if4yRf70uECXa20uhIFvgzWo6eSa9MMMpQdIAG6Xs6jAL7q
	 3YeXG/gkuWF7iog0fIQEIeenPJcxjjzWnvsxFG4pA5jgt644lV99vPRrqwGo8zmwp4R1A
	 x5Dgt2BvZlptdbAoj00xmAl+VdGVnyXZT6xl9FH9NF1WnrGhs/PVT2QADLjTLpKyE888l
	 AFldR9NteJ2SUFEfWl1guK6g2p3igZR2gY0/HixvslViVrYjGMovsYrhkZoapKwuqDFev
	 uhEAIVzZ+5G8M4FyQyPxzFFrE+GBMp9LD6lncfttGFXCTJKl8a8zN9IKk2fvGmdCjeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=beagleboard.org;
	spf=fail smtp.mailfrom=beagleboard.org;
	dkim=pass header.d=beagleboard.org header.i=@beagleboard.org header.a=rsa-sha256 header.s=google header.b=wcB8W5fZ;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E339606A32D
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 17:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E339606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=beagleboard.org header.i=@beagleboard.org header.a=rsa-sha256 header.s=google header.b=wcB8W5fZ
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386ab9ab619so9616418eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard.org; s=google; t=1795713692; x=1796318492; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PfNgmba12Q/4pv9fP06XSiAZ4Zk40dNRsJAuWaJ8SFA=;
        b=wcB8W5fZh6T3k2/n48GExZpr5pB7DVEBeaEd2ISK/4wiE9NE+X3cK8FCDSONTVhXj+
         0H+ArWL8eYn2T7N7tAkY/IAcYWF+Jsqth5ipgMh9R9W12tzt//0PjCQa1Ss6kx374HLj
         6yeSLY4ET8r+TaLiWov1uUWUreFT9eaJK27ySIynDmXDISE1LjEDe5zpEdmDjJEZGouz
         GHp+6X9SdD9WPdPe5qiOn5mmCsjPJcDcGwRsvwbMmCLyG5HSyxMbJ0ln/ExrZqjZpZKo
         AhygYIh0eAfShJf04GsGxgVH16twHS22SA5vcp0MHrK8hfdrOPFYencUb75xNeGH/JC/
         GAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795713692; x=1796318492;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PfNgmba12Q/4pv9fP06XSiAZ4Zk40dNRsJAuWaJ8SFA=;
        b=GbFTsF65OhFLZlXv8jm/LY7mRoE4xEdxVJ35KqTubKNFSzStHdj7Wr2sU0j75vzKcw
         NlNnb28V2NtCVQhzbgw1vBDQ7blt/NdsqeYVHccgvxlhLQrbRP8ZSxXg1lUpmXNlyq1a
         HnaMiubKU8UxXP8Qc1tdbarLEwxNPvnX3aI3Ozar6y8Bj92Fn5ZMDBnhe/Smez9/jAhd
         BfPJuovSPPNrhVqAfbCge/UJZPEOZPnfD/B/CxA6ZOj5yYqp7Vqb8b85s11skqJtXy4W
         sT1rBp3ZHtnC2tW3iCz+gqWZ0Vn4x65C93xGBBQJoY3iqZak5kUwRA8y8/Pwgz3SVD6t
         dkug==
X-Gm-Message-State: APuU4Z9ZA+jid4zU68QnGKUX2mOToytjMr+d5CX0oK2JawY/Bl6u5okr
	5TTntp8o+yFk7hfQrMpsNaKIkIQ06OAyCpMkCEryCvGGX8TAS2pQv5oqxiAdaspOCQ==
X-Gm-Gg: AZFdTZeO7Ti0AQGao+VxHOiutpaWmbcjtjQeZmyjsJ2syVrJo3DwSTMe3dVHG79/8Oy
	oj/XhNscMBWBKx4xbBKnBGyboaSUCSSDU7v0p/NIbKZ3luAwlbtcXbXlaXJ2nqpcBo2RWLA0gBm
	N52Nr6wVJWEkHYGfXh/w1HqZhF8RmVQXRaAd+uqyUtIBF8y1tjJjuTcnQrWxAqvljHzE5rCU+kC
	CdXUUxjnG9iC9aaDKdLWxZuUsdFjyvDOgVwagW/MmUxELPhNbiva5bGUdc0oANVu5DmfIq1h2jA
	E43UodRPcSsyq2Y+eSZ7i+cNPwQoq06aWfI+2UCn4JrM7yiS8EDf72HXBztx2Hgzq+y4rQUTUKm
	Akn8ciiDC2OZ9ZTGjgD8Nyzh67J4AvZFaWlEYKQx1fZfH+thXBoyOQrC3rehZ/ghvXgNHGkAS85
	WZq1kWYX61OjIMALwHfI5dV6vMs6NP3uXYzsiTzTSu672hu4ZBsw+yktqSHvnNOftE+DnOS+aI0
	W6gXGajRHUNA1DYuWsAKMovDVhkX88BRcrkMsZQaOm1qILDLfYBc/1FK34NITRwEYLnJwPZbD7D
	Rtp1wmQV0nvcE/haFb5cIs7MoNB1r1glPfCPapH8AqupK3f9Q8CpIexQZ85l
X-Received: by 2002:a05:7300:de44:b0:375:c5e1:931d with SMTP id 5a478bee46e88-3857073ebabmr21809220eec.25.1795713691974;
        Thu, 26 Nov 2026 09:21:31 -0800 (PST)
Received: from [192.168.29.131] ([2405:201:4019:32fc:2fd:478e:999:d6fd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm80638997eec.11.2026.11.26.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 09:21:31 -0800 (PST)
From: Ayush Singh <ayush@beagleboard.org>
Date: Thu, 26 Nov 2026 22:51:07 +0530
Subject: [PATCH v2] ACPI: power: Evaluate power resource _ON methods
 exclusively
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-ssd-fix-v2-1-32c91f6532e3@beagleboard.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/z3MQQrDIBAAwK/InrVkTTA1p/yj5KB1NQslFi0hJ
 eTvpYH2OofZoVJhqjCIHQqtXDkvMAgtBdxntyRSHGAQoBttELVWtQYVeVPG986b1vbWBJACnoU
 ib+d0m6SAmesrl/cZr/jV39H9jxUVKqIrxa5F23gcPbn0IJ9dCZdcEkzHcXwAO4aVYqQAAAA=
X-Change-ID: 20261122-ssd-fix-6b7ab639796d
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3604; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=scaIQdSo8yK8WKKmDlfqg0jPD/+11cdjBi/EMSzB2xU=;
 b=owEBbQKS/ZANAwAKAQXO9ceJ5Vp0AcsmYgBrCGqXr8hp6mXq9jzn93WuYsVUslIF2ulCNBiiO
 Fy68sxpChGJAjMEAAEKAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCawhqlwAKCRAFzvXHieVa
 dM5uD/9WdG28F+lk2AN/P7FPzNVAlw1m/ZP2Zj1N72s2yAiLbd95/UjhTp6pgYkmF8xYZccXp/I
 njFMb39qzAagJgMko3uHsB6JH89HsDsU5F9d/It5GOeOSEG/aEPE7TqiZYG/F/Uz8MYwPhKWB+Q
 +QcXb6DZIvgjR/Udlv65PPrOmohENlHwGqzv7fX0E7YnDRMjrtHbJS1TEQwBvIJ1BOeuaea7XTs
 QazDG9epd1WUCSRuMJbNqinzdG53vOaPZE5GBLBBhhAABXC7ONoEQTlY+TgaXDb3g8lnyTnLBW9
 upJx4BCU09An7nIAQVBl9bcV8Ng1Ae8QMaCwhpg3JZFBoGBt1/xNMSa5jhK3gwBJyYVzmdInJMn
 FDxQQngMhjTmFc6jdVorfNDtfpI3HcQptiOtAeyx5obZOOfNdWTAHfrZ1M5KZUo+Ixvb5t9iISN
 4TnbhR5rBTT4CSb2YYdkKVysfUM7m4U5T9898JcilapqEmYo8c6A15+yEr1wRXAYhP6anyUPWKP
 VRl5tRkqEgwFoBGaf9wV6QxoGZT+zdIeucVsHKxujM5QRAPDDd3+nRlkYQdf5WwfigxL6pFakyQ
 VrWZjfao6nSKrX9Cb1Yxa6YyhMKAC+efJs9xUHDSG2Atm3MCebhqSiSpCaXq++8cRqR1ouFfBhK
 urX5cDKh9iHEqNw==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

On the Lenovo Yoga Pro 7 14AKP10 (83KG, AMD Krackan), the NVMe drive in
the second M.2 slot is frequently lost after resuming from s2idle:

  pcieport 0000:00:02.1: broken device, retraining non-functional downstream link at 2.5GT/s
  pcieport 0000:00:02.1: retraining failed
  pcieport 0000:00:02.1: Data Link Layer Link Active not set in 100 msec
  nvme nvme1: Disabling device after reset failure: -19

The _ON methods of the two M.2 slots' power resources update a clock
control register shared by both slots without any locking, and sleep in
the middle of the update. Since the root ports are resumed
asynchronously, the two methods can run concurrently, and one of them
can undo the other's change, leaving that slot's reference clock
disabled. Its link then never trains.

The same symptom has been reported on the closely related IdeaPad Pro 5
14AKP10 (83JL) [0], which likely has the same problem and should be
fixed by this as well.

Evaluate power resource _ON methods one at a time using the
acpi_evaluate_object_exclusive() helper. With this, 20/20
s2idle cycles succeeded, versus failure within 1-2 cycles before.
Also tested in normal laptop usage for a few days.

[0]: https://ratatoskr.run/linux-pci/2026/04/6586201/t

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Assisted-by: claude-opus-5-5
Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
On the Lenovo Yoga Pro 7 14AKP10 (83KG, AMD Krackan, BIOS QFCN29WW),
the NVMe drive behind root port 00:02.1 (ACPI GPP3) is lost on nearly
every s2idle resume, while the drive in the other M.2 slot (GP10) always
comes back. Updating to the latest BIOS did not help, and neither did
disabling SSD power management via kernel parameters or recovering the
device from userspace.

The "broken device, retraining non-functional downstream link at
2.5GT/s" / "retraining failed" messages come from the Target Speed quirk
reacting to a link that cannot train at all. The actual cause is a race
between the two slots' power resource _ON methods in firmware, which
can leave one slot's reference clock disabled, as described in the
patch. I can share the relevant AML and debug logs if useful.

Testing: 20/20 s2idle cycles with real S0i3 residency, versus failure
within 1-2 cycles without the patch. I have also done normal daily use
testing outside of synthetic suspend.

The IdeaPad Pro 5 14AKP10 (83JL) appears to have the same problem on
the same root port [0].

As suggested, we now use acpi_evaluate_object_exclusive
unconditionally.

[0]: https://ratatoskr.run/linux-pci/2026/04/6586201/t
---
Changes in v2:
- Switch to using acpi_evaluate_object_exclusive() unconditionally
- Link to v1: https://lore.kernel.org/r/20261124-ssd-fix-v1-1-ee8ef43190b1@beagleboard.org
---
 drivers/acpi/power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 23a4e207a01e..82c8af6f8c7a 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -368,7 +368,7 @@ static int __acpi_power_on(struct acpi_power_resource *resource)
 	struct acpi_power_dependent_device *dep;
 	acpi_status status = AE_OK;
 
-	status = acpi_evaluate_object(handle, "_ON", NULL, NULL);
+	status = acpi_evaluate_object_exclusive(handle, "_ON", NULL, NULL);
 	if (ACPI_FAILURE(status)) {
 		resource->state = ACPI_POWER_RESOURCE_STATE_UNKNOWN;
 		return -ENODEV;

---
base-commit: 988117cc1bb17338c586a4e21ade88b5397eac33
change-id: 20261122-ssd-fix-6b7ab639796d

Best regards,
-- 
Ayush Singh <ayush@beagleboard.org>

