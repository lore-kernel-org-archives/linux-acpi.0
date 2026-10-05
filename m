Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F84BD365
	for <linux-acpi@vger.kernel.org>; Mon,  5 Oct 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214652; cv=none; b=JmZt6et8j+n6Y45oS7TV8TKB+4ECI99wW9Ci1y89wYX6AAhHFGlQe1OJBgglNB/vKM0jCxFYAYfc8kstR/yNMaCTMildg9rzOoLl0yrYllJQzjH041QMNDJPT9vQ4xhgedDXFBKj8BxdqrZdVwO5vLEDxywUDXTbvSn4vxX5IHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214652; c=relaxed/simple;
	bh=bDlB6kOKtLXIGeumaAwwjZulO8maw2MLX2GjrFszKSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rplYXUeIDKeafWj5jm2HCCb/V9fN1ySnyRCaaf1en6YO6t8FDAtZaxXa0pHBhsSm3yTknfX9AjYJBrDOeMKEr7S00gdB6HwQWJpbpRZc0mf4E76qBYMbUe6h4BukSrgjkOikZP8Utq7KOD8TzAezEa5odcwgiCouhg5HEgFEPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kve9ve6I; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kve9ve6I"
X-Envelope-To: linux-acpi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bDlB6kOKtLXIGeumaAwwjZulO8maw2MLX2GjrFszKSw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791214648; v=1; x=1791819448;
 b=Kve9ve6IPa5E2gUaNjgSt7x9Fnle3o4nUGCrcaGVNM9H96KvcWA+cH/JNJ6Mn7X2tOaOGuhH
 CMJ+fXnQWbl+aC91mfE6ZatY+WHgu3d4PAT+pGQCb2WUedIcemno5ZGY7ztgZd6DWXhpyWvQD53
 y7Miic2v7mHzCFjjvMk1zBuo=
X-Envelope-To: linux-acpi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b363de8b825e4f9b;
	Mon, 05 Oct 2026 15:37:28 +0000
X-Mizu-Trace-ID: b363de8b825e4f9b
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH 0/2] ACPI: tools: Fix stale headers in incremental builds
Date: Mon,  5 Oct 2026 16:37:21 +0100
Message-Id: <20261005153723.2644331-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

Two fixes for incremental builds of the ACPI tools, which compile
against old headers after a header changes. The first replaces the
copy of include/acpi with a link, so the tools see the current headers.
The second adds dependency files, so objects that include a changed
header are rebuilt.

I found these while fixing the same kind of bug in the KVM selftests'
sysreg header [1].

Based on Linux 7.3-rc5 (72d3fcf802c45).

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260922071945.693714-1-fuad.tabba@linux.dev/

Fuad Tabba (2):
  ACPI: tools: Link include/acpi instead of copying it
  ACPI: tools: Rebuild objects when a header they include changes

 tools/power/acpi/Makefile.rules | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.39.5

