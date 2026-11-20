Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195328;
	b=VHEOEDa3gBT4gllif0gLNUx39KpI1EvBrXt9U4eGp+SI/xeHiIUWPzMxjilT8ppXxxbz
	 C5XMK3mVC4kAv0QSYML2mqIUne9fk3bOXI0GKs5mqY6P2nQTYT/Dh8G35Eex6TCKw0SfJ
	 eXLdCLqazSIFxR/xNg7NDSaJhEavUBAHFoxPbXIJMzZtKJ1IU0gUwbGOA9xmyyOAN1nuj
	 4GZdFbgqOHjTEpKIJ/3XxUhWJkgW4Rrs+MaTMBgUXRupsJT+Cm+Eh7RnNtBX34oehUT7Y
	 R7asTA4G9SyfAJdAXeRQ7a+E4uLX1DfmjUxHd6Vt9Vva9gH6R7k8/d5K+LNj/5i90Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195328;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FxF0gWJg1/mc3UmsBUpHKNHcirNZbLQT4wHXPvy0m1Q=;
	b=cGeKj++YBHGHZR7AKF6c8hjuvh1KqHiy6/pHgEWp8gwV55UI7sH7xqZWzLrIrnXvgtdt
	 FXfOd1STkzrCBDPkK9kHzkUtlmtVyDk2N0Mko693bJ3B/BZ88M9v5+sO5C6W5BkVGgrdz
	 ducFlen3CopxzknkrEAmJwT5dTn959vpu+SEa6fPuIY0nZs7g0mYRnFwNAZmKZOAkKaLK
	 YWn2Ah9U3ebg2ln7TEc301AGVsXv1DP/3XPiCrkw/1YXZubsEf1ZJWUFbwRixmBDlB1ql
	 69buC7edR925ftZ3aELgbuqdkdz1LqH/8Ptp5DTDMahcvb9dLXfdR85wFTeEPBHJKXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H1Cph8bW;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA1606C298;
	Fri, 20 Nov 2026 17:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44AA1606C298
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H1Cph8bW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195328; x=1826731328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hHe5UA6gRj04Yam/2Su93QsRWygdL2zZOg7Mw9c1V8=;
  b=H1Cph8bWpSRNxS5lH6TSxbwtm4rq3jsM+sdW3D28nhCDAzZkUCS8ZoaJ
   YC3F+pc8dvUuyk88wUQGBxK9QwvNzp4ebDnPX+Zvx+8Zwgcd8NGbqXS1J
   uM38HJhLEUgGLuuW1Xe83ygVx/GWbuD4eBhdN61mE9ddsElLLl/KkVtqe
   6NvbgP1+v7XZ/Y9X+dL7OOVdZ9sccu203PTfZNVsxvltXMbHRuIElC9eO
   sebyv/iZoYoi+vZOM8oCC4V0wquQW/H5AX7IjCfS2k+VZ5OfLMJ4zH4+M
   hzbEnIA17+zXMlLFPB9u1UsJPmQs+R1ymuewM9TWo8yeRYghAlfzWunj1
   w==;
X-CSE-ConnectionGUID: p1y/bwZ0QkqyJs+id401bQ==
X-CSE-MsgGUID: FcW0BfH6S025GzTFmEbLWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157620"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157620"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:22:08 -0800
X-CSE-ConnectionGUID: hsHVH6rzSViQquCmjFiyBw==
X-CSE-MsgGUID: WTd/tQo9QuG4VHtMfZz5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868301"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:22:05 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>,
	ikaros <void0red@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 41/42] ACPICA: namespace: Fix memory leak around compiler alias flag
Date: Fri, 20 Nov 2026 18:19:02 +0100
Message-ID: <d6c2659bc726818faad879203b1703801154125d.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
References: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ANOBJ_IS_ALIAS is an iASL only flag that shares the bit position with
ANOBJ_ALLOCATED_BUFFER, which is a flag used for runtime installing
methods. Due to the bits matching a memory leak happens everytime a
method is loaded in acpiexec (using AcpiInstallMethod()).

Check the compiler related flag only when the code is ran by the
compiler.

Link: https://github.com/acpica/acpica/commit/b01f4e055910
Fixes: 8d7987340301 ("ACPICA: Add alias node support in namespace handling")
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/nsobject.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 49d9d917fa73..6eb278b9d714 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -175,8 +175,11 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 
 	/* Alias nodes point directly to other namespace nodes; skip teardown */
 	if ((node->type == ACPI_TYPE_LOCAL_ALIAS) ||
-	    (node->type == ACPI_TYPE_LOCAL_METHOD_ALIAS) ||
-	    (node->flags & ANOBJ_IS_ALIAS)) {
+	    (node->type == ACPI_TYPE_LOCAL_METHOD_ALIAS)
+#if defined ACPI_ASL_COMPILER
+	    || (node->flags & ANOBJ_IS_ALIAS)
+#endif
+	) {
 		node->object = NULL;
 		return_VOID;
 	}
-- 
2.56.0

