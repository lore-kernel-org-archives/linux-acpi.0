Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83A47F2D3;
	Wed, 27 May 2026 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905558; cv=none; b=PKNw2KIGKzvtkiWoaDBJjSelBy0+Cx8Aqn3W7eeaUrXC+mNRdopgK/vLBkrGZXqbXz79EniJkGqW84y5uqNYJ0jchEyGnt+tNO385629wc6Tepf9smHFpIZpJlDgGbCskyxVhg4rBV5ARE38EfHchE5IFzhXmjJZJHkKFSnkVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905558; c=relaxed/simple;
	bh=Rk02Y4AH8ONUC+sz+51YMIRhdX29oDSIWxszpfhKDFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7NEYn+yrxaE29wmERw53s59Id9EUm0eV1TTyJWoIHpePDfJ/BuQRU9QGdUfTkS7Y7Lx4VWx4dfxIWjNJbWJ/tWyfFc+CFyLM2vc6FH3p+QJsu21gi4IUELOHaA7KrKGXXM64uckIQp55sEfw03GqGN+tR5H+BEJEHIj0EZWfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILHu/SFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILHu/SFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350D61F000E9;
	Wed, 27 May 2026 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905557;
	bh=iQ+mWYHw1OA5NXT3OcdWZlR/gUmP7gQxrIETwyFJrdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ILHu/SFgFvHl8wbi1Qbs9eExNh5vggkhmg4vQW95yo5yRhm3X8g23cotuIliXXyDn
	 EFAtGxUg/WHZK4rgqqhfcRb7yjAQFuq0ayZNnGeaXykAaQqtg11WZg83K3j3T8dEm3
	 U6tmhCpAlYea3LUEwgmrEYMwpQssnOCmE84pQbXynTGmPThGUHyL8jpUgZd4aJ1oY/
	 t81mi6dKTddn1Z2cN6NJz9TbYRWeS2TgYREaS0dPixUQ1xZsUJIDaOz+0Xo0mXCRGN
	 5zEPNBfVl9omW5Fhc3A2ogF07oQHlOcSyYDPsqdH8JoajAztfELnmddOUx4IMBrqn0
	 b/LnevhmBINRQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 06/27] ACPICA: Fix FADT 32/64X length mismatch warning
Date: Wed, 27 May 2026 19:55:21 +0200
Message-ID: <8688362.T7Z3S40VBb@rafael.j.wysocki>
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

From: Abdelkader Boudih <oss@seuros.com>

When the 64-bit address is set but bit_width is 0, the spec says
the legacy length should be used. That is valid firmware.

Skip the warning if bit_width is 0.

This avoids false warnings like:
  32/64X length mismatch in FADT/gpe0_block: 128/0

Tested on free_BSD 16.0-CURRENT.

Link: https://github.com/acpica/acpica/commit/b6387a387c51
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/tbfadt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index c6658b2f3027..80d3a39a82d7 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -553,8 +553,11 @@ static void acpi_tb_convert_fadt(void)
 				 * Note: If the legacy length field is > 0xFF bits, ignore
 				 * this check. (GPE registers can be larger than the
 				 * 64-bit GAS structure can accommodate, 0xFF bits).
+				 * Also skip if bit_width is 0, indicating the 64-bit field
+				 * was not populated - legacy length will be used instead.
 				 */
 				if ((ACPI_MUL_8(length) <= ACPI_UINT8_MAX) &&
+				    (address64->bit_width != 0) &&
 				    (address64->bit_width !=
 				     ACPI_MUL_8(length))) {
 					ACPI_BIOS_WARNING((AE_INFO,
-- 
2.51.0




