Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63563CAA47
	for <linux-acpi@vger.kernel.org>; Sun, 11 Oct 2026 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697526; cv=none; b=mzLgCQrZ5vGlMs6Qgz1jAYZQ0pFgOjquPNFR8l6H0vN+9/8Nb1h/8KsGfDTtGIzkggZO8bV5kk91jcDaGsRFxhiTXyIqjG50QfcxBVSBp59+xdicH4aJhV0ReniZg1+WdizA7uA/dsL40wr0pKxCHUC2ABwF1cwQLpbxFmXizdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697526; c=relaxed/simple;
	bh=cwdjm+qGqXqoq4C2oRIh5rJbqUVvPrBpnDTCDO+on5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGGf5qYgW18dy+0YhzMDbaBCD5TsVXcvyhCDzENX5gRqLNpVWoI3EN1mNltpV1Ima0SnlNO6RXDpvU6Qw/qoSo2C8+KMAHE+1hduGVPD1RgfB3DlyDAHZNYD+pUsz9qdi+fAXxz0QgWeduoICyz8GKpEO20aBEIT++/CZR/iyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIi8xZeg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIi8xZeg"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1898261a91.1
        for <linux-acpi@vger.kernel.org>; Sat, 10 Oct 2026 22:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791697524; x=1792302324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GYbDo/zUvFvs+Is128rbwFgaN3wZJhNxTKIxQmY6kWQ=;
        b=mIi8xZego4z1b0FYoZ0P7hiKpnuW4PlcsANdRSE2Jz5PGn5zhiLpgquCXOXpfTVlwF
         0qU966pn1E5K5B4qXM0IeeNnBnKrVBwiEc4FUNeFkhhTxBafPPRmJmAOVjh+5Kwj4mMF
         oGIt58W6jkvaP6OCU2DGFxitzYdVOYL7iytYbamHERQ/KEZyS5viWblPwt1t3ThKjN0e
         ZJ8aKB7hoObSxWVWymfNiwaR8criWbrQeHyzT6DBbnMwWstJ/YSaaSXYmf+rE7k6Vn8R
         BB9MXZw6QY1J3sJ5p7X0JRABXDhUSNPkM5OPPsFFfbrS9cM84sPGQ7xIXMqApIxz+gKZ
         I3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791697524; x=1792302324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GYbDo/zUvFvs+Is128rbwFgaN3wZJhNxTKIxQmY6kWQ=;
        b=ukguRuOZnRHpb5ol3ABLrJGX+euA/SrJ7ug1Dukom//4Yb/ZY5eCT6En6q4EsEff8K
         1hPFw8ywwc+v8uV03i+OBzFE5dgPUrr2472GWv3sTS4LDQiH2WfE21M6ZeuoIrRf33Tx
         /Aozs8W76QNIbOxmIVjd4pH+aE/fG29696/tKBrwVmIgaEpu5knxR6GzrHBxGCcTVrnW
         d2J/1K50MNnMzRjDYiljB7v58+EUw5FhNoUtFcA0GJ5LgW1tiGYussKun26GbYUSFD1K
         SL67GXEnYY5SYSQobE2dw8cEweJVLHgPL0wUmc9KYpudttyBY9j51AoKIq/mL2dNw3+s
         Z2Jg==
X-Forwarded-Encrypted: i=1; AKwUvBwkKcktCSs6NUvZqx4fWzgzXryHWGpRxo4e04aUPXGhv2dQhhle+XudCXHUV3HrpFc/mrn4AvmGvPIv@vger.kernel.org
X-Gm-Message-State: AFq9FYIxarQXlM1iAa9PzAwfgONhGMa243hPCjgQxqh99000qXdGVYqN
	w/aqaUdRyisuala7kQYFOfqwD2uvEtiOKy4KVdPxpmYwiS8M5Q1TXJKJ
