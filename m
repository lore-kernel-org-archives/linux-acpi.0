Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195277;
	b=ECyKbTG6wpxclxJ23MLUOnu1FJe524bkHxcIwH5SIRUyYFxqwlglnmL5onI0QzjZv8cp
	 SJEcLTbhedcVvwI/eDzoN21FqBgCLEU3WSKZPceE76uChwwRjtx070v9Q/YEXXuCvdvpB
	 Tsg07DPuvCmu67KlNJ22MA0qREEVppn0X5i4+NJ65lS/M5EdRHoNr9d4TSulCSE5nKfbv
	 TKU95AI1c979zXD/T5dFQOxfECPwPAJxJMAgNqN/JzRHpQgcrKDl0qPZRrBZqKhiDw0XG
	 0rP1EXpNkW9r1RsDpLEezBBSYIrj6VOuzzPS5meUZ/EGRxpPiuRijDMNCrPzBIPJxlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195277;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P9SEqk6DUVLP0o0H9wkR5f5Xm6+h3Ji7hOkO7f1AAQY=;
	b=WAe74onwY5cKbtTB78qV6JDspOX1x0p8yaOsBxaJuTZeHsOPv2mh5ms7qqKUocxjMcbh
	 npaLDMSuwcu4046o8gcOU+9wgwqiuyAwNcH/VU9AkhU6ZQ/lfV06cu6uCe+4WOTFAtyLZ
	 w4nNTRBfQF25K1kUIfKf4od+gkuXZbgbawxv1j3oeABAO2+ISqwrj/xjDBRIf9yowftjx
	 X9wZXARz1AiTeDVf1C0vO/f457UrUtHnO87XE23qBiRvwYGbYpNZSiBxYsuNkr5mv2Owq
	 UCiagtlw9CKUY5A7BQY9aJwYTcBi3xzodFGUO+CN7WrpreBEtciC4UeKvzftFtOcB8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dzieUwMu;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E15606A753;
	Fri, 20 Nov 2026 17:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9E15606A753
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dzieUwMu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195275; x=1826731275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fNyt5bds+2D1M6oS0dPhXEdnSM0yqetXMthRzRSIkzQ=;
  b=dzieUwMu1O/G/Utz2YbPPxC2g5RNpcibZ0WuCIuw7yzC5h9DXfW3HGAn
   61HggQ2qnho98Z5iTc1O4EYaDC/UtH5PoMooluqfHJUmUl76X73spyzQp
   4aaMkWWvWYdx6EU/haWXWg9ewe4dprquZOSRBazn5PGDsfrnp0SbE5U4N
   WEcAZJ/Gh67oeWQ6f/lThla5umVDHFfAg4Hz6WvCYkFBhnTbZdbyKEL9q
   MLjFYbMI12U00ddfOAdspFKl9Rhlp2Lq5EzVd4nD4m6mNKl8qPvlKWQly
   +XYx2PUj8n940Z+UcFeky8gY6xqg2vBWHVRzh+zu3mzBznYu7c7hD6/ql
   g==;
X-CSE-ConnectionGUID: SrFXTPSQSNibLWqPq2DUBg==
X-CSE-MsgGUID: fgp+A6pMT7modXBQojAMLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157448"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157448"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:14 -0800
X-CSE-ConnectionGUID: x1uggubvTF6wahUqtu/Tbg==
X-CSE-MsgGUID: K+q7NuFiQvmatyyWYy+8CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868116"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:12 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/42] ACPICA: iASL: Complete KEYP support
Date: Fri, 20 Nov 2026 18:18:44 +0100
Message-ID: <1dab489b46ff26fe5464571906682ac15ffdd571.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

Add the iASL disassembler, table compiler, and template support for the
KEYP (Key Programming Interface for Root Complex Integrity and Data
Encryption) table.

Add the KEYP entry to the supported-tables list and introduce an
ACPI_DMT_KEYP opcode so the subtable Type field decodes to a name.

Link: https://github.com/acpica/acpica/commit/39bcadc69364
Link: https://github.com/open-acpica/acpica/pull/1204
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 include/acpi/actbl2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3f6e093133c7..9af7c51d1297 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1177,6 +1177,7 @@ struct acpi_keyp_common_header {
 
 enum acpi_keyp_type {
 	ACPI_KEYP_TYPE_CONFIG_UNIT = 0,
+	ACPI_KEYP_TYPE_RESERVED = 1,
 };
 
 /* Root Port Information Structure */
@@ -1206,6 +1207,10 @@ enum acpi_keyp_protocol_type {
 	ACPI_KEYP_PROTO_TYPE_RESERVED
 };
 
+/* Only version 1 of the KCU Structure is currently defined in the spec */
+
+#define ACPI_KEYP_CONFIG_UNIT_VERSION 1
+
 #define ACPI_KEYP_F_TVM_USABLE      (1)
 
 /*******************************************************************************
-- 
2.56.0

