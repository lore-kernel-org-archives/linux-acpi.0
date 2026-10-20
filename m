Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505521;
	b=veGSzgJ/HKl7sJXSG8wQUYLV6hy8xvQEX0V5zROpyEzSrc+bB8oQfMP8qBO4YLO6fw8Z
	 8XNVc11Iup0Utn2JjgtrQzGFhYwCb4uhpgDgpUV7G6OZWC95tCWoDjdbn3oRHTA5l5G2h
	 qUS4Cb0aHz4vAiNEYlMS1B2qB5y70B6kJyoJnuJ/mDfMpwbu4ZOWjH1aTcRPIrcLN54jG
	 s6L0soFpVhoElf93sN5VgiVDBGGOlRb9gc8b0qmURK22b6hEuECpJ6/oloHIe/s7mr4Uh
	 XNV1cyy735E1r6O4aLYbE4s8QsuPezZVEC6iidsTWablwDI302/GrIE+FKABwj24V2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505521;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OYbWMWAHej7vsG9D6TBZpb9Sh4dj0dVhGITVoM/OsyA=;
	b=OapHETA+vXMH2il8XnHwJZU2VTq0gcq8KPNMPwQJSn5AfxEM/SzSbcoUauHAKvsx8uo8
	 kq2h2ihgSEb5px5D54oqBpalMWnvMqgP/U+3ZpBD3fBrGuxoEf4d1lUNEraYKzh4DwTL3
	 qvv1GFa97FbQB+fPBvZ3yNs0gwrCQq8x6DG7O2H/ism56GHPb2tZp/QALEnO3rlEt/CuV
	 xFaWxpQPNCQHURXkOM6VDyhg2u0XFJQ44/IuRU8XmLBkIkQfSR/P4GvYW3gnpSxJx1VJK
	 Jvxf4UyFrgIv2YOT/XTm1DCKCOnVkLNGhbwd7Ed86jDK76enl2AC9fG2vz+dUoIFpug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A3kPn+dG;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ECA606A32F;
	Tue, 20 Oct 2026 14:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18ECA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A3kPn+dG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505522; x=1824041522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wlhoVSZURtvc/UApP4FHm7iGvvSh+CJ/fvid+MPfxl8=;
  b=A3kPn+dGc3Ar5QV4LazvHJt5YZx/qNSaV+LHwceEGYOaLW1AVPthAjUJ
   HTvPw/4NETyTF6sNToreaeoYeTMnTBMOkRvldXLThQMpagUm+DcqVipmG
   GnenEwBhjdVQ4Y2KEwVH9EAomY1BQMY9LrZ97WPJ8kl19d/LIgsTcwPN/
   jNsDm40nAbZKkCjpCBmBRUbyfF+th2+06LfN/Jtf7ePYYeriFopEbErOD
   gmbi6NvaG6+X2pNxj1yKMBC7mYx/MQaElbKCriHH7sazID3uFCwivfQXW
   IWwFONdChWe1U5Wn5TE9zXGBdiPN7VQ3dlSKSzW2xOBsHIATBUQDqdoOo
   w==;
X-CSE-ConnectionGUID: 8NiJz6o7Q0OBmT03wSaSAA==
X-CSE-MsgGUID: U/aUlk4USLGlDv1GZQB5zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222317"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222317"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:12:00 -0700
X-CSE-ConnectionGUID: uskQ3NaIT6CO9eDY3cPuNQ==
X-CSE-MsgGUID: wCMNY2KFTbG1jyHXQ1bzYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888072"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:58 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 27/30] ACPICA: iASL: Complete KEYP support
Date: Tue, 20 Oct 2026 16:10:48 +0200
Message-Id: <20261020141051.2194123-28-pawel.chmielewski@intel.com>
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

Add the iASL disassembler, table compiler, and template support for the
KEYP (Key Programming Interface for Root Complex Integrity and Data
Encryption) table.

Add the KEYP entry to the supported-tables list and introduce an
ACPI_DMT_KEYP opcode so the subtable Type field decodes to a name.

Link: https://github.com/acpica/acpica/commit/39bcadc69364
Link: https://github.com/open-acpica/acpica/pull/1204
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 include/acpi/actbl2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index fb706b7a811e..c11d7e3b1ab1 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1178,6 +1178,7 @@ struct acpi_keyp_common_header {
 
 enum acpi_keyp_type {
 	ACPI_KEYP_TYPE_CONFIG_UNIT = 0,
+	ACPI_KEYP_TYPE_RESERVED = 1,
 };
 
 /* Root Port Information Structure */
@@ -1207,6 +1208,10 @@ enum acpi_keyp_protocol_type {
 	ACPI_KEYP_PROTO_TYPE_RESERVED
 };
 
+/* Only version 1 of the KCU Structure is currently defined in the spec */
+
+#define ACPI_KEYP_CONFIG_UNIT_VERSION 1
+
 #define ACPI_KEYP_F_TVM_USABLE      (1)
 
 /*******************************************************************************
-- 
2.50.1