X-Gm-Gg: AYBFou14QKkoivsvp+LRKDL6+OA3jBCJm2Mfdx6CW6IxEZtcaEXcS/pdGtolwSENcDl
	QzlcI98pLKaHvvoyCHlXywBp7RaF2C9QQkxZubQEbPgpRbt3eGSsWws4JiepRK6a04zZElaDxQ5
	a7Y0IkMFpFFYhSGuQijWhAiwk//w0MLlpCRAd4TjPTnQNhmqqcNAMsHBQxwj3S7zDYuq9F/5lCW
	J/2whTCHc2uRXC6VIdC9D3aNVhZsx4EC8a/GDFDX57js681BcGTl+l338ctY5PA5OBFP1+04S1/
	WTwJCEcE0l3EkCcU5dTjszFM0f17Z7VIRkBw60Rrk2vFLbBUL0q7vD5lDr1Ct2miCFass6M3SoQ
	Cg6eYNIrSAJex2j+Wh5lL3wItPLlIUJOgjM1cwXVm3ehAiwu/+ZUrgBS21nB1PVaVoKwUfNSl/x
	S+f1W/GeJyyMypb9tAB9zpQJapwhUYrFAbGPSeRFzASlBNsIQS9c9offZQFNBGCw==
X-Received: by 2002:a17:90a:5185:b0:3a0:bf71:eccf with SMTP id 98e67ed59e1d1-3ab3a9533ecmr2447914a91.14.1791697524040;
        Sat, 10 Oct 2026 22:45:24 -0700 (PDT)
Received: from DESKTOP-P1UN4LN ([2a09:bac5:d459:263c::3cf:35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab393efd88sm6669981a91.3.2026.10.10.22.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 22:45:23 -0700 (PDT)
From: lofm2605 <lofm2605@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	VU TUNG LAM <lofm2605@gmail.com>
Subject: [PATCH] ACPI: PM: Add unused power resource quirk for THUNDEROBOT 911Pro
Date: Sun, 11 Oct 2026 12:44:55 +0700
Message-ID: <20261011054455.1472-1-lofm2605@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: VU TUNG LAM <lofm2605@gmail.com>

On the THUNDEROBOT 911Pro laptop (board NLCC, BIOS TP127), the NVMe
drive in the CPU-attached M.2 slot (0000:02:00.0, behind root port
00:01.1) and the discrete NVIDIA GPU (0000:01:00.0) are inaccessible
after boot:

  nvme 0000:02:00.0: Unable to change power state from D3cold to D0, device inaccessible
  nvme 0000:02:00.0: error -ENODEV: probe failed
  snd_hda_intel 0000:01:00.1: Unable to change power state from D3cold to D0, device inaccessible

Both devices are enumerated normally and work under Windows. This is
the same symptom as on the THUNDEROBOT ZERO, a sibling Tiger Lake-H +
RTX 3060 model, which was fixed by commit cd7ef20ba8c6 ("ACPI: PM: Add
unused power resource quirk for THUNDEROBOT ZERO"). The SSDT with OEM
Table ID "TglH_Rvp" on this machine defines PXP_ power resources in the
same way, but the existing quirk only matches product names containing
"ZERO".

Add a DMI entry for the 911Pro so that its unused power resources are
left on, as is done for the ZERO.

Fixes: a1224f34d72a ("ACPI: PM: Check states of power resources during initialization")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222118
Assisted-by: LLM
Signed-off-by: LamVU <lofm2605@gmail.com>
---
Not tested: I have not been able to build and boot a kernel with this
change yet. The failure was observed with Ubuntu's 7.0.0-31-generic
kernel, which already contains cd7ef20ba8c6. I can test a patched
kernel and boot with dyndbg="file drivers/acpi/power.c +p" if needed.

 drivers/acpi/power.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -1121,6 +1121,20 @@ static const struct dmi_system_id dmi_leave_unused_power_resources_on[] = {
 		}
 
 	},
+	{
+		/*
+		 * THUNDEROBOT 911Pro (board NLCC): same SSDT bug as the
+		 * THUNDEROBOT ZERO above. Power resource 'PXP' is turned off
+		 * as unused during initialization, which makes the NVMe drive
+		 * in the CPU-attached M.2 slot and the NVIDIA dGPU
+		 * inaccessible.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "THUNDEROBOT"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "911Pro"),
+			DMI_MATCH(DMI_BOARD_NAME, "NLCC"),
+		},
+	},
 	{}
 };
 
