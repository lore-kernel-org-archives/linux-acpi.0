Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D3272E56;
	Fri, 13 Mar 2026 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407083; cv=none; b=siO5jUXdiD/Fg0d5I9dMMYGabWS19fUsn0ZSGpw4BpNZzElI46D2IYE3WTRLwchJAoe6TolfT95GyFcU0ckoTFpYB/EXW3tZlrS/dP68re472LKsmjLPZjc+92hKBPAGynhpVaxsmdKVCbl1HFCp8NnosADkwJelcBn4Tto3l/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407083; c=relaxed/simple;
	bh=5MFOUPqzLB86odgXpteJJ2wTDPocYBMr4++5kyHrsKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UJmm71N2+j70e/6btELZnB46bMhwH741BCNxoIKSCbUDsFNyfX49Y5k4QWfUutnoJq0lrY/J3sgoybJOrNjrR0IJVV0NJdbgDodA5fi3mWY4O07dA89t38WouFG0xVVx6KUcawSe71WsA/wNLg3i+LFCXj5clu2/cJhB29zjPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLgKLGCM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLgKLGCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B7EC2BC86;
	Fri, 13 Mar 2026 13:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407082;
	bh=5MFOUPqzLB86odgXpteJJ2wTDPocYBMr4++5kyHrsKo=;
	h=From:To:Cc:Subject:Date:From;
	b=RLgKLGCMN+Fl74FymDC0Hd1lYc0RzPn2fBVBe1R4NZoQhzIDM+wYuZ41HZoPxEOg5
	 Wo7ZE0ppDSrcGHxNOzuIkI+22Fk5BvpbUpo34jCcKbwO0tQXA9hgPN/A/743rEGpcU
	 42XAHxvA9iSMUlxXLbQmiCNznch1esdUYnMl0yhgkYf1Va0BduV/eweItliVCyw+mQ
	 q6hGQ9F3vq1Qzcsm92soiX99aHFUTavkDXfsDsTvX1/OWewlyiGq42bUnohf4IW7MK
	 0/tw7ebyfyY8cuWwAYoGPvpHfHmF7Rbcz/uSVTveC7tTJ7LRXrOBFOkBMzDyGWKOK2
	 iQYk3AfFIW7jA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 0/8] ACPI: driver: Cleanups and fixes,
 mostly related to acpi_device_name/class()
Date: Fri, 13 Mar 2026 13:47:38 +0100
Message-ID: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
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

This is an update of

https://lore.kernel.org/linux-acpi/4505861.ejJDZkT8p0@rafael.j.wysocki/

which is posted mostly because the first two patches from the v1 have been
applied and next two ones have had to be rebased on top of a fix that went
into the mainline yesterday.

There is one new patch in this set (patch [1/8]), two patches have been
rebased and reordered with respect to each other (patches [2-3/8]), and
the changelog of the last patch has been updated. There are no substantial
changes relative to the v1 in the other patches.

This series 

 * Cleans up a couple of wonky things in the ACPI video bus driver (patches
   [1-3/8])
 * Updates several drivers to stop setting acpi_device_name() which is not
   used anywhere later (patch [4/8])
 * Adjusts notification APIs to be more consistent and in preparation for
   the next change (patch [5-6/8])
 * Updates several drivers to stop setting acpi_device_class(), which is not
   used anywhere later, and one driver still using it (button) to clear it
   on remove (patch [7/8])
 * Consolidates the ACPI_AC_CLASS definitions (patch [8/8]).

Thanks!



