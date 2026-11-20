Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195320;
	b=UR/azN9bFzOHqlyvLQFw/ApcxGqH04stMLH/NOXmkTiIN2OLGEBDScxpr40p8ZZ33HFd
	 7qeEU9ysn40QHia4XS7TEhBgLY0qZeD24LKG9aa268bdk5zHqBf852aH9OUf7ZZwVX5O/
	 pKrycHELdt3QUTZEh/JqxZk5G29u5O5Dd03EcbJvX37kw4cWWC7lEVoQVg5qQoXO86VLI
	 sM29uoMmBZdZB1QohQV0drbADaoIktA6mt1OPjIwK7Wje02DZ4pfpcCee6J9Pj5SpKm3D
	 FsotvGPG4a0ciOr3wTI9clyODwBn9E5gVc9SgwTHMZdSzm2l3WkHhL07/dgZFD6iTGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195320;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sDAxzMJLwYLKpQnKhkHOLT1DIbdkpbhaI7RyWh5mZsw=;
	b=Zf5D2u+58jfQynzmo46FANseiYo3HQkqlP7I517mGGwyZTic3R8NJSBN6EIqCbLcSALF
	 JMIl9RGMWQSakaq7m7pQETu/uC0KnwQAdpDlJlJCyCufmAgkpIpj0mtAIt9DE0aEWIdX8
	 N6lsATTYY45R76OWN6u6wmApF834cHo2vxN4MhrbjCUrH4k+cvto50wcxDYGx50E28kJN
	 UVtWE2DULBYOSVrukGPG5vHgn+wqxSBVur/3P/R/2snKNkKK5ygNdpFTfG+gqHAPWs/Uo
	 KZbc1k8EvW7UACyTidmpIlC8AZxjL9N/AhDUQp/HkjVS14UcAYZ0opRLMneHlyaoyhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="S7/2i6H+";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB6606B3D0;
	Fri, 20 Nov 2026 17:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CCB6606B3D0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S7/2i6H+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195319; x=1826731319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQBiDdB9+4f2VYi2hCZiD/1UsUtaoExoGjwjgyJkhb0=;
  b=S7/2i6H+/6VR1jnUnTzBj3Gklv46oaoe7fI+1PtZoWz6Z/HnYtoEwJnx
   AW6VEJsOlbOEoFRaxq9tf/5GFBkK8S1SldGRxIc5DFuRLeYThHZ7VzECt
   WHCe73XTljaZ/R+w2IEdCZlhK85k2WvpQDplNRSnNMe6L70MOea0bpeZL
   PJgriiHM+Z4DvPEKNn6kd2PRPn/mRFqv5j+SOhMUuEGYwj6xF1hCTx1HW
   BgArq5TtL1ODj0UiStxdI8+ZSblonJa6Lc1Invb0oygiZVxov+Sm3bqZd
   7C/sKFk9rMFZIZpWi2sR9xk4nhQ5T8NPmoxUsA1+VWBBPuwLwA/7t7zr1
   A==;
X-CSE-ConnectionGUID: FdlULKKSSRKvvAPr+4LerA==
X-CSE-MsgGUID: c7kBr76uSdmvrPNtDinTyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157584"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157584"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:59 -0800
X-CSE-ConnectionGUID: HyWDqBggTuaIGS1UnKoOQw==
X-CSE-MsgGUID: N8/l9M/yTnmaA6navHZyBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868278"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:55 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>,
	Kyle Pelton <kyle.d.pelton@intel.com>,
	Bob Moore <robert.moore@intel.com>,
	Erik Kaneda <erik.kaneda@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/42] ACPICA: executer: Fix copying PCC source buffer data
Date: Fri, 20 Nov 2026 18:18:59 +0100
Message-ID: <d9d3034be8d2314ffa9829a22ccd14d8bc52ee00.1795194329.git.maciej.wieczor-retman@intel.com>
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

