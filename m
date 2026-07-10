Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE143373C1A;
	Fri, 10 Jul 2026 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661473; cv=none; b=pzCCZZhpo6gaNyQx0qcsOJrNfSEZY3KOK2qaSkg++ofDCE1KwfKWXRPYGsfakMt5ZkgXlkD/8lKaZT6/IBy9vQoFwkPfyn0+U48xmRsrX9fDHWOwIXPoABzl2cwW3/6MOWgUrix8CgMAvw+/wFeNiHXlQMIjc33tlK2C0nufMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661473; c=relaxed/simple;
	bh=l64JcjzWCpSBdRWQ5UQ77z22/husDJbhXILYRBfevxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uil7ZyQR+Iu3n1fFi4FeK9gSvz89pPlgTwKmxoz4diYsI+vziob+wu9jlMfJtvsRZcBQqlU0L/8SseQK0flzR6bzjMisrd/OBvXpXdsNAZQRofakxbhNB5Ekdc9ZN8wwjRKsZmRt9kS20eb5MhwAMz2PJqq0St2xC8w+u312w6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M48KARnE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M48KARnE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=n+w8axshVAu6c1a5VUZtVU0qgvR+7v+S6dNFZ+LAmUs=; b=M48KARnE+IQDuByHhqcRsuStTJ
	uaoOZGJqBBTEHSfLhRcgZWNAAWRTrt96ZDkLyuckTlox0YbOs7xPfoDqzxMDK6rFMuynGR66wd00Y
	eXATv3QpStXCvgVzftfwFEFFqb8ekxvAq2907tfVyxMFqdkHhfvcnH9FeV8Wf2p9bAM4C/8zV+L4j
	b5fO2Rvp0UUfS5yZ54WjIcXvbHZbB84x7J+AYoemznsMNPihDDzLeOm4NIYy+sKts/LheijO9jEuC
	IhDo2/tFdDjpKmLDPw7nOpDRFoaezGkEfUjsGgXl4+l57dNPZ60XIFLqotMFKacQOMoeK9Le22c+n
	1mh5f+kg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi3pK-00000004CbL-38e5;
	Fri, 10 Jul 2026 05:31:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"chunzhi.lin" <linchunzhi0@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-acpi@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH] docs: ACPI: DSD: motorcomm: fix docs build error
Date: Thu,  9 Jul 2026 22:31:06 -0700
Message-ID: <20260710053106.730399-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the title with commas (since they are all run togethe in the
produced output) and add a blank line before the descriptive text to
avoid a docs build error:

Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst:70: ERROR: Unexpected indentation. [docutils]

Fixes: 28f431eac1e5 ("docs: acpi: dsd: add Motorcomm yt8xxx PHY properties")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: chunzhi.lin <linchunzhi0@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-acpi@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>

 Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linext-2026-0708.orig/Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst
+++ linext-2026-0708/Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst
@@ -64,9 +64,10 @@ defaults as [motorcomm-yt8xxx]_.
   Enables adjustments related to ``motorcomm,tx-clk-*-inverted`` usage; see
   [motorcomm-yt8xxx]_.
 
-``motorcomm,tx-clk-10-inverted`` (boolean, optional)
-``motorcomm,tx-clk-100-inverted`` (boolean, optional)
+``motorcomm,tx-clk-10-inverted`` (boolean, optional),
+``motorcomm,tx-clk-100-inverted`` (boolean, optional),
 ``motorcomm,tx-clk-1000-inverted`` (boolean, optional)
+
   Per-speed TX clock inversion options; see [motorcomm-yt8xxx]_.
 
 ASL example (illustrative)
