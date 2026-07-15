Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8D3AD51E;
	Wed, 15 Jul 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131724; cv=none; b=pONcOSOnE6pm0yG0oRQ5vFYpkPRS22O4tlE8myD0kdQU+vjXnoISDcN24BL9sV9+hrc/RNm3A4ZCCu/U1AH7DbFhzXlV/9JO4cxIrn8UzGaa1fCMpa5OjShlDOretCsoLqDqyN5AjbaPQ2tgrRokRT0Dcmh3AOrIwOouCfNMp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131724; c=relaxed/simple;
	bh=YxM5iYGtcWkqXmnAOVb4+QQ8oHlRSP4V/yY8wmoytEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YF6/VufVR6x35ACI7q/SjNRLrSxMt042Q9CWwON4Z9oWwSbx9XC1Od4x61t+aRBseICAZ0RO0rlvAiMYF/A7hBKLDb7C1mF8um74MJTl93dMJVMGtX5J8YxNi0sa4GPkSgFtU8Lh0j2uj1e7OPaShLH5Ldvhx2VrW0ls5Lnye/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-73-254-161-40.hsd1.wa.comcast.net ([73.254.161.40] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1wk29n-0008NF-8r; Wed, 15 Jul 2026 16:08:23 +0000
Message-ID: <52dc486f-2ef2-4c57-b3fb-fb4c240a9198@trager.us>
Date: Wed, 15 Jul 2026 09:08:15 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] arm_mpam: detect and enable MPAM-Fb PCC support
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-17-andre.przywara@arm.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20260710144520.917375-17-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/26 7:45 AM, Andre Przywara wrote:

> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> index 84963a20c3e7..64bc84bb2029 100644
> --- a/drivers/acpi/arm64/mpam.c
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -256,6 +256,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>   	} else if (iface == MPAM_IFACE_PCC) {
>   		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>   							tbl_msc->base_address);
> +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
> +							tbl_msc->identifier);
>   	}

props is defined above as:

/* pcc, nrdy, affinity, and a sentinel */

struct property_entry props[4] = { 0 };

With the addition of the new property the array size needs to be 
increased to 5 and the comment updated

