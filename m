Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505509;
	b=KZo/ORJo+fhZSLu1ZRSUGmGEhR6llZ37AGifnA/M4g8dcjS6GgYkA8/GlLdf+YvKkBxK
	 UkMXO/j0DW48vtBdrsmfNde+b4iQkfioGkYfxzsCyrK6TLSfWNoqPxI5i8RL9JOMpWG4o
	 BXu38yVmlFLwH/rF7foYSVJebwpfyfxy04HIYlksrUzcRGYo+NZNwxxRNxM+T/6Z1krP9
	 PoE7HJviwz/3JswMxoKxh1QUDx9wQwr8CgiebYmNovvLOgp8TOInoCbqzOzeM5NxybhSt
	 uM8yqrs1oAeEFNC7cmN2M7flP63QzZGIh4PW4Y2HoNnUYB8KcflyaTwiKUqWIUDh3EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505509;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gzhV0Fj++RaA9yBl5dAyCdRX2A+qRzQbJSvWvF7Qm7Y=;
	b=Sbru+tbQe1y/x/JGg0tj8nnaTqXeMXtcqBVLpS9gLQ72OA/HiOL+eymISakA7iX5D58S
	 6AhvsyUY7wYpsoKZu+c5wUrA0HJXd3Toc3WuX9FeZcRgFKMwVEHtvJWSvbFgzRiQlU0/J
	 B/FiZ/ha02PAcgKMFp4rDFDifFt67wa92d6S/4HsZ4FDvn1Dij9rpmA3ZtManknT21tP6
	 ZP42DzVL4w6C9UUS0XZri/dNkbsAbD3OFhlkJXP/BiWrlX8/IbkHAdZ6HcHX9i1BAJ6Yk
	 FnD7ZAYDfwmJBoRgF1tCkiZnWEbV5I9IDc50T4xUElXqmGLmhH4+T1E+RPJd7QmdAxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n6KMO7x5;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B16460A5BFE;
	Tue, 20 Oct 2026 14:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B16460A5BFE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n6KMO7x5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505509; x=1824041509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f9jZKcy9qYbtMfESnxwwgbZxvIha6FCyzMSD5JFGd8w=;
  b=n6KMO7x56H48k8rN4Al0pcn01F0jcOVoS777kXAB05wLPoS8OB/T4elZ
   rIliMHkWVLTe1Z4Osvs70OO8FgU9xPThGQqFbOr4Ff1Yd6FijWXeKUYav
   jPP5VzowFOPbFJ6nD/h04MdiNwfQ2E3yYx/PWQsSzxPMn2bGCrv9HzKBZ
   /qjPhVPB2jYNTat1N9TARLktII0TeZai0xevYrSx/C1oBPjTPGAZaST4+
   PS5wIPfhsbuQthr4krQz0p4Eus9cysLFOa1L9XOls9epciTfRftpepYP1
   irueBQ07VxjsxyWXWaYgpQr9vW5F0Zqf3uAA22gCzdheGCR3kRB4GkIPO
   w==;
X-CSE-ConnectionGUID: fRSF8Sm8Sdq9oA+6EzI5bw==
X-CSE-MsgGUID: 62kYJE+oRJakfrgDKH/uvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222288"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222288"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:49 -0700
X-CSE-ConnectionGUID: rV+A6lYiQzO050FeIhABhQ==
X-CSE-MsgGUID: //Zokxc8TqicOtrf8EmkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888017"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:47 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 21/30] ACPICA: compiler: Add _Ixx GPE object
Date: Tue, 20 Oct 2026 16:10:42 +0200
Message-Id: <20261020141051.2194123-22-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
References: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
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

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

ACPI 6.6 specification, chapter 5.6.4.3 mentions an _Ixx object (where
xx is a two-digit hexadecimal number) which presence indicates that the
corresponding GPE is enabled in the low power S0 idle state.

Add a new reserved name type to symbolize an object. Since the
specification mentions that just the presence of the object is required,
any one of Name(), Method(), Device(), etc. with the _Ixx name should be
a valid indication.

Update comments and the disassembler path.

Link: https://github.com/acpica/acpica/commit/7bf643309c2f
Link: https://github.com/open-acpica/acpica/pull/1223
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 2208dc7aff8d..be44194b0426 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -152,6 +152,7 @@ enum acpi_return_package_types {
  *              _Qxx EC methods
  *              _T_x compiler temporary variables
  *              _Wxx wake events
+ *              _Ixx indicator for GPEs in low power S0 idle state
  *
  *      2) Predefined names that never actually exist within the AML code:
  *              Predefined resource descriptor field names
-- 
2.50.1

