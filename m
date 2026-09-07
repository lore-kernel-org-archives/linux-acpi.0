Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229B401A08
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763657; cv=none; b=jr/JpZwEXTWvCfrShdj4BjVsx8EQWyYmjy8w0t6H0sOQ2LuQNZMw7j4zIbeQusztBnwDHvRz+XLfWql6ab2DU7KT2NQB2BSQlSiIrBtiVVDG4AwzhJiNVQldmT+WG/uUicazGvk9TWLuuoZ2IIFWK25I1xKAVfQ/rjHgulkdLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763657; c=relaxed/simple;
	bh=GnJq7OFzqU3yVwU33wEMiUZavL/p2fo6PlQ7aO7+lBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CotYiWDsPGqkSmjk3oIYo6KaV0qMJTuCqBtSWKtQxZysSzSEGmMP2xj6d1Bf76cUex/6NcwZkeqQscGDvh85dwiX5UDkRvUCL1tRkYs+LguweYTvNF9TdB/B3WdBDUGMUNxkBCv4xQCKdBBrMZwkX3sC3sXXE1AlTj1YOFEkqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqdNj6mA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqdNj6mA"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8520161fdb9so3458789b3a.3
        for <linux-acpi@vger.kernel.org>; Sun, 06 Sep 2026 23:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763654; x=1789368454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Obcaema8mLbnmFBhxTp3oD6l+HUHR5TP+xdhdYT8HdM=;
        b=LqdNj6mAG8Y84uQYvBnKDUikdqqKwKfye91GgaRY08V2BE1CFKrBx3UhExnEnR5kEw
         NEj8/TZx2O3vzs8j1PzlLuGnIVJ9GsFWGJeLwrvhXCzLT269cqSbkmcU2g9H+c3XJaWi
         qK7SUm0ZFLlaY6iSoduwg9KnXxAxgBByNqH5KD309I5mY/Psy2JOUN0xP4NVP9XKvFHk
         XdWE7JpFVgPVF9guyYIcvoMRLx3HhUMFgamrh9Uwe5/wW5Y4ZXEyX9/Xt4UPIFir5M5p
         zECg6E+LIB/s60BiEMw5PbGLHMe+fETUpAJifEjtEDTsL134xBCXxxFSdKptmlgr7URF
         zbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763654; x=1789368454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Obcaema8mLbnmFBhxTp3oD6l+HUHR5TP+xdhdYT8HdM=;
        b=ZXOgUIPHeGW2dwR+mOhmjthZmp/py8f5zD1bZuL4814gDj5NJy41rtk/UJVgZjIN8A
         DDQMPgS5hmIlMDT0B5T9ULbmNW3MChIzbKIUubL7gFs6uztiyMHeLBO88ijGLDr2ZqvX
         Ckjs+od72JZrqGqbwoPyy1edHwcSZ5Mo7L8qT79AjzZox3ZL4CMNdifeQPpe9hKlJK3B
         WxUCgfe5wVU8fO+WMLvzljyLmIZWY+XNWm4mAvoOdUZN800dPYj+4m7HV7eXyI8z06eI
         P+n2glt97yg1yv0QHBc/8X8YhXSdZ96f31j2J0QgGUTxiJDEv9bBG6L8xT2ZOCncQUT5
         i00A==
X-Forwarded-Encrypted: i=1; AKwUvBySQewi0fVdnoLW0Zl/SyrfE9EzEJnvhLvI4DP9HLNCTs2n9Is8siZbb2HNRGYCFDnMNyjTjyMgF5+i@vger.kernel.org
X-Gm-Message-State: AFuF++kX7a3Bx/J4OI1qWOoPZir5zyWOEG7kdBa/dMUvsv1O3NlFGxbh
	uWCJ2CEz8LCxqH9bOhlgH2GHee1QkV7PnkPMZdqENj8o+UYTgs1Pl3sb
X-Gm-Gg: AYBFou1lZpSbAkUT+eiUWIfg71S16d/8gM7Us7mVou+of1IliY2ggAqZW08wwG/Ce3E
	wi/Fy7yHkOLPY3FifedQfsyulHF7efSZ6Gls07E1fC6SNmDngZM5hQczTRAWU1XNqEvmQ5Q1hts
	iJYnbQv99YejIgzvdkFygxkpe/foPkNWHDaF8Q+Eerg/xxtmsCshGt5Vn706hBPoOb151ujuf6C
	jDjjhbj5CUWvOMM+7QffNHKMmQCRDlevt5tPPW9ojqjL9djh0lqlHuwy81V3HGOVstGQJ61d1Mp
	ZmFUGYs92G85JN7mDR1r9yVqwLte8iq90dxoLBJk1AN0By73uFza+ZvUAc6lAzG/jzvf122opee
	X4wVTo6H5TTvlriAiMDtASzPHn0vIQJzlUwMhv//GypJ9DeZ283dhVyRFc6loF1A8bVTPPI9/xT
	IhYgY/HOYEIA0HkprsHkrIEAMGH2aypGzKOR8k1h9aH1eD0xKV+9eoKyChwYdug+TAg6rqYnZqB
	pDWYu5sEAwz1A==
X-Received: by 2002:a05:6a20:244a:b0:3da:1fc0:fb07 with SMTP id adf61e73a8af0-3da39d18791mr30838754637.6.1788763654025;
        Sun, 06 Sep 2026 23:47:34 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:47:33 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 0/5] driver core: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 12:17:20 +0530
Message-ID: <20260907064725.10686-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corrects 5 misspellings and repeated words in comments.  Each is a
separate patch so that any one of them can be dropped without touching
the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

Hemanth Selam (5):
  driver core: fix typo "sucessfully" in comment
  thermal: fix typos in comments
  tools/thermal: fix typo "binded" in comments
  cpuidle: fix repeated word 'that' in comment
  ACPI: NUMA: fix typo in log message

 drivers/acpi/numa/srat.c                    |  2 +-
 drivers/base/power/clock_ops.c              |  2 +-
 drivers/cpuidle/cpuidle-tegra.c             |  2 +-
 drivers/thermal/thermal_core.c              |  2 +-
 drivers/thermal/thermal_of.c                |  4 ++--
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 12 ++++++------
 include/uapi/linux/thermal.h                |  8 ++++----
 tools/thermal/tmon/sysfs.c                  |  2 +-
 tools/thermal/tmon/tmon.h                   |  2 +-
 tools/thermal/tmon/tui.c                    |  2 +-
 10 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.48.1

