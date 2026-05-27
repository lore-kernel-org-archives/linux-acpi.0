Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933B47ECFD;
	Wed, 27 May 2026 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905555; cv=none; b=UII2fmm6FhjZaX39lgKCc41+FHymxwEw1quSZMDecifYP4mh4ywK6qPW6IYNuzg/M+BCOfU22WdCyCdPhUPgDTz+qYMXxi6XQDlMzi3Ufddd+rAbk8dKQbfBsiwu5QmHjSmtW1Xjnqi1HWpmeV6frsgkJ4Zl/hPaI7xno7CbxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905555; c=relaxed/simple;
	bh=efGL1t6ETespxwRwYDaK/cIQdLX6+TQuV7PlkPguct4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWn0zJPml2qTgENEQS4mAcx4GjVHlOaemfW6pOzmFqMZ67z9yNC/dWDLOECQsnCz8z0DEi4PZwIDa7XhYdve/YFqTypaa+6mrfdCV9dCKXSgMn5ST4yqEWHENw91O9m2YT2MpnIDDgcDV4lByc+/M0z9LY2KidNwMLbHjqk7BIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib4GMeGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib4GMeGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D1C1F000E9;
	Wed, 27 May 2026 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905554;
	bh=PMzQW+FDJGazbMnbFTh0Y9SxTylhab6gChYlYp6QBF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ib4GMeGkXQVyNPNF8nFEB4z6RjgePKkn3K5/HyBGJaxazX7WWyFSHfWRNLoFCJWA5
	 6t1fS16SSd7wQwQXQu+o6ccYHe744AUEOe4MQZ+FlCL3Tpw7gqVoEylbaFcHOavffi
	 tnCnrQvPR1Z33/YRPWwTEUm66Bg41bofTmS0dAbK+qUtJhpt7rxMqs6LQjDTstZuIQ
	 q4SOwpfVn90fO5mm0bQsJVF/nwxULybr2OgP0Y1vedEBnoNmE4CDYNcq43hgju/PBW
	 oWGuu2VbZVzS+jjkckvb9rWW1uWfYseomrrGtmEHYPoScleTHqQ3pBw8VCd+DKjt9u
	 vyeoUyRqClPjw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 07/27] ACPICA: Add LVR to acrestyp.h
Date: Wed, 27 May 2026 19:55:57 +0200
Message-ID: <2354060.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Akhil R <akhilrajeev@nvidia.com>

Add a new field called lvr to struct acpi_resource_i2c_serialbus.

Link: https://github.com/acpica/acpica/commit/e62e74baf7e0
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acrestyp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 842f932e2c2b..38a19b1d19ac 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -423,6 +423,7 @@ struct acpi_resource_i2c_serialbus {
 	ACPI_RESOURCE_SERIAL_COMMON u8 access_mode;
 	u16 slave_address;
 	u32 connection_speed;
+	u8 lvr;
 };
 
 /* Values for access_mode field above */
-- 
2.51.0




