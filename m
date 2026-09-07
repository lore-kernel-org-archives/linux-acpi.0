Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8949417BCA
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763675; cv=none; b=RWMNSKpRogoKxKGkwoC3VGv8ISf3ykrPouITfgHxqTs7AdhnpiOXUIda6d0AOdvjrO5X/tl+cbdxn8Vc/+k8uqL0YRYP7YYUGxqxa5G22PyuX6ZOWPsUua3HsK/kVeJpWYZZtzjW9QeyHzDy1A9R4QlXmCIuH2am5SnmFYx60Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763675; c=relaxed/simple;
	bh=p91ao2AKO1u40gx02a/XDSpFyO2CsKWUxeRtlMlap68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrfHvGziQ16bHqsPi5htpZz1plpx8Cv/egV4c/VBnGUYoOZ5e9LefsRCCUOtP4KI5DFySMcmiBpptiF231ZD8S5y2ePKkFjTcP6Z/P3BQJiFuMGDu4WysSQksZDWeM9ec/Ruumb4/quCQWLN/AxE1Ax7KTFMyfr3SdBogVmIWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEjHzrbw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEjHzrbw"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso3069659a91.1
        for <linux-acpi@vger.kernel.org>; Sun, 06 Sep 2026 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763672; x=1789368472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIBBvWrmpup+w6AcHGzaJw3qF8lt2RTeR72Ssm270eo=;
        b=kEjHzrbwtRg1hg4bzJm7knqJe2KFnNf1OSbeA8WSAnrjQM2zPStzHl92eMayZ67S2f
         Rh3Qb/Cwmct/oY3uD10q1HnmJ4CIXqOTZqyf4nuPfpS0AL4ozel78IbL0krJo4eFKhGR
         QT5VibDE5/FrGVkkHOgobYfuNQ4R8+vk5F+HNgP8mvDBg880XowBvwtu7uzvGzP188qn
         zNCTOT2hqZSE2Lftix4aIHtVV+WxDT9oI1uKe9T7x54funPrKbh+50+pMZD8SnvUo/i3
         dbCR//vBRDmMpMSaPvaWvkCTWpkaJxCqhJDUqjOOE7c69mjWG1kIqATi6JwhadcZ9OUA
         xMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763672; x=1789368472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIBBvWrmpup+w6AcHGzaJw3qF8lt2RTeR72Ssm270eo=;
        b=JKd90acHJ2cCl3IxhKW7wQdK1FihZ2LalARqIfIxlS4BCD5qTfYjTE7xZSBHcRtYfR
         hDCa/4hwsjayEilEWG/JpwUJptkA0snRJQQi/Lr6Ata+DfRMSL9leDDsyaB1srnBdN3D
         wTVF91Ita2nO+ERsWXBhd6nbC08e/AtAIg3PNZRXWqzErKAMlXxuQm4lUed6kq4aTgYp
         UjOw9H3drvVYHaHt09/nRGvniolKqVA8pmTWXW0B6X6oSfSaBWcZ37c3geazmiSOil6P
         imRR5FDjk1eoMoCQJTpT9PSjhONqumw5qV3nhEqHFlHQ7M7ki+WtYPWzTRN51F4dPyHt
         Dl4A==
X-Forwarded-Encrypted: i=1; AKwUvBwjfTNyFb651WvW4yQdAhhGalWocqQuiP0cJo2JqTitLhDzIch/8BfL/SffcS6RbJf9Q5Nrm2GZUBBA@vger.kernel.org
X-Gm-Message-State: AFuF++kkBj9emuC5KdMjQCccQLWW2ooVCedwmNAxWwZ45Z23mCsdTNcN
	1/3MOK2qd9XoOxP1/pn0mXr7tvC49/aiHyvxLcprsirpqZdnw09mvPnU
X-Gm-Gg: AYBFou3J8Rc1yW/Lm/fbilfUQfoUqi6uFZ5fBgKF22+RdRwE7tnmooHCUgZJGkdXboK
	abAHiltOuioGsI4A+vpJLFQtJVhxMPVjix7lx5SyQsqMRUfI/8/1VLQElSVFJH4DNXYgpyth/DQ
	R7v7ZIr0mdwZKr9xCpcq+nercICR2mnj6HDzENzH89PwE+nJtfe3YTjvME/fkFuHRhuYttfHLCu
	vsrp8F+OGM+F8UCYyYQ+kY7pEGhAxXZBJA8Xcob/42sCYSyWiXFztZ5uuJkU5VzKLK0iUETxvgX
	gZwV6znG1nhiST3F1a7BJzqMBxUyz0FT4SHdTrdm6stc9herA23hkjYDi2uNGKg8t6qC5KbbnrQ
	CyZxlU2OufEc+adsZCzhrED97x8YIUl5mPIPmelTaQWMO7SqDsrHdebLU1OUXHe9NqN+WgL38Ic
	9Gxdi7lW5UKp33N6FkI2mnuijCGxRSKDpHG8XdGrxZa9t01PaQhlglS2Xp2qfp/+p1RHpcffhdH
	1oQk26wMQBI3Q==
X-Received: by 2002:a17:90a:d2c6:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-39b260d2f07mr32517136a91.3.1788763672025;
        Sun, 06 Sep 2026 23:47:52 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:47:51 -0700 (PDT)
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
Subject: [PATCH 3/5] tools/thermal: fix typo "binded" in comments
Date: Mon,  7 Sep 2026 12:17:23 +0530
Message-ID: <20260907064725.10686-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064725.10686-1-hemanth.selam@gmail.com>
References: <20260907064725.10686-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "binded" to "bound", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/thermal/tmon/sysfs.c | 2 +-
 tools/thermal/tmon/tmon.h  | 2 +-
 tools/thermal/tmon/tui.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/thermal/tmon/sysfs.c b/tools/thermal/tmon/sysfs.c
index cb1108bc9249..5d64aff12a86 100644
--- a/tools/thermal/tmon/sysfs.c
+++ b/tools/thermal/tmon/sysfs.c
@@ -225,7 +225,7 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
 				cdev_name, cdev_name_linked, cdev_id);
 			tzi->cdev_binding |= (1 << cdev_id);
 
-			/* find the trip point in which the cdev is binded to
+			/* find the trip point in which the cdev is bound to
 			 * in this tzone
 			 */
 			snprintf(cdev_trip_name, sizeof(cdev_trip_name) - 1,
diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index 44d16d778f04..f347efb47c96 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -77,7 +77,7 @@ struct tz_info {
 	char type[256]; /* e.g. acpitz */
 	int instance;
 	int passive; /* active zone has passive node to force passive mode */
-	int nr_cdev; /* number of cooling device binded */
+	int nr_cdev; /* number of cooling device bound */
 	int nr_trip_pts;
 	struct trip_point tp[MAX_NR_TRIP];
 	unsigned long cdev_binding; /* bitmap for attached cdevs */
diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 7f5dd2b87f15..b982c1d77402 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -238,7 +238,7 @@ void show_cooling_device(void)
 				unsigned long trip_binding =
 					ptdata.tzi[i].trip_binding[cdev_inst];
 				int k = 0; /* per zone trip point id that
-					    * binded to this cdev, one to
+					    * bound to this cdev, one to
 					    * many possible based on the
 					    * binding bitmask.
 					    */
-- 
2.48.1

