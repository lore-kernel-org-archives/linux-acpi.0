Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128924677F
	for <linux-acpi@vger.kernel.org>; Sun, 10 May 2026 02:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778381289; cv=none; b=FLbM5SbqXjIzaKEak6D+naT3ABWoX7/J16SbXqTQ5qD1HPfjbVWAVdFGBFQJpAdSXd71S6ShpiGcPp1wIIgDf36w/8yqb2/Qok4uRy6vkWH65NgT79sgT3BwFSNsOJBeWcmOFsNtYkeBZ5IGoh8B3WW1szocawFZIFD0ntOEsds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778381289; c=relaxed/simple;
	bh=SwMdwYGYzzLg3wQCGtdBTdijNHTXebXdySi03PYWB1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJSYjBkhA4dNzlJt76XCO0jtcpqQcuIDk5oHC1RDVj0+R/soSYazTucfuAdICIxfvwxrItmM3oB2+ze5UxrOz/mKJ8aNZMXGmJeYqou2/lldYMtugDcII2cBSnqVt9ON0lnXnrtNlIi3sCE9NR6Ux43xFzrF2jHttJZYsUKLaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lx96hGHC; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx96hGHC"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c8f9846c8so4587223c88.0
        for <linux-acpi@vger.kernel.org>; Sat, 09 May 2026 19:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778381287; x=1778986087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHwU+InujAdAxwaWrE0INLkxm6uhN8qMKbMfy91haL0=;
        b=lx96hGHC6NttDugUA5vNzWiUk+u5762IVMrMwNIiZZtMGGtrHcfshaiIrnbD0oZHWy
         sNOU8wh8ENU0TXbgpzNEx+F8/KAZGy37d9a8guTPxmmBMmsiUHjJ2n324yuy0YpraTZ0
         m8sHFxW8Vw8ndQkDsnjtNo36AYAVVu/UWiDH5iDbcewsHwa+nqYo+RdR+jWvqOEhd8Ll
         AWW07hInpNy57xHNxCuvuWg1asFG6a7ch2aD9j7SnJLUtRC6fA4leHCRr3j8VhQU2JZQ
         j7ll4+pFvwVV2YYLOZ+SjAV5UPIOafKGWmOpuBd3uavttAvL+N/dzarXW6aArLj1GDEm
         CRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778381287; x=1778986087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GHwU+InujAdAxwaWrE0INLkxm6uhN8qMKbMfy91haL0=;
        b=MaLUa+4jX4FqTbpRUsWP9vu1ZEJtjhQbPbvcGAhECdnQXB7haAaX7HlcqrdKJwcJPS
         iw4LUAiFC12zDy93KX7aIThgdt9YwjIZc+DmTAUUdU3vA8TIVROZLRzuHF9A8boE3JCq
         XHJdN6SeEYCCWGWHQDnZyXTzGFb1W+fgGEOh+pQ5wC7ev2p7nSbKEr+H65vsdzhGd/ui
         6i9xWNkc04jCttN/3j4FWOb3hnXAVP5/iwRQszy1xWtHSckq14OFknirxmo+KAiBAbNm
         6SrjiY0Kf89Vf8/Xrjo0DqvIedDYfKGM7Vt6EyWEOCK0UW+WO9uhaI6tT+/H3HIKYDng
         FLkQ==
X-Gm-Message-State: AOJu0YzizZPb8lWKp/j3KSw3SgqBmHFfC8c0pkFi8zevytWYB/jMmL1a
	a5vkBYlCcX2Ulm7sa3+9F/dzJ8TbhelnqSUxGSSDNW5n3k4sCmCqgz8=
X-Gm-Gg: Acq92OH7HOeoHcZ4kTjSq5jsTHRou07T9gPd54BzvRPtIYLC4CmCoAY3xOoDk1LTPPv
	xpFatEv32RzdEeW97e0gGfCsWRnOR+99Z+a9gQCh6DlkP8+YMuvYA3wdT8FYgJe8JxV2ahSHV3u
	wxUGtN+AtgXT8ZvU4OJ2ude6gyCcJOIfXzus0VgAVTNlBe785lFigTCh8JQjOUHJ+A1vkdEEDHe
	c8Utp1AGrXzZpyDTOi7q9/n/9tlKDbP7YGHumj61NA739YkltoYNE9TOq2xz1yVcWeTzF9QXum/
	4z90EedXiMhRc4RNEdI9Z78SlvRf2NYXunaDj1xUiZTMamNucxcxn3YyA/FCIcsgFW0/ZQcLKwC
	wChk5mxs86NyZu+0kTR/cAiwK8UoQGjmmvpGvXdKnS4fbqGUpGFh70+seeU91S3aYQuhiHlq1qd
	qe3jDSOcSjdUDpw/mz70Xz/8ITEVeFzt0=
X-Received: by 2002:a05:7022:6198:b0:132:b202:8547 with SMTP id a92af1059eb24-132b20286a5mr1563614c88.36.1778381286653;
        Sat, 09 May 2026 19:48:06 -0700 (PDT)
Received: from localhost ([2601:647:4100:7b00:6600:cad2:6352:4cfc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8860ce1bfsm8637608eec.9.2026.05.09.19.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 19:48:06 -0700 (PDT)
From: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jeanralph.aviles@gmail.com
Subject: [PATCH 4/4] ACPI: video: Add blank line after declaration
Date: Sat,  9 May 2026 19:47:23 -0700
Message-ID: <6fcebe713899ae5da26a1790c6e9e5d764fc3911.1778378939.git.jeanralph.aviles@gmail.com>
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

WARNING: Missing a blank line after declarations
Signed-off-by: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
---
 drivers/acpi/acpi_video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 4fec8d817812..39a1c25fd840 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1361,6 +1361,7 @@ acpi_video_get_next_level(struct acpi_video_device *device,
 			  u32 level_current, u32 event)
 {
 	int min, max, min_above, max_below, i, l, delta = 255;
+
 	max = max_below = 0;
 	min = min_above = 255;
 	/* Find closest level to level_current */
-- 
2.51.2

