Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8576375F6C;
	Wed,  8 Jul 2026 02:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478529; cv=none; b=MRX3wWTvS5pruvAKP+6GhMq8JUjIT2Rpn2NJaib4TXiMbgvqwc8XF2H+6wLoH+d3YSzEHhX310ffT8oVN8xGjooGbaWe8Q8iWFlCtrL/VGXEsdNIJDprsqsuCc0xh/7dvt5bdDdL7u+ToUXp22P4LnYoqJMCpPTHmmFVyylvx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478529; c=relaxed/simple;
	bh=kkRt6IRLDiIp2g3XjrX6hjlZN+MfG6oSxTDsYbnzZrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsIXS9jp61TLLfNn8Kdq9Hk0nq3oW6a002vq9DmZdjRDw/9bgjCEhFZ7kYD625a1qB3DhYY6yoMoeetiYStYD6iq8xb0hlB+TXpFrN3BdgnFWHiPKiCVDTwhLGVo1RXJbjZcg6PHlLxCSNAvFPBgapUOBHQqMJzZ3m4Fqbtwzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ws9sWML2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ws9sWML2"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 42DA040E016E;
	Wed,  8 Jul 2026 02:42:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 41QuxmgCLtQY; Wed,  8 Jul 2026 02:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783478514; bh=9hXBvMjTwymyUvCvSreGUZBFX4rEGzicOQzp4XIztm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ws9sWML2zHDjcRXq0gCKTHLTcpqkKpbWB58VTH7TYqpHIKYRh7zLWxewIBrAbo82m
	 JpoTT06YX+xY8kuGrnuWxKPbUmItAsXpDugALD739OogDX6yY8pgO4dy/Qr4loP/9p
	 wyMhfFNn8XdspQDR/XXKtGu4P2uhRIuPX3fdKps6n0IPlivofaz8IhenKZeyBWTD+e
	 +Q1nBWYaBEa6KU6Fp3wgY4urFwq2nO/7yNqY2D1c0KE+Q6WSkykyXG/uoLpXYbxTIS
	 S5ttEB7RBVwYfGErb/BNX3HsM5zznneqS2+oXaPjOjWwLLbDctOJORErWHZwxK4UvR
	 FKtlhqR/fQylyLuqzSqUG3cmSX68eqoRrOEeZ0QJsVUXv+eKBcnLGn+cfOfgYmK39J
	 rWqs2eif5nHOupvyBUKaY5TZDdHAD9bTd6KjM7FFgi1ahferVcPki26i3YoNfgQhuW
	 NyOoqKyLNRc4M93I7OJhBNwHfovX3TAarQttuLuJ0CtLhpMTXUIaLNtwULNuybRz/N
	 qwa8+yXoulZsdi+3xzuTWHeI3UyGDC1wiBM3enb5DZ9sG/CPA3u+S90RfBkfdWlpoc
	 /Ttd3Wxhcbg6Suot/dOOupv1++p3zuYpUa2vTKLgb2XNljhDdIcRhoc7ceGiX8eoUf
	 eleB4cOJdWATBzvDKHkbtILo=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79EA240E0163;
	Wed,  8 Jul 2026 02:41:34 +0000 (UTC)
Date: Tue, 7 Jul 2026 19:41:31 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	zhuo.song@linux.alibaba.com, oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v7 00/16] Support Armv8 RAS Extensions for Kernel-first
 error handling
Message-ID: <20260708024131.GCak242z-9YE2xL6q0@fat_crate.local>
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>

Just some superficial notes on this before we delve deep...

On Tue, Jun 02, 2026 at 03:15:23PM +0800, Ruidong Tian wrote:
>  Documentation/ABI/testing/debugfs-arm64-ras |   87 ++
>  MAINTAINERS                                 |   11 +
>  arch/arm64/include/asm/ras.h                |   99 ++
>  drivers/acpi/arm64/Kconfig                  |   10 +
>  drivers/acpi/arm64/Makefile                 |    1 +
>  drivers/acpi/arm64/aest.c                   |  423 ++++++++
>  drivers/ras/Kconfig                         |    1 +
>  drivers/ras/Makefile                        |    1 +
>  drivers/ras/arm64/Kconfig                   |   16 +
>  drivers/ras/arm64/Makefile                  |    9 +
>  drivers/ras/arm64/ras-cmn.c                 |  479 +++++++++
>  drivers/ras/arm64/ras-core.c                | 1026 +++++++++++++++++++
>  drivers/ras/arm64/ras-inject.c              |  130 +++
>  drivers/ras/arm64/ras-storm.c               |  198 ++++
>  drivers/ras/arm64/ras-sysfs.c               |  319 ++++++
>  drivers/ras/arm64/ras.h                     |  374 +++++++
>  drivers/ras/debugfs.c                       |    3 +-
>  drivers/ras/ras.c                           |    3 +
>  include/linux/acpi_aest.h                   |   36 +
>  include/linux/cpuhotplug.h                  |    1 +
>  include/linux/ras.h                         |   10 +
>  include/ras/ras_event.h                     |   79 ++
>  22 files changed, 3315 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-arm64-ras
>  create mode 100644 arch/arm64/include/asm/ras.h
>  create mode 100644 drivers/acpi/arm64/aest.c
>  create mode 100644 drivers/ras/arm64/Kconfig
>  create mode 100644 drivers/ras/arm64/Makefile
>  create mode 100644 drivers/ras/arm64/ras-cmn.c
>  create mode 100644 drivers/ras/arm64/ras-core.c
>  create mode 100644 drivers/ras/arm64/ras-inject.c
>  create mode 100644 drivers/ras/arm64/ras-storm.c
>  create mode 100644 drivers/ras/arm64/ras-sysfs.c

People have got to start naming their files properly. I see this everywhere in
the tree: there's "ras" in your path and then you add a "ras-" before each .c
file name.

Do not do that.

But this is not that important - what's more important is exporting generic
interfaces which are ARM64-specific. Like in patch 11. That can't work.

But that's still not that important - what is even more important is who from
ARM is going to review and maintain this? I can take a look at the generic
bits so that the RAS stuff coexists fine in drivers/ras/ but I'd need an ARM
person to take care of this.

There are enough on Cc so let's see if anyone moves.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
