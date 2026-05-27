Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3C43DA5E;
	Wed, 27 May 2026 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905505; cv=none; b=tk2eS5brGQzbEhMFYPB5VumIl8X758ITEQgdHG/KtQDOSZ1/TZdBWPbnqIE3OilwBzzgD/LuGnXe+2gIyRQIUwxGQaOyqxSUgoRN7H4RDKokJszo6YrmuH6q9gygP+G+Oj4Ay3jMEJwBqyNIIsvjg6IPaMBdvcf7TEmp8Rd4euQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905505; c=relaxed/simple;
	bh=BtSI/hdeiK68BiH/bZXTzjfwB/Rv1JAywxKp85/pUfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiyyM0xLYipH8oxnbAwgIBVvlDFU0n8TGDsteqqmijpAjPJG7PYpJRMudnq9QLZ+FmTa+Pt1Ma7mWm2kvNVCM5dn4igWMsTqXIyNzwtfEXJSRdeze4POpZyitJWi3rZ76UOwDAJvjdkfQOr0sJ7vGN3+uDmfG5ynsk2GxOSZGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA4aiHWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA4aiHWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED941F00A3D;
	Wed, 27 May 2026 18:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905503;
	bh=Hei7QFBonY43HpmTJh8Pq+FKBM9FcU4y8qQUvJFRSNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fA4aiHWzRdPCZZlYnvyd1PzIw2Jt+ceKJVt06sywdkgpbNQua8U8mQyceIz0AnMTu
	 VNsPClj4r6HoUcH80Twe+2WCqtwE8mranagVioFht94Ji+F1NNrPQ1MvxVhVg+YbqE
	 KLR1M59jrR3YnrlTwDjRkESmM4pPy0/iFK5eP2V4qIGndkgttcA5EYOrqtOEJqTBzt
	 0VomSu4iYOeMBPW8MX2m3ECpYRHz2nVCE5xQ7zNr3Wg2KH4rh2rjqVxRlhH10vr6Ok
	 fIznmwm9/aO3YA9k97KM0NfKyUOkyvDmnSdFZnjfIGTz24/pxCdwb11KAoBINdtc5d
	 IhucSFvPjDbGw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 23/27] ACPICA: Remove spurious precision from format used to dump
 parse trees
Date: Wed, 27 May 2026 20:07:08 +0200
Message-ID: <2914242.BEx9A2HvPv@rafael.j.wysocki>
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

From: David Laight <david.laight.linux@gmail.com>

The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level * 4, " ")
to indent traces.

POSIX requires the empty precision be treated as zero, but the kernel treats
is as 'no precision specified'.

Change to ("%*s", level * 4, "") since there is additional whitespace and no
reason to indent by one space when level is zero.

Link: https://github.com/acpica/acpica/commit/a87038098af6
Signed-off-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/pswalk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index 2f3ebcd8aebe..a6a6e969e498 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -49,8 +49,8 @@ void acpi_ps_delete_parse_tree(union acpi_parse_object *subtree_root)
 
 				/* This debug option will print the entire parse tree */
 
-				acpi_os_printf("      %*.s%s %p", (level * 4),
-					       " ",
+				acpi_os_printf("      %*s%s %p", (level * 4),
+					       "",
 					       acpi_ps_get_opcode_name(op->
 								       common.
 								       aml_opcode),
-- 
2.51.0




