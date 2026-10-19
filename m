Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421678;
	b=zK9TZKZCq03HLrDEuRoDYnCe23pJ7MYH9x5fHSYygPsGQbypoBLgbRF4Qr6M2p1iayZZ
	 J6FdSoS+S663ft612f3zjzbeQbCpIqN3blODBXG6KJiJgryPj5R0yMLkap6G6f/0ApckH
	 rajD//iIfRjumJ2IQrmt/e6Eg846lcqRjTZENLh2sjuDHTYqsm+OtUKfvqgCvqCMINmOE
	 dsPHxLTwOX/Le66AlbaBJ20D61B2hRFXLAJiPsCniUBrIfnsiL1bYtbG/TB0/QLPCs/am
	 jyHizuQlTisMBq4ydFdH/QLiI31vC1AGbYoV7e48AHJwMeLaBLyBG/nmW7Ar840C34A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421678;
	h=Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Bar:X-Rspamd-Report:X-Rspamd-Score:
	 DKIM-Signature;
	bh=xOumFf8QovRxhD1eGGAGpu54ZcAWxs2MC729deNVVtU=;
	b=l7JeS3KSkJO9NwYAu6yE5qzLujC0xsIlS7jvBLJiokMO8wiB72ngqTQNEZpDxBw9kxX8
	 BRqtI8z21OB0skxLentWqZxp2bO8xB+1GqiOLHk7kPv7fM0cXE/0fYm/27CH8jXrtx//r
	 zP9rgVz93jWPhoKioHaqA3+C3FisK8MxxeCjxg+10ufuiWLtEIPm0p0SEYwfd2CfyY7mp
	 VYEKwBDTDXNo6YnvrLy8VA06eF0Huybu1jlSqxOyiNN5MNBZaYJi+5nY/Xy8F+uKQpQEh
	 ggxu3joqR/uM1jipTsjeAQ1QY9fuALoiS6/U3oApXTOecmazLYgxnX9wkbQNI8T0onw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=G34Zwobk;
	dmarc=pass header.from=lausen.nl;
	spf=pass smtp.mailfrom=lausen.nl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD4606DA76
	for <linux-acpi.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=G34Zwobk
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17634C8461
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421678; cv=none; b=lgikfT6EbBVKOUslH+dlp+gnpuNcZWUQlvMdqYCsDRV+0o/FW+wFpRZ7EfurpuTzR7Zg5DXtYSknGSP+HQY8l1zjsI7aUGCDmjkJCpJkjIPGLj7SW9nQnn89HIVhXjB45+QsPOT4gTEEBGY0By+DptNmE75YAipoQXj1bazH9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421678; c=relaxed/simple;
	bh=Hipy/KE3TsEelU94kP3nCg+Z58+mCcvF4l6Qeuvkmms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EO09gdI20sJDNtCctVxH1mNhisFEfbMIiM+2Z2vOGNSsL957hM7Vhd+jaZ6JOegCt8dTEs/SYnikEzDaBHf5E6MnUPLAuqjwJqjVT/wTtUeNVfy0oAwiqRPORALAxQUTkC9YQ61dWO7p5VhJrxCyXvqV9hsdOfG4rcpe3diY4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=G34Zwobk; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 3EB1761147
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 16:54:35 +0200 (CEST)
Received: (qmail 28350 invoked by uid 990); 19 Oct 2026 14:54:35 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Mon, 19 Oct 2026 16:54:34 +0200
From: Leonard Lausen <leonard@lausen.nl>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: leonard@lausen.nl,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	acpica-devel@lists.linux.dev,
	Len Brown <lenb@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Ivan Hu <ivan.hu@canonical.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ACPICA: Initialize ParserState.AmlEnd in AcpiInstallMethod
