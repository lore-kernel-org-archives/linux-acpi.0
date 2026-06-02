Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390133932F0;
	Tue,  2 Jun 2026 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401593; cv=none; b=C113s80GmOPHlSRBQRSvDVuIdqi5eH1SdEgVXg1QUer74XOpsEuJjnn5Yt9AtnTdvhZJenYme/wwr/3AaY4v5dJ2lX7g/nsZVw3jN8JWxqilXG9CJfrs1dtUTncK1u6VFfbL3Nvxsu1AFJKLj3rIMF8sIlk0qexUPcdycmiQdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401593; c=relaxed/simple;
	bh=iihS76pELFI1Zlmp+9BRb0EqjBpmoJJVeHDLrNZPKt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2bg3flyaML48W9lS/Oszg1CkUZ2/8cK+RjkDacXPBDjHOe66sJw16jQfKiU9sz4GYoyiWjJfmGYn4vmqXCFmkPepjZSZvbIG3lFqfyz9L4cmojEl0ThiMkkHODlDNDFpXpZXV4JQbP1kX9hhJl5vXA3I7D4FZEoTWUfAJCcw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=MR+Ewoy+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="MR+Ewoy+"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 85DED271CC;
	Tue,  2 Jun 2026 13:59:50 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQIekQ0zCLPk; Tue,  2 Jun 2026 13:59:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780401590; bh=iihS76pELFI1Zlmp+9BRb0EqjBpmoJJVeHDLrNZPKt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MR+Ewoy+k2gdX8kgoId72iwDQUu1Qs2SE5ayeBN3UnaOdJIm/dp+qlTrniR7RgMya
	 e7DwVdBa/9Ec++zrA2CdX1lSeVZl/mJnzHnX2AllRLCq6VOE6STTIBxowtJabuVE1X
	 yvd4eFB3bTXhDGh3daq4ZObXNYKkJ1Jvq8FNdHobcNQcy77N952oy9TTIeYlo9WhmP
	 9vUSZitmNwgHbIZIDqc2GV3PMzphwbOTEDGea2lxu28j4gH29U4xrgeFy6r5bi6g7i
	 TpAzO7uaSCEo715Iv4it2W39Ey5iX82kYtCXZXlW6GK6rqhosJwp3x62tyHXY01fDK
	 b56XJzESZLt0A==
From: Marco Scardovi <scardracs@disroot.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: andriy.shevchenko@linux.intel.com, brgl@kernel.org, linusw@kernel.org,
 linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v5] gpiolib: acpi: prevent address truncation in OperationRegion
 handler
Date: Tue, 02 Jun 2026 13:59:36 +0200
Message-ID: <vzcrnFOfR861L-H21KjtDQ@disroot.org>
In-Reply-To: <20260602114540.GB2990@black.igk.intel.com>
References:
 <20260602113529.52570-1-scardracs@disroot.org>
 <20260602113529.52570-3-scardracs@disroot.org>
 <20260602114540.GB2990@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Mika,

On Tue, Jun 02, 2026 at 01:45:40PM +0200, Mika Westerberg wrote:
> How in practice this can be done given that the GPIO resource has only 2
> bytes for the index?

The 2-byte limitation is in the GPIO resource descriptor representation of the 
pin table, not in the ACPI address space handler interface itself.

The acpi_gpio_adr_space_handler() receives the access offset as a 64-bit 
acpi_physical_address from ACPICA. This value is generated when AML
accesses a Field within the GPIO OperationRegion, and it is not constrained
by the GPIO resource descriptor's pin_table_length.

This is not GPIO-specific in ACPICA terms: all address space handlers
receive a raw 64-bit address, and any semantic interpretation (such as
treating it as a GPIO pin index) is done by the individual handler.

In the GPIO case, the driver maps this address directly to an index into
agpio->pin_table[]. Without validating the full 64-bit value against
pin_table_length before truncating to u16, an out-of-bounds access can
occur due to wraparound.

The fix ensures the 64-bit address is validated against the table size
before any narrowing conversion, avoiding the wraparound and
rejecting invalid AML accesses.

Marco


