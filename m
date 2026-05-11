Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA33EB7F0
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507082; cv=none; b=oKJ+/7UIDNpVl8/wPvojEfJlPG2ZXVdsj1s/5dq/okgwpyxjrKQo33ZrdrKeLeEJ+bDOCiPM7jKBLoTE1FUwTQQ8cjZ7p+ycoCqaHfppnPT2whxreKvOd4sVnG/NkAg2mtCplwT/kqCgs1NIdePt8f6gZs1R7WOTpMcRm3h45J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507082; c=relaxed/simple;
	bh=TGo8jl/rBevGbdt8gQCYDmDdjx0KgSjv0sIYnti7bp4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fTatzbvGk2Ok9CBa7EPwtHq2/ppTVXuQX2lpoI5RA/tzUl/LGlettMcqQn1tZfZMxTpL9+9Ft338ug3hZ6AoYPSQTo2GWcTlhAkOd1vMR+nXREVnLodeMMa1alw6xMPdqHKCnUkEh/74kpAnTGM57mjaVx37Nw19KzUXZQt2EYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6r/Irwl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6r/Irwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C0AC2BCB0;
	Mon, 11 May 2026 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507082;
	bh=TGo8jl/rBevGbdt8gQCYDmDdjx0KgSjv0sIYnti7bp4=;
	h=Date:From:To:Cc:Subject:From;
	b=l6r/IrwlgynoX4q4Ct6GGzmkplXJSHusFhox8RShrmOBqmvD+gfPjDaB4sLSV5VP3
	 XDTENFOl77HDREGWCmabCiVhkHhPOpGpp4mkhAOD6y15BTtlrnBBSmn1AoHmYwPZjS
	 R9Mkhk2TVbWyEEeEfJBOyYDDwWodFz++Y0kHLHQvOHHW/fHDCQ6txDM5IYb/x6Y7AO
	 v/IjyRo+xZ8jN4beO7ivUv09i46bAPzW/FxTPoYCNgPm0Ldis8LUr03xCuvjUHl1KG
	 bplMhgndL8uMi3zhtQxuE7vjpFn9pH4Dk7bgb46C7gk0AYv0w4+9DoxGClwXNuVwkM
	 Z5DSpcAQitevQ==
Date: Mon, 11 May 2026 15:44:37 +0200
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: uswg@uefi.org
Cc: taoxiaofei@huawei.com, Mauro Carvalho Chehab <m.chehab@huawei.com>,
 linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 qemu-arm@nongnu.org
Subject: troubles with ARM processor type changes on UEFI 2.11
Message-ID: <20260511154437.4de20cea@foz.lan>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I maintain ACPI HEST support on QEMU and I'm one of the Linux kernel reviewers
for the RAS subsystem. I'm also the author and maintainer of Linux rasdaemon,
responsible to handle RAS reports (including from GHES) on Linux.

There is an incompatible change at UEFI 2.11 spec at Section N.2.4.4.1,
which, according with UEFI 2.11 changelog, it is related to this issue:

	2462 - Fix the Type mnemonic description in the ARM Processor Error Information Structure

This is the second time the specs changed the meaning of the type field
inside the ARM processor error info:

- Before UEFI 2.9A, the spec has a list of values for error type. 
  From the specs, type, at offset 4 was described as:
    
            - Cache error
            - TLB Error
            - Bus Error
            - Micro-architectural Error
            All other values are reserved
    
    Yet, there was no information about how this would be encoded.
    
- UEFI 2.9A defined the actual expected values as:
    
            - Bit 1 - Cache Error
            - Bit 2 - TLB Error
            - Bit 3 - Bus Error
            - Bit 4 - Micro-architectural Error
            All other values are reserved

    However, even being an incompatible change, the spec didn't change
    version field at Section N.2.4.4.1.

   Linux, QEMU, rasdaemon and likely several BIOS implementations
   were updated accordingly.

- UEFI 2.11 changed the definition to:

            - Bit 0 - Cache Error
            - Bit 1 - TLB Error
            - Bit 2 - Bus Error
            - Bit 3 - Micro-architectural Error
            All other values are reserved

  Again, another incompatible change and without changing the version
  field at Section N.2.4.4.1.

With the current mess, it is impossible for the OSPM (and RAS apps) to
properly map ARM processor error types, as for instance, type=2 can
mean:

	- Bus error (up to UEFI 2.9)
	- Cache error (UEFI 2.9A and UEFI 2.10)
	- TLB error (UEFI 2.11)

Please issue an errata incrementing version number, to allow OSPM
QEMU and rasdaemon to properly interpret this field.

Thanks,
Mauro