Paths leading up to AcpiExWriteDataToField() group Integer, Buffer and
String together when handling the operand type. In the operand type
union, the integer's value and buffer's pointer share the same space.

One issue can be that the number stored in integer.value is interpreted
as buffer.pointer - which can happen if ACPI_TYPE_INTEGER is the source
operand type. The following code should result in a memory fault as it
will read the value as the address, and won't use the address of the
variable as it should:

    COMD = 0x01

Other problem is if SourceDesc->Buffer.Length is smaller than DataLength
- then more data will be read from the source operand than planned. For
example the following ASL code would result in extra data getting read
from BUF0 to COSP:

    Name (BUF0, Buffer (2) {0x01, 0x02})
    COSP = BUF0

Fix the first problem by moving the Buffer and BufferLength assignment
before the PCC buffer code path.

Fix the second problem by copying only as much space as the source
operand has. If it has less than the destination just zero-extend the
extra space as similar Field operations do (AcpiExInsertIntoField() for
example).

Link: https://github.com/acpica/acpica/commit/9ea9025e30bd
Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region support for AML interpreter")
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/exfield.c | 63 ++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 632fc8693f23..2199d054ed58 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -291,6 +291,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 	acpi_status status;
 	u32 buffer_length;
 	u32 data_length;
+	u32 copy_length;
 	void *buffer;
 
 	ACPI_FUNCTION_TRACE_PTR(ex_write_data_to_field, obj_desc);
@@ -338,7 +339,34 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		    acpi_ex_write_serial_bus(source_desc, obj_desc,
 					     result_desc);
 		return_ACPI_STATUS(status);
-	} else if ((obj_desc->common.type == ACPI_TYPE_LOCAL_REGION_FIELD) &&
+	}
+
+	/* Get a pointer to the data to be written */
+
+	switch (source_desc->common.type) {
+	case ACPI_TYPE_INTEGER:
+
+		buffer = &source_desc->integer.value;
+		buffer_length = sizeof(source_desc->integer.value);
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		buffer = source_desc->buffer.pointer;
+		buffer_length = source_desc->buffer.length;
+		break;
+
+	case ACPI_TYPE_STRING:
+
+		buffer = source_desc->string.pointer;
+		buffer_length = source_desc->string.length;
+		break;
+
+	default:
+		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
+	}
+
+	if ((obj_desc->common.type == ACPI_TYPE_LOCAL_REGION_FIELD) &&
 		   (obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_PLATFORM_COMM)) {
 		/*
@@ -369,9 +397,15 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
 		}
 
+		copy_length = ACPI_MIN(data_length, buffer_length);
+
+		memset(obj_desc->field.region_obj->field.internal_pcc_buffer +
+			       obj_desc->field.base_byte_offset,
+		       0, data_length);
+
 		memcpy(obj_desc->field.region_obj->field.internal_pcc_buffer +
 		       obj_desc->field.base_byte_offset,
-		       source_desc->buffer.pointer, data_length);
+		       buffer, copy_length);
 
 		if (MASTER_SUBSPACE_COMMAND(obj_desc->field.base_byte_offset)) {
 
@@ -391,31 +425,6 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		return (AE_OK);
 	}
 
-	/* Get a pointer to the data to be written */
-
-	switch (source_desc->common.type) {
-	case ACPI_TYPE_INTEGER:
-
-		buffer = &source_desc->integer.value;
-		buffer_length = sizeof(source_desc->integer.value);
-		break;
-
-	case ACPI_TYPE_BUFFER:
-
-		buffer = source_desc->buffer.pointer;
-		buffer_length = source_desc->buffer.length;
-		break;
-
-	case ACPI_TYPE_STRING:
-
-		buffer = source_desc->string.pointer;
-		buffer_length = source_desc->string.length;
-		break;
-
-	default:
-		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
-	}
-
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 			  "FieldWrite [FROM]: Obj %p (%s:%X), Buf %p, ByteLen %X\n",
 			  source_desc,
-- 
2.56.0

