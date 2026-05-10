Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243EF256C6C
	for <linux-acpi@vger.kernel.org>; Sun, 10 May 2026 02:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778381288; cv=none; b=LPq134GLWhLiAYy19n9CvgJlKwOMQHYMlZXV8sG4CXrj2ViseqUECzYeVLjkhCgQN/f6jRMxrTlvpnTtL+zUqdTTgiL+ENKUdk7CoyPQchfpJOGQG2E/L5c297RBX2cUaiBObvF7mdhXyPaPxQv4xsacrDf/nPwrJz5znKeSXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778381288; c=relaxed/simple;
	bh=H93vS1Bl3RQWQI8icELFhQo19am9PzIsnbEQUSzr/dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAiLQzm2QJ1sDEXdY8lM4Fu7vPl1MPI9FutcbkustdVpEkyIBS4u8WwNfYSQW1qrgJ9HR5oOBAbmeI2Nc+vHJQP27t/8iwg3D+FSB2pa/STSo+9VfsC7ej21Y6gfS4fBOPzZgHWptH5B8kSrUHZKnAvNR3XL9n5x3LMQ0tsxWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDbzQa5Q; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDbzQa5Q"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-132c338a537so306790c88.0
        for <linux-acpi@vger.kernel.org>; Sat, 09 May 2026 19:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778381285; x=1778986085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ5uIbASHp6bd9IXkDCffqNwnNKdW9lsre8l5tliLbw=;
        b=UDbzQa5QOxISotkUOqiAZx0idyXIUoajwEqpeY2nIa3kAffXItQKnXiO4zgYZVuqUt
         o9cCcYDS9WQge4cyGKxijTlvzVd8yOUgZdOO2wmvmTuIBBo1IQ+4FbTMa6QmlL8abdoG
         Aa2LpNztD7FQvi4yr1b+hpVCEQc1qYFAfoLiTAm1yaEwNqRY2c88hpl87hQvRv3k+lfK
         jSHLx187KrANuWFu3zYs5w4zWATgBFPMKOlwVG+u2/T+o/LOcPgBxLuKJID+/jviID/F
         uy7KC1Yg9bd9sRAgCaaliO+7tyzbD/fpke84uoVTVmTxXtdCAs/OeF3MSgkcg1VUVMei
         3xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778381285; x=1778986085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJ5uIbASHp6bd9IXkDCffqNwnNKdW9lsre8l5tliLbw=;
        b=Wzs7ph9+zAIZn3gEsAljZB2pMDlycfEIJb8OCgSsMANM2eYZTqc/vQFtkUbcgUbQWq
         LPMwqAjSbuYnncquzwgzaq+v/xBAEMTdnm5a89YGjifA1ytmTN1Q9zC2YXNO0G+uIMKw
         88XuCyvcqktEAH2HkUEHRx1ToDn+Py45GxQDmZkrBevRxVBhGqgOb+T7bRA74ciccyvZ
         hCBmsavF/PEkmrNk4IG3mu8V2tFgt/CUDh8hNQjGq06RmSeMkllbrjM88QMPgXtBbpEw
         k7Ru3WoD+UcSlu4cdt4IPSnKSDEYZ5dpgcWta+XzLDRSLzG8WYBYagukiEbRelp0S3ap
         5Qdg==
X-Gm-Message-State: AOJu0YwTQA1cc3JH2Xy6HzDTdIY6k/xi1sbYS2PqpybxxLTAZiS7tXDO
	xm0g9B0ZfYdA2oZQuUKntdv47PwGEv9PAX0MuLAu5EJKR4JlUrJf5MpOWd4mm+E=
X-Gm-Gg: Acq92OHu7Yzcns/ClgWZ20tXXj6SlkMldQF/L39cKLxWJvbvvFGdYbCiWG/WqGwsv7E
	rhwkjPMka9wbUmQVZze2dUOjhh+g08z6mMuSDOsza/iJhSSrFy7DsGyJjfVbumr52kdzm7zTWZR
	YVaEmMdnI51/zfZoxat84/SAHVo0sFjNnCznvNNY7Asv0C2VXUAYGoVve46CPLcUGGDR7W7/At3
	brZoRcrJWK7jXsKINpEhkgIOBNDGK5wU9pRFdMnFjv5o/t9MZdCC/Kg/PK/hs0KFXULHz294Fyu
	ycngItnJWOAo5I+9ITJaWAy9engsUMCdhHC27/PiobiP7I4DUUvkpIktLNRApjVBlugrpchVDzG
	c+NBZLBXj6LJRePk5BDyks+dy6C0Af5r4xVN5g8GThXpzdQi1knq58IVVRdrBFLGUhtwuveOcQJ
	VOpN8PO4hO+P4YGIeMvGRM2H3YLnD2iyA=
X-Received: by 2002:a05:7022:2215:b0:12c:839:7462 with SMTP id a92af1059eb24-1323ae990bemr5234567c88.12.1778381285296;
        Sat, 09 May 2026 19:48:05 -0700 (PDT)
Received: from localhost ([2601:647:4100:7b00:6600:cad2:6352:4cfc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327810ffb9sm12016011c88.2.2026.05.09.19.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 19:48:05 -0700 (PDT)
From: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jeanralph.aviles@gmail.com
Subject: [PATCH 3/4] ACPI: video: Fix quoted strings split across lines
Date: Sat,  9 May 2026 19:47:22 -0700
Message-ID: <67de3fc0f7d7f19ffff8d4bf3b63a6b1b600c9ca.1778378939.git.jeanralph.aviles@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1778378939.git.jeanralph.aviles@gmail.com>
References: <cover.1778378939.git.jeanralph.aviles@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by checkpatch:

WARNING: quoted string split across lines
Signed-off-by: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
---
 drivers/acpi/acpi_video.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index fc45f0ecf7cf..4fec8d817812 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -56,8 +56,7 @@ MODULE_PARM_DESC(report_key_events,
 static int hw_changes_brightness = -1;
 module_param(hw_changes_brightness, int, 0644);
 MODULE_PARM_DESC(hw_changes_brightness,
-	"Set this to 1 on buggy hw which changes the brightness itself when "
-	"a hotkey is pressed: -1: auto, 0: normal 1: hw-changes-brightness");
+	"Set this to 1 on buggy hw which changes the brightness itself when a hotkey is pressed: -1: auto, 0: normal 1: hw-changes-brightness");
 
 /*
  * Whether the struct acpi_video_device_attrib::device_id_scheme bit should be
@@ -1987,10 +1986,7 @@ static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
 
 	if (!allow_duplicates && acpi_video_bus_dev_is_duplicate(&aux_dev->dev)) {
 		pr_info(FW_BUG
-			"Duplicate ACPI video bus devices for the"
-			" same VGA controller, please try module "
-			"parameter \"video.allow_duplicates=1\""
-			"if the current driver doesn't work.\n");
+			"Duplicate ACPI video bus devices for the same VGA controller, please try module parameter \"video.allow_duplicates=1\" if the current driver doesn't work.\n");
 		return -ENODEV;
 	}
 
-- 
2.51.2

