Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195263;
	b=lstNfw7puf/zdRREtVFrbNN/eGBR3I+ty9yFOt1zlsj4HglO4CsqlEFtuJWEVchSK71w
	 26MghKXRZ8X90Uc7poX5r3mbnDX0Pw0Y7NiyT26A5p7dmz6VrIgbcr5knpQ0P7jtmtgao
	 taAacObjA3INFojlkdVEOFHBYL7nrNSZoIvTqnaU2/Bwy8a1uAV8QkVV4Qw+Ul53kMbIn
	 NdLTlXyND0t7JZVwAPyIOs7NVCG2BnQ+BHczrA81Ky+/MK/ol2cEd/yh23HGly4+B2lnz
	 m849fL6bsUNCOJFa/w+pOojanGY5WwSdlzgBLGKxJdT0Xt5QDznI+7SI5lhB7QJqUVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195263;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1EHp1CZ/P5iti1sgnDj2uMDYA3BCoB5xU6p9mUl22nA=;
	b=doNje/oj3UDHJLbjrpvAWid/6e/K4sy8SVqhFljQSt2amqhp/8FnfOnHVoxH0UjH6EmW
	 3TQSwz1ouF/ay9+zRXteUzlDK12JosAW9gWtyZezimHbNUorvPqaN9zC+EHLEPlKg1I3s
	 uBq9SUrW0lfFpezCRufoyWJXcmH98aVICWOzHz7iDTa+oViYnBTPgf4RcI27K5HpHFwnR
	 O4wLJ7oa6go6a4qZ6bdgTH6txWuacdsE/J5i9oSlDCqBuqvGhwty5Q+ABCg+zuI1D/BMR
	 JRLDmtgLvThXw46+tfpgtv+HEp83lS9yD9VNXBDA64aYGqaheri3l3SaOqc79RH1/Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Etv9L3t9;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E560A5BEA;
	Fri, 20 Nov 2026 17:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E0E560A5BEA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Etv9L3t9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195260; x=1826731260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9A0kSsjLuI2P3l/y3J3dVQYc1NYAjlEqe1cNqVlPfgw=;
  b=Etv9L3t9SoAfhGCJQVaswXDUDQSy/F8GAS7DRC3A/VWTaHqAu+dZl5V4
   jxzj4MfYOQELP35D4gw9UVuaXJSsEDcSca57WjGsF8JUjnBsHfm2LJNvF
   +ENHWOMAnJP/Bxbx057/ZSNTZs268fhzkoxByi1XdVswx5sxCEugJHhZr
   kxYgpHyDBrwC59MeLzugd4Xw+re7KOsy9NagK46DqbCbspJMI5T5PMJ8F
   3w0L4RhoG7TpETRAlHmmTZOKYpJMZoGsDClzyrXNl5zbgGWLRdm2EuAIC
   324KeWEvcaeb1TxNGkw9Qlvab+Pl81KhhDVRLQMIyf8VbXXmgCVik0fYu
   w==;
X-CSE-ConnectionGUID: ELBfU4x0Sa6kcuTBEHPlGA==
X-CSE-MsgGUID: 0hwPBDxhSEmoKhaF0r4Lww==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157413"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157413"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:00 -0800
X-CSE-ConnectionGUID: mk5AdXWwQiKagh6o1jQUMg==
X-CSE-MsgGUID: 61PemnO/Taqy5O1mRHUwHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868030"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:58 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/42] ACPICA: compiler: Add _Ixx GPE object
Date: Fri, 20 Nov 2026 18:18:39 +0100
Message-ID: <88365e5ab7928740a1b8ce6369e7b6f44102e869.1795194329.git.maciej.wieczor-retman@intel.com>
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
2.56.0

