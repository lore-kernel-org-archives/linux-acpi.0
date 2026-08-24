Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822F401A0B
	for <linux-acpi@vger.kernel.org>; Mon, 24 Aug 2026 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570306; cv=none; b=qF90bLfHvH/07kvWxXwALJy36YhB3zUpbFOJ2wj6PCLRxsyImeDNciyKZbXhWDFncCtA3m9nzdLtPiVDpJFMTYktkK1wjjW8eewjjVYBgf4Pd60mJmNUZMcgtU35kFRv8nsA96+vvnKFbIqhCE1zA4GXVbqYyq1bTm43dRfyJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570306; c=relaxed/simple;
	bh=AlZ4vuMUyi2tB5H0lqXUdQkINvZUab9+u/VDyDzWTZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCllulQUtc50Nog0LY3R72yD54zAQlNlnKTAsK+v5+0pMFejSmpz2F/iFofJD7qL359Ax1H4gkKEfIuutJ4hQMSZPIwnOWXlfWtB5DE8lzW2VSS4Yu+kLeGTjWpLApF3urukZKr93mFyV0v7FbOS/iqYI3Fh/mFNwYER/YtmR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojbNSdok; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojbNSdok"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso2140061b3a.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Aug 2026 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787570305; x=1788175105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLWAvy8i3HHUYpxrhO29SLzKq3jWCbJeGE8x7BTijLs=;
        b=ojbNSdokyha4Dez9P/t1DJCXZWUy77FFd1q/Ep0mBKz7iqYd21VV40g4m7GykmQ6WD
         sFIYr0IqCcv7NbQZFjugpYYsJO2zN08ZJTjJ2ex2t9aP8sL1oAKkroGxwbKczlltXzX2
         4C7XmDa/DrpYnps732k4jZTeSxtAdLO30u+v8E7odmZYmprBW+pIBDuCCSLiy2ksiF8o
         Cv37+VBYSAdLOZ6pKt09+oeYgHS/uahUdEjMi2ACoMw+e/CtHIqiWJXRbPykt9pNcHL2
         lQdLwEGjlqbI1851avwmmspeBJ73ihgk90wWc6rJJv6LYsAe2dFrI+GeEDiYBM5n1Ti2
         rR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570305; x=1788175105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PLWAvy8i3HHUYpxrhO29SLzKq3jWCbJeGE8x7BTijLs=;
        b=YnY0Qy9TVB/yPB0Vr+wbuqw4i/bfN5v4XPI7l8cWEyVr/5tFp029ILOYlPyK1I88tZ
         brgN0xOHE8GWMmNl3yBXKs3hj+pUAFAqFFk/6iCQt3z77Y1uQr9M2e2apCuETK2ico9i
         J/zioCae/W0i/mME++IX37E4c6D+Fv8nTDzB9a7/BHyGXJjtLo/Joxu1AdLq+BF6APS3
         dRuObQ4MmiHlhd2BJRU+i0DpP5ZzWYp0PbKYwRIg06bq6oXb0+lE/N2fGoUsFIVgtJA1
         W5o15BzS3Mz3B5DwbKuGcamUa+bBqypqUdLT64xk2Nw5U24oIi+umfrs6pMb06YH+dNW
         4iVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMLS2insyqawRYsYtZrV5D+Y8THdcR2R7MKLyeMMQK6K4yRVaRdUhcCG7NBiJoRiO79Nf8gTs0NcjR@vger.kernel.org
X-Gm-Message-State: AFuF++mcPLV0/8rrfKdRxiOFLmCACiSF2ILLX8yeGEJRTJJN0Cq/HS5h
	Xs9Y3sUcJ3TySWsEzN2F40j9j4J0MH+quH3MgtENgklns7vEUCyuE8pC
X-Gm-Gg: AR+sD13oLwRKy8GlxMw0otUOdRY/fkAECtI/sWXgl71b+ivcp/Zcju4SyNNhCH800nc
	sULY/RAFkhczpaXAVHx/VW9JoYTyPX+2Fe+TwoU9bHcBxbd7iYjcQCKaCiZ6JEJo1qQZHogscBA
	fVifk7oA6r5UFP7YnYXskqAPtBgtax0ZRbqHLPznjKELLBBBnagQo5AtEXnulF1yfTu+GXybMIa
	/3+hY/URuq2oehMUpNCA480MzMCrERm4t5usIrrOPO1/Uf74yocDPjpSG+E6O0jvOch50SbDsmV
	ix5sSVvgnL9qK2tyiiu0cC8/dZRqtA7SZfv5ENF7y1aszTllMF+Q9znI+3cJHOt/bimOXEI9raO
	u/x9cXANUsChfZlcuKfs+iJIsee9L8mHI+NmS69aextv94R3BPu/LNAdeNTiTJMhobULDXQ70JE
	sOmOxjcKsh9B7Zg781aXCoWAb7bXyEVImCkGAUXIoYCa1s9FbcBhppLEis/VGCoA==
X-Received: by 2002:a05:6a00:3a1f:b0:84e:909:ac03 with SMTP id d2e1a72fcca58-851f9a4e57dmr40314129b3a.10.1787570304589;
        Mon, 24 Aug 2026 04:18:24 -0700 (PDT)
Received: from InspironBook ([23.26.139.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e4b2e3sm868201a12.16.2026.08.24.04.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:18:24 -0700 (PDT)
From: YuXin Xiao <xiaoyueyoqwq@gmail.com>
To: andi.shyti@kernel.org,
	westeri@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] i2c: acpi: Add DELL0A86 to i2c_acpi_force_100khz_device_ids
Date: Mon, 24 Aug 2026 19:18:14 +0800
Message-ID: <20260824111814.75242-1-xiaoyueyoqwq@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>
References: <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
13 5310 intermittently exhibits excessive smoothing when the I2C bus
runs at 400 kHz. During an affected period pointer movement becomes
severely sluggish and sticky for tens of seconds.

The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
is already done for other touchpads exhibiting the same excessive
smoothing problem.

With the quirk applied, the kernel reports that the firmware requested
400 kHz and that the bus is forced to 100 kHz. The problem did not recur
during extended heavy use, including an S4 hibernate/resume cycle.

Assisted-by: Codex:ChatGPT-5.6-Sol
Assisted-by: OpenCode:Ox Alpha (x-preview-f-free)

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: YuXin Xiao <xiaoyueyoqwq@gmail.com>
---
Changes in v3:
- Use the contributor's full name as requested by the maintainer.
- Preserve Mika Westerberg's Acked-by; no code changes.

 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd5..3af0e05 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -371,6 +371,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 * the device works without issues on Windows at what is expected to be
 	 * a 400KHz frequency. The root cause of the issue is not known.
 	 */
+	{ "DELL0A86", 0 },
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
-- 
2.53.0
