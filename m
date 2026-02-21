Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DDA1B0F19;
	Sat, 21 Feb 2026 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771673804; cv=none; b=anRGq+gJTRf4kGrWYSXq3oJPcPniiSnqfYvtg8TWtORcbdjKPzfEvmvWN42tcYgCKVDqPm0Zg7qAiDiGY4H9uk/pfMMTGUxqpPoOR43nB6DB15vOwX6dccTgajHvDo9riYzAU0DJxg0WUzohfjkACawcVjJCKq55BHe67Gd+bB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771673804; c=relaxed/simple;
	bh=2/uuKlJ8EHMgUktWMI0olras38IzPM2pzxQM9Dr3zps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kC/rC3FCaDOd0tF6NO1SjK6DuIHOi1+QBAi6l6MLG4Me5Rq0xgYPCH9segM5so6wTYmxnBUEr9YDrm/XMC4pykGIypgp1+NHaPjDg/jZGVMY6fCacfkUgVKaKQ6tRbquH52fnO0Bly3L24i2g2zz7RtJNYoSFzOkvTdb6iQFRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH3EXJo8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH3EXJo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92BEC4CEF7;
	Sat, 21 Feb 2026 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771673804;
	bh=2/uuKlJ8EHMgUktWMI0olras38IzPM2pzxQM9Dr3zps=;
	h=From:To:Cc:Subject:Date:From;
	b=EH3EXJo8tQ3/tvjUUWDXdu6UmtXQwtr78vugO57s5KI4lAwNc/OGe/0KWYjG3Ypj0
	 NafBWGbZwqKOs6vtVzjEGetELosMCVqDiiXlTmvaQE85SMP8mgY+gLaIbdBJPciqNa
	 ZAS/UdYp9rJlYidJlB5tqKHW56PR9CMWlngNKaygz2fyuEP+3Omt+L8i5gmn1hAaZj
	 l7wj7k6Nyv3JrclvRff6i70+K+hGM73AgbCVxgwR996SCfYWqPXB0bfDXYz4c5IRoB
	 zEOwNURxb29LmdzkwRST7VtpYu3LbtIzeny3uRyYUCwrrjTS7K3I5cnsdg4J1HLxLX
	 aYWcjZUv0L5Og==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 1] ACPICA: Update the _CPC definition to match ACPI 6.6
Date: Sat, 21 Feb 2026 12:36:39 +0100
Message-ID: <2829238.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Saket Dumbre <saket.dumbre@intel.com>

Update the _CPC definition to also support return package sub-type of
a Package (with Integer and Buffer) as per ACPI Spec 6.6.

Link: https://github.com/acpica/acpica/commit/17a761944cc2
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -379,8 +379,9 @@ const union acpi_predefined_info acpi_gb
 
 	{{"_CPC", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Ints/Bufs) */
-	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER | ACPI_RTYPE_BUFFER, 0,
-		     0, 0, 0),
+	PACKAGE_INFO(ACPI_PTYPE1_VAR,
+		     ACPI_RTYPE_INTEGER | ACPI_RTYPE_BUFFER |
+		     ACPI_RTYPE_PACKAGE, 0, 0, 0, 0),
 
 	{{"_CR3", METHOD_0ARGS,	/* ACPI 6.0 */
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},