Date: Mon, 19 Oct 2026 16:54:17 +0200
Message-ID: <20261019145421.47181-2-leonard@lausen.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019145421.47181-1-leonard@lausen.nl>
References: <20261019145421.47181-1-leonard@lausen.nl>
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
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.97699) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.57699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=Hipy/KE3TsEelU94kP3nCg+Z58+mCcvF4l6Qeuvkmms=;
	b=G34Zwobk7+jTQBscFXiVl0wGO6Tg694XtvV7EdCgNByMswpXAAHkC/NWoS2OHCCmmc4Wx9aC08
	f9GuU5l6gfqtWFwQ/elECYEZhu1HPdedLFG/2IeOv0gmoTaz/n76FjaNvQbblViulMw+UOVgzcRz
	20ndPfGyGVhYSuYRc/QmLtVRwr3ZZZnSYHsjedOTyC6LnyUu5eEtkWtSEND+7ZOe+omi6z7KIooQ
	wroZrKtbzgISr/hCm7jRhUhIV1R9KfsO16VzW69N48yJlIkCWuM/61tte2qrzzEdkVtoxDwurYok
	w1alnWRJN1rAqFA3JJGyzK5G5CgpoTMugQnarBVGA+uIdYlKL1K6Uz2LqiFxAZtgw0IcruSiW669
	4An0xXHOJb8/W9hTbNYzlNCNLuLfdaKUstzBI03uSKQJ3Y+XSMw1Hd/2/vPnjLmbOQQNZpGfTrrh
	s+qkcFWI9mIqZmk9Smxjc578MaAHK2c5ikFCUhmEuQa1YXVZsX52pNCHvz8SMwGX47oWWhXmJl6F
	uf3WoBUzgjhXqt1pdehm0q0TyAZVuZaexC/4VZq/idZ7tcvgH1TLaIH/HsfyYoR0495PxzyyvTrE
	9oep4yW+QlozYICzBmA84E4GO20dkv9dJQSw2kE+56GZ3Ra8XLmUnHkcch3gSOxSi/Guu6+KbAAm
	8=

From: Ivan Hu <ivan.hu@canonical.com>

In AcpiInstallMethod(), the local ParserState is stack-allocated and
only ParserState.Aml was initialized. Parser helpers called by this path
read ParserState.AmlEnd for bounds checking: AcpiPsPeekOpcode() reads it
before validating the first AML opcode, and AcpiPsGetNextPackageEnd()
reads it indirectly via AcpiPsGetNextPackageLength(). The subsequent
package-limit check also compares against ParserState.AmlEnd. Because
AmlEnd was never set, these checks operated on an uninitialized value,
which Coverity flagged as an uninitialized read (CID 1684785) and which
could lead to incorrect parser bounds decisions.

Coverity report:

*** CID 1684785:         Memory - illegal accesses  (UNINIT)
/src/acpica/source/components/namespace/nsxfname.c: 712             in AcpiInstallMethod()
        ParserState.Aml += AcpiPsGetOpcodeSize (Opcode);
>>>     CID 1684785:         Memory - illegal accesses  (UNINIT)
>>>     Using uninitialized value "ParserState.AmlEnd" when calling
        "AcpiPsGetNextPackageEnd".
        ParserState.PkgEnd = AcpiPsGetNextPackageEnd (&ParserState);

Initialize ParserState.AmlEnd to the end of the table
(Buffer + Table->Length) so the parser bounds checks operate on a valid
limit.

Link: https://github.com/open-acpica/acpica/commit/19429ef91ebfb2144c918038dce13e297b4ef051
Fixes: bdc357540129 ("ACPICA: add boundary checks in two places")
Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Leonard Lausen <leonard@lausen.nl>
---
 drivers/acpi/acpica/nsxfname.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index b6534187cd43..fcd94947fedb 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -503,6 +503,7 @@ acpi_status acpi_install_method(u8 *buffer)
 	/* First AML opcode in the table must be a control method */
 
 	parser_state.aml = buffer + sizeof(struct acpi_table_header);
+	parser_state.aml_end = buffer + table->length;
 	opcode = acpi_ps_peek_opcode(&parser_state);
 	if (opcode != AML_METHOD_OP) {
 		return (AE_BAD_PARAMETER);
-- 
2.55.0

