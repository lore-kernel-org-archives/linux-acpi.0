Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A73B347C6
	for <linux-acpi@vger.kernel.org>; Sun, 10 May 2026 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778381283; cv=none; b=X9ro+XD4jVqF2wz/8IbBQs19e2JYajS7g3dg10/UewCnQtvBwYImnHOuZyIiARxOkwY9LLqCNsKS17blFmS7rxR1FPKyKEnWsBeCVIGb1jIDJvOiK+rm0w3G1UhezPy8aOx33TO14VJQWfM4+oPtzNjU2IPSK131KJZkmpoQivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778381283; c=relaxed/simple;
	bh=VWJHN1Mjf6K5XSlg/tgzuSl4dL3R9RZmDD5lsV4E0Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czV1AxW6kHUa1aD8J1ydchIMCCJLckdX7z04o3ESHsxc9INoXnPm/Ik/Xr7YOxQUpQ930cDhrm/Te5kxTV11C9nLV6uA1WX+C8XYwQTOfkhmU8pbq/Ax56FZfak9Q7z/ahmbDMAWTXTYcfXCwAbsL/fvuzwndlwHVOeocH8m6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyJRUYYV; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyJRUYYV"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-130b2295ed0so9383499c88.0
        for <linux-acpi@vger.kernel.org>; Sat, 09 May 2026 19:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778381282; x=1778986082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qrIa5sfJ1TWksqDULKRTmg4srec0S9zCOe/jFN0di4=;
        b=MyJRUYYVPaDSXYT4V7B+VsGHRtG540k8mC7xCV95jxhLoC623iHuH6+zV9spLD1Al1
         Jjp/OKMNQUFKZF1eNxtaMwDDZaoPd0nonpx2aYvsJzz3oq3fsr8N37+mI7dTWHyd+WYe
         ZpEpJ3gPJ6fhxcMk8mZzev2cvRdZAJZlx/ScrUpccdsSjTLjXWB22gjuMUv5w2/BBx26
         cqrLPsaoIEe25j63C9QJunDEMVoJ1p1c31NlLCjG2FvZMTCNQO6/mjfYy0wBkHJudnDc
         hsqdqXxM8q2/LDL/eXb5DVBvqL/OIwabauWtywraJLvYG3Ctni1W3iFRRF8HNzwmCuLC
         Sn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778381282; x=1778986082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qrIa5sfJ1TWksqDULKRTmg4srec0S9zCOe/jFN0di4=;
        b=l4+tF6l1vDnu9skMaRzpFdHOZYUsHx6imMqbXtlJFwQejp8gR0TOJN72vNXI2sk4lv
         GNztI1d/ubs7PDl2IY93pkTXcfAduugaMG6o4unOf6ZZqqgnF93LKa8/X5rgAoQGmX0O
         CzNkdKU4HIgl0hKv7VNw3DL+5ydCml55N/X9wQl8+yGQej8I/C83hi1XGnnNaPnYCAn4
         vDn0ZJrKkriIoNNjSFvGqT4INZAmayGvGv5cEHtChOd70bz3aX8T56pgndhwRIf7ezPt
         C/qXlv/08QutzhmmFu5TaR3QbrL/ErGMOjrg1kcUor4WPr66xnQVo13BRVZXsAG/vx0i
         sWAQ==
X-Gm-Message-State: AOJu0YzHQtUhztLe0etaTfDFiACH3JhdEtQvDYiL/05JP99BBZTwRrIZ
	NkMfPnzOQVsHj0KH9+vXmlYx8cE6pS3W9uHXmooKvASNMrNil0vLMrCA9ONKvFc3RA==
X-Gm-Gg: Acq92OGATgZmF6oCFyXRlrtICgBPIZGV9o1hefObzy0ORP+jGBBe1RLgxf5VMq0IW/i
	6vyzxLRKGkc7Lynzo/b2OOSXUbEKiEmLVnrcfdOa8+M7e9kHoLfkegjqfsLLTgOelI04WS+1ojX
	kCi+FoCfKKMm5la5/v8u0Hib5WMbadnzb+K92+L1jwPkCbIxtaWNoNrdeF0G6HyXH7Z6r9RZFV7
	DJdNLtDSySaSkN5dulanaO29Fr2wO+fFqnxYQGbMaaRKacZuAA55dppKXpPTiV8BMTsNhLq8yVO
	oT343KwHu5sluwsFAvLYPNRmBhXVTKqQ8tbp/S//yPu8TZdARQDWH1JXfFZTSC5mDWrNGU4paTE
	V0ZJMDXDW16+HOo8qjmvGe0kOy2k2VfaYt1iOuOQ+rm7EEUxXzictNGdMuHY5EqF86mxbgQrzZB
	rkf6soMdXWMtcrTvl4K6VMleORBcCbMAg=
X-Received: by 2002:a05:7022:698f:b0:12d:de3e:cc01 with SMTP id a92af1059eb24-1318ec56c70mr10156586c88.40.1778381281579;
        Sat, 09 May 2026 19:48:01 -0700 (PDT)
Received: from localhost ([2601:647:4100:7b00:6600:cad2:6352:4cfc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132781103e7sm10618702c88.1.2026.05.09.19.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 19:48:01 -0700 (PDT)
From: Jean-Ralph Aviles <jeanralph.aviles@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jeanralph.aviles@gmail.com
Subject: [PATCH 0/4] ACPI: video: checkpatch cleanups
Date: Sat,  9 May 2026 19:47:19 -0700
Message-ID: <cover.1778378939.git.jeanralph.aviles@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix numerous checkpatch errors in acpi/acpi_video.c.

Note: First kernel submission. I'm not sure if a 4 patch series is
appropriate, but this is how I would approach it.

Jean-Ralph Aviles (4):
  ACPI: video: Do not initialise device_id_scheme
  ACPI: video: Fix block comment warnings
  ACPI: video: Fix quoted strings split across lines
  ACPI: video: Add blank line after declaration

 drivers/acpi/acpi_video.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

-- 
2.51.2

