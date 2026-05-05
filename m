Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900B3CC9F6;
	Tue,  5 May 2026 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011090; cv=none; b=Wh93UdMOicj7Rjpj8H+52QbSkAV+nWL/Thq+ugT2t+yvzjxp0LidReRnqvNNQ/rEgEqi4sxAihziiDV1Ty437fi36iIWcsrkZw+U0Fsm0ZKJkAVYIGdHtrdkitYmzWfRaQrMTc1zjuOfilP8jCRhEC8hye0MPVDUFv8WiHCE3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011090; c=relaxed/simple;
	bh=W35jp3biyC/4M1gGUsqXaJV7TzLzXnjHGt9kg58DRgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CUBz24jwNiywmNAoSYEUXbO7IhXI53bLi7kkx8ItuKYRwLuXLbMxVJDA2DjGAHQbdU9Q/h8//29j/Hz0Uu5fagmfureCCfbTWozDlXSe/zwKtER0KVbjaSIh401QoRRXUPmQnBzQF/K3cjGAGrSLmpdvTAOzoQFs3rMA2eVB+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcaDx0FM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcaDx0FM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6F1C2BCC7;
	Tue,  5 May 2026 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778011089;
	bh=W35jp3biyC/4M1gGUsqXaJV7TzLzXnjHGt9kg58DRgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QcaDx0FMqLlc6iPx8AsHb8msnT8tv7l82kZ2wMuIxS725ruXkCWQa7lla4brnDN+A
	 qBIqFuOK1nkBDGy4BZaPYVnof9zYrxYav4xzusCyDeaapZR+FGAX8+IObQQrldg7MT
	 OS2sSb7wNREHqg/bJKy0OKvBod7Sun4yV3SA7HYwVkX4iHojA5WY52pPJhkmaJL9Kr
	 luMT83FCuRpPJjsLx+B6ZLXB0CPEaUCvyCgjmkjbddOx7u1xN2bBCmS6Dr7m5CUhsb
	 mWHiUNQJ8ZhN6Zn8Jf+NlaOK0UQV17oGcfd3to43MXPDLJ2RmWlRquPQK06ERgwuuS
	 eSWm5QLwEQeuw==
From: Thomas Gleixner <tglx@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Sunil V L
 <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 2/2] irqchip/gic-v5: Add IWB to ACPI probe dependency
 control
In-Reply-To: <20260505-gic-v5-acpi-iwb-probe-deferral-v1-2-b37b85998362@kernel.org>
References: <20260505-gic-v5-acpi-iwb-probe-deferral-v1-0-b37b85998362@kernel.org>
 <20260505-gic-v5-acpi-iwb-probe-deferral-v1-2-b37b85998362@kernel.org>
Date: Tue, 05 May 2026 21:58:05 +0200
Message-ID: <875x51y6gi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 05 2026 at 10:48, Lorenzo Pieralisi wrote:
> On Arm GICv5 systems, wired IRQs routed to an IWB may require resolving

S/IRQs/interrupts/g

Changelogs are prose and not an acronym dump ground.

>  drivers/acpi/arm64/iort.c        | 22 +++++++++++++++++++---
>  drivers/acpi/scan.c              |  1 +
>  drivers/irqchip/irq-gic-v5-iwb.c |  5 +++++
>  drivers/irqchip/irq-gic-v5.c     | 13 +++++++++++--
>  include/linux/acpi_iort.h        |  3 ++-

I'm confused about the conglomerate of files affected by an irqchip
change...

Thanks,

        tglx
