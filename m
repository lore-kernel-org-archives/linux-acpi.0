Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E1477992;
	Wed, 27 May 2026 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905527; cv=none; b=C2DjFFyo5/Uw1SLc+rJ19gb1mqdHrX15OUc0SzCWd3w7JWqlG/Qwdn3NVQoM13oy/XAOOwpc60MEvx7ht5WapyWSxnx6jchIb57Ly4EDyx2j39+hsr6eXYAZGtW6NXLLJm7C0/zN/U69m8B0MTTZ71fQyBdo4aYy8LDNXwhMw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905527; c=relaxed/simple;
	bh=ADKBO5c/csMpevlQautnWdpRQcKbal7py9GsyX5bEHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6mmdrf2Ntm6XOenIN/KGbWwuHN8L20QnbvCMjQTxNoGeyDi6t5kHaxp1k/QgRw8csu7ytt8mnyqEStvNUUiBxjbfa8yi4GRDTl7ZEGC01UUWzxkNHRz2i0MMfyNcC8OZOdN8VpYfDL6zrkT8HtnfG9Or1qQeelFo+dijJpP8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxjUDw69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxjUDw69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E061F00A3F;
	Wed, 27 May 2026 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905525;
	bh=z/Gcq7BYFOUy62R6iD7QB9+DemunDUL5N14sP7jwWa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fxjUDw69KozMio+UaBIs/zSnYiZCXYOkNlp23dPIf/9yeaXZIuVR8fLtHuu6tDshR
	 nTcOOp0I9MWzsBIZltInqCxaM0qbDER29s3knXEruPVssW/ffLRtovTvNAb4ttq1W4
	 h372zS/50KFnLaiq9iZtsHSyHf8LNvWjOeTibt8aUeJu65NHoN1uFA5891KJGHXjRV
	 fZWmEi6mRPmukda6H2SrGyUfnH+R1XhQYBM76JVSWmZHmPwpzrUGdiDcBGXijbWMDw
	 0pyok38ouUUdHHC/ASH/03MxwliRCkImHvPOyfHDMT3KKozgFeq2wIxPwMpFBebu4W
	 o5Ja5PUkx/2GA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 16/27] ACPICA: Fix integer overflow in acpi_ex_opcode_3A_1T_1R()
 (mid_op)
Date: Wed, 27 May 2026 20:02:06 +0200
Message-ID: <3760974.R56niFO833@rafael.j.wysocki>
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

From: ikaros <void0red@gmail.com>

Add overflow check for Index + Length to prevent integer overflow
when calculating the truncation length. This prevents negative
size parameter being passed to memcpy().

Link: https://github.com/acpica/acpica/commit/d281ec1ac84e
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/exoparg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 2fc8070814e3..2790bf1a12e7 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -159,7 +159,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 		/* Truncate request if larger than the actual String/Buffer */
 
-		else if ((index + length) > operand[0]->string.length) {
+		else if ((index + length) > operand[0]->string.length || (index + length) < index) {	/* Check for overflow */
 			length =
 			    (acpi_size)operand[0]->string.length -
 			    (acpi_size)index;
-- 
2.51.0




