Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6A391E4C
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556315; cv=none; b=RM1hyTZtvKR98VxFDsV25Db//6HG5YrmAXNS5kSMze1bEShZvS2/Ad4eWx9udIIwIsIMpldk3hLaQ1GHdQe5mRrn4uLolSY2+IVL6JvqQfhWYVOGP0nhJBACcPvphkhwuQzhTf/7VHyntG7oXgUj1tF8kmUmesnSzCeTBoXKL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556315; c=relaxed/simple;
	bh=TeSvF09MPdWxY8fc80HEEU4F3Q/QiMcfV6ECA2cUZPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=biXdK0AsSSNWWJum7JtfIINH9ns6vCZAYquyTS0AdJNIYlxRDyzDeW/IXmcXhk0D2GaNb4pLTg+cgUBteeR2eOBgyNcA0KZQvtC0oohhU1T35r9ZIqEPIfJrya/i7Me0hlUvat8eGZ63G+D967Laaptnkj1F+Rh5wmNpO+GpqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw6wbUbC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw6wbUbC"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so988757f8f.0
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774556312; x=1775161112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXs8EltyB8S7jgNI/iWhaXliZDlbstWdNH2DPvSDzNE=;
        b=Vw6wbUbCRlgcbrynBPB0Zxhn4gKFjTdrbbKFd/VbAoC2mzsRmEcB5pMXWfoApud0uo
         7uGtx5gTIhr5ZAadgxRqynw7+3UwMRFVHMckVEi4mu5kdGS+bfZ7iZoYKXoFmSfu7NXr
         anzk7cC43426MG6SyrXYtRxtzUeQh/bS5kzehTteFfnC+JPur7OrOy9HVdUBzEoJ1kMK
         13bN+3TNyYv/82m9uPxZhzcfgGTZGJyJQo6LxUuCiPiDsTRoYT8W6wr+4k24bxw7CaOn
         2qjaPjLy48SxGhPVqtIO3DK2b1SemmmL/3Y7arDR1bDCpmYvm02bFu7bVeI8W1RDBinD
         JHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774556312; x=1775161112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXs8EltyB8S7jgNI/iWhaXliZDlbstWdNH2DPvSDzNE=;
        b=nzKGOQYBtKYapRcWMPti8UQWXrvP/RF9QVr/0gnWaCtT9+AelQd3TNUZn3g2PMO1HE
         sU7nvMFdMCuk6R12dKi5C/KJY4PFjC8hUx81uw/NO/mtlg0G1kLzy/qZZB7HzpnUvufT
         o6gFqO/9b3MRPDl+5iM7aJMBtGSOjx4WDl61AQgmmxBrpZsVKhapYhIpK1wb5lwjvzkz
         JuYXz9iQTCS6QZMsPG9XAGZHqKear04G8Dgof2vbWgTpuP28sgLAyydBm84uKpSoZJZ9
         +26yLS+IrQp6lSouZemhaMfayINWGIlcergxk4S6NdijstYTcBOr/o7Mwp/mkzsIVjzR
         KYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3u4Sz7ackiMeSRFCDpffdiTanShaMg83FCmcDJrZf+EtbcIcVPS4ASMarjaMsCd67fDIxpiH2G2kr@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrxGt8pCy46F4QauTYm16hcrjz6kjVKJvTftK2U55XzMGVXGb
	4vJi0QLQHNj1RNzxW78LPg8qQM90p714MAwBWvsAN2b9+LmyvOTcd2F0
X-Gm-Gg: ATEYQzw6Ko3sN7G5Psp+RZFcT5vNBpJ19pQ7sIL9/Ha1dimyFj5HBit7DBjZnsrxxeJ
	4WzzL92330FD9/LKla4gv2bhXAjovP2VerGhiYWFwK2GHz5aGUHUYF+b0iGTp0WXpio+ytyTD59
	d0e59S9WW495jGpTGOLYYHcDMsw6yMqBVQBjsZTWGJ1R7U4O1/F2qhDjivA3oUBDZCiPH+zNCLm
	/wUtRiqmdSV5+JnX39LqPWzAlg90LkGeYTkj4wt0imoljay9p71C0LPn4vNO9+f3p1w8C1O7Oxp
	PIXsBlddgcaNql8jSBvhCarpdlEYU85o9IRJMRepGHlgkWEr3dw438Amvk+BJe8bvxJqnJPfBlJ
	aXhXoyLhvOO8v1NXdRS2rKaI6xPnkXCmfaoZS2DFA9+mT1dWNamhJxAmAB9t9Lprsd3ncQNdJAr
	Sqg/Y0RkqQbH6it41isPnHwjj3QQC1S2VwrW8Sv3wDrj8ntVuHgmtHi6a7+NmYxG8Va4KItiNOv
	w3bzz1dKL+J
X-Received: by 2002:a5d:5887:0:b0:43b:8e96:d3d2 with SMTP id ffacd0b85a97d-43b97a253f2mr5352021f8f.13.1774556312267;
        Thu, 26 Mar 2026 13:18:32 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e528sm9782359f8f.1.2026.03.26.13.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:18:32 -0700 (PDT)
From: david.laight.linux@gmail.com
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH next] ACPICA: AML Parser: Remove spurious precision from format used to dump parse trees
Date: Thu, 26 Mar 2026 20:18:30 +0000
Message-Id: <20260326201830.3938-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level * 4, " ")
to indent traces.
POSIX requires the empty precision be treated as zero, but the kernel treats
is as 'no precision specified'.
Change to ("%*s", level * 4, "") since there is additional whitespace and no
reason to indent by one space when level is zero.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/acpi/acpica/pswalk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index 2f3ebcd8aebe..b1ec75e277ab 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -49,8 +49,7 @@ void acpi_ps_delete_parse_tree(union acpi_parse_object *subtree_root)
 
 				/* This debug option will print the entire parse tree */
 
-				acpi_os_printf("      %*.s%s %p", (level * 4),
-					       " ",
+				acpi_os_printf("      %*s%s %p", (level * 4), "",
 					       acpi_ps_get_opcode_name(op->
 								       common.
 								       aml_opcode),
-- 
2.39.5

