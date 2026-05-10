Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F925C6EE
	for <linux-acpi@vger.kernel.org>; Sun, 10 May 2026 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778381286; cv=none; b=HfWmQmNczmgV5ucagHPRGH4hHV1XS1kjwPTCUY+5BP3h2IItwdgwtY3G7zUIK5DJw4sEgTS+PJK+iqJXQGPdKZ3kZy5sfMXB+BzndX+kCWziZqUAgUvP+kBK1UXYjbJBTwjqL2YP9vg/pEMN2y294nI73qXNMrR4IXunEd/0WYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778381286; c=relaxed/simple;
	bh=GoFYAaMtHvLlEsfsFX5PJG2Zg77kqmXfd07actdCHZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4o66Rpp0xY+SjvHSKU7NdnLT7g1xm5jHeoXdxIBq/ZR7zVvpPdA7IS0utcpNm5Yzt8m1OCkwZ8daqqgsrqYb+6Ahwq45UsSnERkDCDlACF94ny/C6rbr31uKFCWavi9A5FEph0q+4PDJdV2XEZgeUQyL42K3eAPDyen8sTeREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuRJGQNQ; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuRJGQNQ"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so8596651eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 09 May 2026 19:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778381284; x=1778986084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wddp9izba74cg8kWqr30UEAeVrqo/q3461Ty7Wmjkkc=;
        b=DuRJGQNQPmZ/qlTID60px/v3N/ROBSzR9s27G/lxuIz+zeAB4yFwCZLLQDTJiYETLM
         DQbOjTpEEKhzTW1EXprSxDwS3O2O0q5oASCgq+ZRLxL9nJdzFQ2YBlqPAqenmmpbVfGp
         81tqbTJnOOu3a/0NQs4ij9FRMi/kKgTG4bF7elKAgoG10QLPPAzsD353hoBzz9rfG/8I
         FA3jaGS3cOIgR49LMcL0m8CiVF1xr+16Me3rjG8GRzC0N0I4QoVRBMEnG5s77X2NyQF5
         QDKUsh4v0b17poHKeVUZqpqTWhUnGdhjYCu7KgscF4jVc8DqBaX3R19IbdG1qaOWOMT/
         29kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778381284; x=1778986084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wddp9izba74cg8kWqr30UEAeVrqo/q3461Ty7Wmjkkc=;
        b=eU0lM5wL6lgSJL92eLIgHsb0zkBuu71fHipXdW0f218++6Ay6ydeka7WT1FFcXAc1c
         VwDmoBGSwf51rvEUzMUyyF/EE9HNk7Gaaeclw8i/hMmlbM3vhohZCpzggAEj9Nq3lhrW
         ERHW/DO0+Ojtll5Qy/iB9gfPZhKDAEcmig7W1CNvaonAd4tIWCkxtIaaP0aG2i5JmBDr
         AJKejwIKFi1cT4ooP7Oh9Q3vByQL6Cwr5gE0umTxprUq3NhXkpR1hUQgvfBahgtnqIgR
         9sO4X6GpT3Tl9lonVtIYF1jybv8iogKYbU285VdcDmRtCj3sqPOqruDO3asU+mKzHofT
         a1Rw==
X-Gm-Message-State: AOJu0YwKQVmfnUccpCv4BXNC2DseJQTNuFkZM/WlPrnqb6IPDQKnei0w
	sxXsZjwOyRPzf1THSD12T9urCbDAb9EaT4RB6/gv/8Q2pbl1xDhu6Q4=
X-Gm-Gg: Acq92OGLt83IxtxI1SLY6ZEkmQ8RDitqD1Re3Zbe0ddUjR7GZfKSGzIrecQR6bIgeBW
	C23u9TPS0Pp1psH4JeTopbqoGVNXHMVDxREC/PSYTRm49IriIBEbJ0OLiesnz8FQLPtD7llkN1I
	PaY/tSQ4fm6gJRjCm+VrtWRE4P9fEjXZqJBIyqO9eQe2VrrsqH1NmeOW8R4/pzoHq5UEmoyKJR8
	QCNVhPev53Zcg6Y1EZdSYwOyNe6Zc/Uxj4trkUMpmDpM7ytnE/AMTVtdUP2yE06ifVcei86WDWJ
	smvG61IcyLzKJlNl8UeKudL6UBDeIUzYmeLIm5+6vbldqWiUy0o26sHGgLL0LTMP0Uk7vo4D04T
	wYbCis+Gu+ighYMvApFJVprUM1Bxv1RNQwEo7bH9B8ChjWCjG/Cr4oV0cBG1BSAyxNUrKQa8mSq
	cFFb/6fzuLsBwQ4Gwne+QMWV3b4HIC2L9mmjf8U6K3Pg==
X-Received: by 2002:a05:7301:9f03:b0:2ed:e12:3770 with SMTP id 5a478bee46e88-2f54d98e394mr9443708eec.32.1778381283968;
        Sat, 09 May 2026 19:48:03 -0700 (PDT)
Received: from localhost ([2601:647:4100:7b00:6600:cad2:6352:4cfc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e3e285sm9954103eec.27.2026.05.09.19.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 19:48:03 -0700 (PDT)
From: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jeanralph.aviles@gmail.com
Subject: [PATCH 2/4] ACPI: video: Fix block comment warnings
Date: Sat,  9 May 2026 19:47:21 -0700
Message-ID: <0b5e0ba41a994f107afcfb95c3aa3764c3a4bf2f.1778378939.git.jeanralph.aviles@gmail.com>
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

WARNING: Block comments use a trailing */ on a separate line
Signed-off-by: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
---
 drivers/acpi/acpi_video.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index e8880a2113cb..fc45f0ecf7cf 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -126,8 +126,7 @@ struct acpi_video_device_attrib {
 	u32 display_type:4;	/* Describe the specific type in use */
 	u32 vendor_specific:4;	/* Chipset Vendor Specific */
 	u32 bios_can_detect:1;	/* BIOS can detect the device */
-	u32 depend_on_vga:1;	/* Non-VGA output device whose power is related to
-				   the VGA device. */
+	u32 depend_on_vga:1;	/* Non-VGA output device whose power is related to the VGA device */
 	u32 pipe_id:3;		/* For VGA multiple-head devices. */
 	u32 reserved:10;	/* Must be 0 */
 
@@ -1536,13 +1535,11 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 	input = video->input;
 
 	switch (event) {
-	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
-					 * most likely via hotkey. */
+	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch, most likely via hotkey. */
 		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
-	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
-					 * connector. */
+	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video connector. */
 		acpi_video_device_enumerate(video);
 		acpi_video_device_rebind(video);
 		keycode = KEY_SWITCHVIDEOMODE;
-- 
2.51.2

