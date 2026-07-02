Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2E38E8A0;
	Thu,  2 Jul 2026 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029350; cv=none; b=IA47KfRYkYOmq5AriCq4nQFKD4onnymHz9654hPszkAmwuEoLytAOooQ1VFyFNpDe+x2X4c4sVPfW0h2Y6OvjIF7RvQMr9pALyEhxDkBYrpeJMox/ra/eYIiLWYxBY6O1NLNwR7tpGa3H4IGt6SCSa2WDn/wD+PKsRsdsmtndTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029350; c=relaxed/simple;
	bh=0zspmW8x8NfjgzmHrmSB3UmdTwxqu95F7yMgPebeJrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZDEjMdHrzbsfdQl0a+d9S5ivIk00go8mXQVShb5ayTzX6NkNyAkvh+Ar643DkEpnBIypJZYyieYZTalWCRFPIc0EmZbTnaaaJcP1OcB8Am7WchxBcfKJyR2/XVgzasZ9iANuN8tGd0VeI5+0RTK97oIbCg7QeRUF1z5flWefJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRpbLabe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRpbLabe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A441F000E9;
	Thu,  2 Jul 2026 21:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783029348;
	bh=0zspmW8x8NfjgzmHrmSB3UmdTwxqu95F7yMgPebeJrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IRpbLabeERee8weUM/6T6duN87T+iRNfQNmjbVOUNAbrYchScx26hK5uaWGIEbgKP
	 FtzvAZNZdQTDNno7w7T+d8BcIxpx5Z6h5wq6aBFkmPvMSgIXOn+CaTszZrHiv6rePW
	 UMpwWSvzlzpdNr6WgmoXtENZzT62dzVwN2HTgf3c6q1BpZAmCTrGyQ+q1IWZRdqW47
	 oIeuRQqDC8EXM+GZxdSZyC7z5an3PE/M9GIQohgu0qZoYri3KBHLv/cSyXbQ/Dso8x
	 YteZfZzoHWSLNoB7RkFy2XsZUWUS8GNsmR4UQJKkOWV5vhcJPslu2vwVP7hQO8WbUV
	 Evp8yulMsGgBA==
From: Thomas Gleixner <tglx@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Sunil V L
 <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 7/7] irqchip/gic-v5: Enable GICv5 IWB ACPI probe
 ordering detection
In-Reply-To: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-7-c5562cf0fe29@kernel.org>
References: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-0-c5562cf0fe29@kernel.org>
 <20260701-gic-v5-acpi-iwb-probe-deferral-v3-7-c5562cf0fe29@kernel.org>
Date: Thu, 02 Jul 2026 23:55:45 +0200
Message-ID: <878q7tnjj2.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 01 2026 at 16:38, Lorenzo Pieralisi wrote:
> Register an ACPI hook in the ACPI interrupt management code for GICv5 to
> retrieve the ACPI interrupt controller handle (if any) of the controller
> handling a specific GSI, by updating the acpi_set_irq_model() call with
> the gic_v5_get_gsi_handle() function pointer parameter.
>
> gicv5_get_gsi_handle() allows ACPI core to detect the ACPI handle
> of the controller that manages a specific GSI interrupt.
>
> Update the IWB driver to clear device dependencies in ACPI core once the
> IWB driver has probed.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>

Assuming this goes through the ACPI tree:

Acked-by: Thomas Gleixner <tglx@kernel.org>
