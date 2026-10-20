Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505490;
	b=gKOb/N6hzFZXWu94h8jThbLh0r6HbEtn7sd37chDl5JmucBweaNSY/XJOKdnrMyKlGPQ
	 OXzZj0hcqmXD/VCj0dDxyI7RZV8JOTCCEmfauIrk9zMs3owyTdpEP+Sg0qMk18oiuuAnc
	 UUNOfCe1pkWFTVYHtls+KS0G/jpinoizi0tKJFhQHRlffAs4OvHkPhyoavDoCjvifK23E
	 a1qi4yKKLsDNMacnK9fYdfgxhlkWOgoTu1Z38r15bgHQZQRg1hTWfEJ0xTur9gnkrcIFs
	 FUXQ2BTlOp+7tMuIbTOHNZu9IXd5hIdCf8qjiesGipILIKGgiNal+DL/RKc4+sv0Dog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505490;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RYHneOoTuXPf3gjSzN3KIEIZvJRyUnT1CeHZw3imyxE=;
	b=ie+cBn9AJsKP45VqxMjs2uKE90oYYIVt4NHWaNIKQiJzEyOk767OdDCSIF6MdL9rPOOP
	 8varnbUCNV0nRAV7HmEtz66FS06VdRkUfRJ4TM6AD4SzWPHWHjlne3WNgt/yDYtSBEnci
	 sMhO6LsAt8qf4Hm+yioIM5VQI+mrlKr/PUDlelXTJGpQleRZqMqnv+0vsfvvZXh9QdPn5
	 S9P9pRln8K/4r5lfIHpIYiTyXZyD6/UBMqDg0BBpg5wERuAoTqiglmUOpKxP891kQCFwL
	 I0JqTkbRh0C0oFJZYmHOMV+Z2ak5V4pbC0QiHsm4DP38BsTl/1ZigXjseSXMqabVr8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WJNtPlFE;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502B60A3827;
	Tue, 20 Oct 2026 14:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2502B60A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WJNtPlFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505491; x=1824041491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AQSgHGCw6soadE8bznP1oTh17US2sv9868hDoCExVYU=;
  b=WJNtPlFEvfGWlL78ezagHR5/+gjmdFGjWPPOzHegUJpg9L7I0RascApP
   ljNZqljrgp6h54n+c/s9fbvE+qfYRigj6vs2CoE0C1QLFP7KfuQ1oQfYj
   LzsbcR2tXXyLluFHGJqeZ+A4YiQc0G3VoPppyjxRZTWre7MxmtN4XxAbn
   LlwLct1+0rVHY68+0misLtP2HVbBiwC979CS5vRmCkr4vmyY3Hi8159Yz
   +nGX0dc301OJdOdg45kG6AXAZv0qQlK4u7dtYfT7A9p4M5jDl45iwL9J/
   Sd8gHaOvil6eOERFeEMLZwN1duEoAhMYKPwQoPpaN+6g8OVNl8wXuApnb
   g==;
X-CSE-ConnectionGUID: E/D1UrZuQ6KFx9T16viBIw==
X-CSE-MsgGUID: IKF7CbM7RNG4ccZYmvUPzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222232"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222232"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:30 -0700
X-CSE-ConnectionGUID: kD2CfWUkTIm4aa+5rycA5g==
X-CSE-MsgGUID: JfirVIoBSYCjGho7vRiSpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887942"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:28 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	ikaros <void0red@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 10/30] ACPICA: Validate 4-char field names before namespace lookup
Date: Tue, 20 Oct 2026 16:10:31 +0200
Message-Id: <20261020141051.2194123-11-pawel.chmielewski@intel.com>
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

From: ikaros <void0red@gmail.com>

acpi_ds_get_field_names() and acpi_ds_init_field_objects() pass the
4-byte name of a named field (arg->named.name) to acpi_ns_lookup()
without checking it first. acpi_ns_lookup() treats its argument as an
AML name string. If malformed AML makes the first byte of the field name
AML_DUAL_NAME_PREFIX (0x2E) or AML_MULTI_NAME_PREFIX (0x2F),
acpi_ns_lookup() reads more name segments past the 4-byte name. That is
past the end of the parse object, which is a heap out-of-bounds read.

Before calling acpi_ns_lookup(), check that the field name is a valid
ACPI name segment. Return AE_BAD_CHARACTER if it is not.

Link: https://github.com/acpica/acpica/commit/cd05b72db519
Closes: https://github.com/open-acpica/acpica/issues/1171
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/dsfield.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index d7d56cc600d3..d916ff6dd501 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -374,6 +374,12 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 
 		case AML_INT_NAMEDFIELD_OP:
 
+			/* Validate the 4-char name to prevent OOB read in acpi_ns_lookup */
+
+			if (!acpi_ut_valid_nameseg((char *)&arg->named.name)) {
+				return_ACPI_STATUS(AE_BAD_CHARACTER);
+			}
+
 			/* Lookup the name, it should already exist */
 
 			status = acpi_ns_lookup(walk_state->scope_info,
@@ -629,6 +635,12 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 		 * in the field names in order to enter them into the namespace.
 		 */
 		if (arg->common.aml_opcode == AML_INT_NAMEDFIELD_OP) {
+			/* Validate the 4-char name to prevent OOB read in acpi_ns_lookup */
+
+			if (!acpi_ut_valid_nameseg((char *)&arg->named.name)) {
+				return_ACPI_STATUS(AE_BAD_CHARACTER);
+			}
+
 			status = acpi_ns_lookup(walk_state->scope_info,
 						(char *)&arg->named.name, type,
 						ACPI_IMODE_LOAD_PASS1, flags,
-- 
2.50.1

