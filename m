Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B9A3FBEB9;
	Tue, 30 Jun 2026 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816717; cv=none; b=Ws5rVFRzA8af5fVCDfnZVMb7mWPnSTQLD4Pd1MQ2JAg9QhHRqWsOumdbFPDlNaSa806pZJ5QCY4xMbOiKXASQg4TGB6y3esWoNASEi0pDg2IxmbEsUrWXSsL62VpW1OOFvNABkwZjkHCIYKHwtxI8xhNzIM55kR30QGdl4YMNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816717; c=relaxed/simple;
	bh=t3KLlyy/JqupcBXRQMag42bOWd2ihCRnoKD9RX4B6co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDQerDWwykYP8R2v38iIaQtCRvCVlqHFDyUsDWK1Zdp811KOzi7oe5Hcf3mdaW9bcb7NMo4hBFdCszV38RIHYIQd9j09VHG3eJFhxcpoguthvd9CDIj0w2rAORiyMVYppZKvGSFzBfWQ0sUzcBZCBtqUn6IRkX8yIOBHOtcGcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1u/Y2Pf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1u/Y2Pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AA31F00A3A;
	Tue, 30 Jun 2026 10:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816707;
	bh=LSagnXkfjr27HV2tQfAz+rj7AUU5/hzRn7I5KK3CMLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B1u/Y2Pf6zMk7tnbTzi4v6nU2Lv2weLjO53pAUXXJHjaSnLhV3I5y/EU4ZQI2Ms8y
	 s7aCEHs5W1c7/Xqrm428GfYbtuEYXFNpcaZi6NuVn5iPNk8vFMEz4RCD2HVTiSHZic
	 +PbRGt49XhFnG50RlWiHtmRFq97MIDncdkWoc21g8UP9tcviNTjNyN0Cz2Y4R2GxEV
	 F5w5AA+32iv+09J11nDfNsQTIJ3TUdwGbllDMnKejLr9iYGbIcm9lgJEHJC1Lfqp5b
	 3x+g7YwFCe8wuwkIZIzl8vuFrD0OpK1/LuyJfMFn3QUaR/mmPuExwJ8jZIw3x7KL9a
	 2BoQHjkpr8SXQ==
Date: Tue, 30 Jun 2026 12:51:39 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 6/6] irqchip/gic-v5: Enable GICv5 IWB ACPI probe
 ordering detection
Message-ID: <akOfu2EIQq3CJgqw@lpieralisi>
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
 <20260603-gic-v5-acpi-iwb-probe-deferral-v2-6-23ffa16b6ebb@kernel.org>
 <CAJZ5v0ibZKfzJwGyUb92-K1N9C_ab0QujpAKCrvMdyygquS1Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ibZKfzJwGyUb92-K1N9C_ab0QujpAKCrvMdyygquS1Vw@mail.gmail.com>

On Mon, Jun 08, 2026 at 07:18:15PM +0200, Rafael J. Wysocki wrote:

[...]

> > +#ifdef CONFIG_ACPI
> > +       if (has_acpi_companion(&pdev->dev))
> > +               acpi_dev_clear_dependencies(ACPI_COMPANION(&pdev->dev));
> > +#endif
> 
> I would rather add a wrapper for this, along with an empty stub for
> the !CONFIG_ACPI case.

#ifdef CONFIG_ACPI
static inline void acpi_device_clear_dep(struct device *dev)
{
	if (has_acpi_companion(dev))
		acpi_dev_clear_dependencies(ACPI_COMPANION(dev));

}
#else
static inline void acpi_device_clear_dep(struct device *dev) {}
#endif

Something like that ?

Thanks,
Lorenzo
