Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378F48094B;
	Wed, 27 May 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905578; cv=none; b=jhA6v4JPPAFXpJAcfs6bbMrE9TAHR/TtAoXeeShsFWcxHi5We+nWUOUsffIzfKS2djXUmQu1+zKHF4R7Xx9oYIm2nfXOmbS90fPfaFH+PvWHk+QNmDjNuzcx1SWGaIc7yhmHEqOEakV8PK57xkmFT/DEHrA9yPs9v5P/W7BLE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905578; c=relaxed/simple;
	bh=kC8fg5i+eOPD1Oa7U3kxnmia82nVLOEatSSjmPtCSx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IfN3mfK7Q/YFzjmNr8P9YvnkFJwfIvFVFMPJwMCAfCC5KodAZrmIFaay1RdRADyPHfKgGINJshh+VeLOYayPalkcVxrlgMLoN/8Pd13H9/DGyKfdyxtyC0EBaSsnkxlYHkj/VFnDCy+m2MKalPnU3IYPOeAYRj+ydrmoNSdChBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6LJid16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6LJid16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E161C1F000E9;
	Wed, 27 May 2026 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905576;
	bh=LB99z8qpLIaLIdfDyG01OExBj6EjiRduUK5jkhikM98=;
	h=From:To:Cc:Subject:Date;
	b=N6LJid16zFSvsJYd2nslNIebZ9muSm1bGeeeT/XzGc1cjzjstPhIIg1d2n5xE3cOo
	 CDhTbU2nl9h9cEpb3ayqD43Dl0MyU4uGNdo/MMgL9ZO6PYPWJN9wZgw1k007mgWuqb
	 YG8mSitg7nZjLK/iKusc9YPK9afqflEwrT3yG43GxtcMZM0NbQTBxHUFDoHFIBq9An
	 t8qZXAo7U9oLJEA35NdRJC+JtD7j9z5mjKO5MtvcaF46mMt7oHFFFtXr82gBQhwrO1
	 3+5VKmhEz8eMm/pzXmvA74GBCCS8R/VZgMgGd9OL15/2vxxz2h61waKNLuUW0Um2IX
	 aPFtd2V+Yq5lQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 00/27] ACPI: ACPICA 20260408
Date: Wed, 27 May 2026 19:50:57 +0200
Message-ID: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series of patches corresponds to upstream ACPICA changes made between
the 20251212 release and the 20260408 release that have not been included
into the Linux source code yet, and a couple upstream ACPICA changes made
after the 20260408 release.

It contains the following material:

Abdelkader Boudih (1):
      ACPICA: Fix FADT 32/64X length mismatch warning

Akhil R (5):
      ACPICA: Add LVR to acrestyp.h
      ACPICA: Fetch LVR I2C resource descriptor
      ACPICA: Change LVR to 8 bit value
      ACPICA: Mention the LVR bits
      ACPICA: fix I2C LVR item count in the conversion table

Aymeric Wibo (1):
      ACPICA: actypes: Distinguish between D3hot/cold

Daniel Schaefer (1):
      ACPICA: Add modern standby DSM GUIDs

David Laight (1):
      ACPICA: Remove spurious precision from format used to dump parse trees

Pawel Chmielewski (2):
      ACPICA: actbl2.h: ACPI 6.6: Updates for MADT MPWakeup
      ACPICA: Update the copyright year to 2026

Saket Dumbre (1):
      ACPICA: Update version to 20260408

Weiming Shi (1):
      ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()

ikaros (14):
      ACPICA: Fix condition check in acpi_ps_parse_loop()
      ACPICA: Add alias node support in namespace handling
      ACPICA: Fix use-after-free in acpi_ds_terminate_control_method()
      ACPICA: validate byte_count in acpi_ps_get_next_package_length()
      ACPICA: add boundary checks in acpi_ps_get_next_field()
      ACPICA: Prevent adding invalid references
      ACPICA: Fix integer overflow in acpi_ex_opcode_3A_1T_1R() (mid_op)
      ACPICA: Improve argument parsing in acpi_ps_get_next_simple_arg()
      ACPICA: validate handler object type in two places
      ACPICA: Add validation for node in acpi_ns_build_normalized_path()
      ACPICA: Enhance buffer validation in acpi_ut_walk_aml_resources()
      ACPICA: Enhance OEM ID and Table ID validation in acpi_ex_load_table_op()
      ACPICA: Add package limit checks in parser functions
      ACPICA: add boundary checks in two places

Thanks!



