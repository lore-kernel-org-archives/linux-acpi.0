Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505519;
	b=hqaPRqh7Tn+D+bRGLjA4kHWHVdbMh2o5w4jk3f8Riiw8PAx3Kf2Wn1bQCUntT+nIDyU+
	 ckLVsUbv8TNlWpbV8dVABvg1DOpoZnsHfvFcbvNdC9AzTo9d5zWfbFvibNXi7FnLwRiCv
	 tWVF46hBAMEQ6N5a8VDzLqPMxcuAWyNf6eHQZRXWtIIukb24yxSHGhtdP9V7oeZpuy+4s
	 fSKuTNWWugTIgvrp1Bw0/44owlLzbbTeo2jxyUPdRko4djMibqBtJt7SY1QDge9zCfS42
	 hVKU6lDJPUpfBiMIm23qRbnq3AsG78SP/mJCjDPezmbESQGiQ8xfvb21afuAYo6/y7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505519;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mjj/N/IW6W5rLe1E2ulLBABFXrxMVmw8rULzGCm6H34=;
	b=R8HeM/rTHX8xtFJiAjhHldhRSAYsszO1YIlJAMmUjKRHcpFjdOd+nKIicAOgOBU9ja2K
	 lkCu2/Ma8KqhhamHSesPaoiSSulqkhLMOCfmLc0V5atLmZB8Zm3+AYq13zdpufOQpic5e
	 80TOrxxni5midHWeOEJ/RL6WkDCgMYcA/6o6g+mDYW9jnQeO1VjrwjprQaSoxGCOIpnKd
	 J+YCCt5lnYU6aZtebALgVz7HBJm3GgCjtoAvaBOQ13ojanPZTSi8xsiqPs5JYTeD9mA2N
	 SOlB4kZeQDoUtCrSony3EyuqoJI9/FQ7Onm//UQoEAS+MBx8g/0wLZUAYVFVfI4Rgkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MzD+aDRF;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90EC60A5BC6;
	Tue, 20 Oct 2026 14:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E90EC60A5BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MzD+aDRF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505507; x=1824041507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fTmumLRcwjYpM0vFKTiyuvshvUKJA5pTbWfCdmMx2qM=;
  b=MzD+aDRFK4Ht+W5dB7XLInWo1wMVsf9a51R7RJYSa4gJkgJJco0kmVkH
   Ok2/0yNqMnn15GHkpG+FNGe6RhZtkAYZDcpY3PeDPhQ1WUe0GYazgc8y4
   RVOe8cYVAoifMQUQiMdZBxAnAGAlMm9TqkqpVbk7B366cwzgcadkqTBNu
   PDOJIsET/61lDktm9oYnxuZmdf1fUnkXga5RAuvC70OqIeBJW2yMvnZB+
   IXtBDGkCTt3O4RDlsgGO/K8OPkBKIJ6G9g6E5ceIc0Ix+lW/8RzYjI4Ae
   vJAtwnAvOS2n+LMUMQIOCPNnzE9KVXzbVhG5Sx98dpzXR76Xygrm255Ji
   A==;
X-CSE-ConnectionGUID: VY7XIpuZTZ+tDaSU4u4qmw==
X-CSE-MsgGUID: ozmh2QnWRT28JpcCv/eUbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222279"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:46 -0700
X-CSE-ConnectionGUID: 66Tc5YBpRqW1sHN+u26YmA==
X-CSE-MsgGUID: s+ojw+84TWiVYHliC5Vwhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887998"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:44 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Dot Slash <jyjuykuytweg@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 19/30] ACPICA: executer: Fix NULL pointer dereference in AcpiExStoreObjectToIndex()
Date: Tue, 20 Oct 2026 16:10:40 +0200
Message-Id: <20261020141051.2194123-20-pawel.chmielewski@intel.com>
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

Fix a possible NULL pointer dereference when trying to store an empty
buffer into an indexed string or buffer. Source-buffers are only
allocated if the Length is non-zero.

Similarly to AcpiExConvertToInteger() reject empty buffers with an
error.

Link: https://github.com/acpica/acpica/commit/077d74a42549
Reported-by: Dot Slash <jyjuykuytweg@gmail.com>
Closes: https://github.com/open-acpica/acpica/issues/1193
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/exstore.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 86be6bce1648..cd60fc366b08 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -295,13 +295,29 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 			break;
 
 		case ACPI_TYPE_BUFFER:
-		case ACPI_TYPE_STRING:
 
-			/* Note: Takes advantage of common string/buffer fields */
+			/*
+			 * A zero-length buffer has no first element and a NULL
+			 * Pointer (see acpi_ut_create_buffer_object). Reject it, as is
+			 * done for the buffer-to-integer conversion.
+			 */
+			if (!source_desc->buffer.length) {
+				ACPI_BIOS_EXCEPTION((
+					AE_INFO, AE_AML_BUFFER_LIMIT,
+					"Source is a zero-length buffer, no data to store"));
+				return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
+			}
 
 			value = source_desc->buffer.pointer[0];
 			break;
 
+		case ACPI_TYPE_STRING:
+
+			/* A String always has a pointer; a null string stores a zero */
+
+			value = (u8)source_desc->string.pointer[0];
+			break;
+
 		default:
 
 			/* All other types are invalid */
-- 
2.50.1

