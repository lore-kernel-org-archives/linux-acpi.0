Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDA3806CE;
	Tue, 14 Apr 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159844; cv=none; b=q7M2ln3Xs7FWzfDeyYtbO/TcSebqqI2IVvyU83AbWlPMHq7Ih5+udfebxSpSh8HF1zyHjLnRUc17VSs1Mrh+StkGJC4AMZGA10hbNIr4OqeuJ6EVrfoy3jx7TWVp1l7FZGV14kzuuk3MFjjWrhibSBa1y0BuaXW1V8lAVyujfIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159844; c=relaxed/simple;
	bh=cHSJucNdTc0PQ9evnVPXr9OCkLmwJA+tG+TO4Q5bdAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ptzPBH+QHbUbLY8UUht7/N98UpKqfwCV+uuAPXblYY385LzZmXb9z512ps3E4j6RHFrwVHqq/QfqU+V1ZmrgRbKOWUwPm5XOQ3Vtw9ia2ExJJUZ7o/nCP+aSEYZ9z/rDJdoKN2X1XmakHY7D2trJ1C4xXGLyMtRm8Te1MfRFzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=UuuPR36u; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="UuuPR36u"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NUmpC7aj2WrRqj14+4L+nhL/yX199wRlYYETuLDMQU0=;
	b=UuuPR36u+W9D7GadsozFA+d5ZzmFFPZmYa3lYuF80ji07VGbjuz7KpN/AfvAuE7BkpbSZ5l+9
	Fnu9VHTVqxIyZSPTYr2a6zF4VoLNQk46vCS/8A1ZR6GAO0n9yY059FzShPsAlsl+Br132g53WSA
	6mKVZ3m5nGAsRBTWd6J9sYk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fvzhb3PF0zRhRV;
	Tue, 14 Apr 2026 17:37:35 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3885540574;
	Tue, 14 Apr 2026 17:43:53 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Apr 2026 17:43:53 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 14 Apr
 2026 17:43:52 +0800
Message-ID: <af9c679d-899c-4832-b902-e621b5987f12@huawei.com>
Date: Tue, 14 Apr 2026 17:43:51 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] ACPI: processor: idle: Do not propagate
 acpi_processor_ffh_lpi_probe() -ENODEV
To: Breno Leitao <leitao@debian.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, <lpieralisi@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pjaroszynski@nvidia.com>, <guohanjun@huawei.com>, <sudeep.holla@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <rmikey@meta.com>,
	<kernel-team@meta.com>, <lihuisong@huawei.com>
References: <20260413-ffh-v1-1-301704f69e2f@debian.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260413-ffh-v1-1-301704f69e2f@debian.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 4/14/2026 12:54 AM, Breno Leitao wrote:
> Commit cac173bea57d ("ACPI: processor: idle: Rework the handling of
> acpi_processor_ffh_lpi_probe()") moved the acpi_processor_ffh_lpi_probe()
> call from acpi_processor_setup_cpuidle_dev(), where its return value was
> ignored, to acpi_processor_get_power_info(), where it is treated as a
> hard failure. This causes cpuidle setup to fail entirely for all CPUs on
> platforms where the FFH LPI probe returns an error.
>
> On NVIDIA Grace (aarch64) systems with PSCIv1.1, the probe fails for all
> 72 CPUs with -ENODEV because psci_acpi_cpu_init_idle() finds
> power.count - 1 <= 0 (power.count=1). This results in no cpuidle states
> registered for any CPU, forcing them to busy-poll when idle instead of
> entering low-power states.
>
>
Sorry for bring you cpuidle issues on your platform.
IIUC, your platfom just has one LPI states on failure, it should be WFI, 
right?
This failure will only cause the cpuidle directory for each CPU not to 
be created, but will not affect the CPU entering the WFI state which 
done by cpuidle core.

But it is a real issue. Thanks for your report.
I think the best way to fix your issue is that remove this verification 
in psci_acpi_cpu_init_idle().
Because it is legal for platform to report one LPI state.
This function just needs to verify the LPI states which are FFH.

/Huisong
>
>
