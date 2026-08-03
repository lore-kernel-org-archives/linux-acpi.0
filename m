Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA18A424D42;
	Mon,  3 Aug 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777740; cv=none; b=rNnMiQgXSEUA93lSKy7sIADup6YkejI0c+NBCy72C6D6yO1358xgcqVi22YmR9IO6YvR78VfR6Ke3xzN119kuwAjK3BPH1exclzOriUX046FgK9q9G0hTvrH3zDhNIFZkZd0fw1QnA/iCUUbmJAYcgvrZpPqrMfE3moqaS24/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777740; c=relaxed/simple;
	bh=270DIz9UlFUEplKjpbOfvTNB6/KH66EKTiY4acDrCsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnEePmphiLMhY5gP2B2T/0azPH9xCsASvmeq++gcjWadKfWQX1HrPDe4WNA7gS885On08mvx9FjZWtwnni0PdnTZguHoocY4up5CfeZ7AFbZ6Ze5Ow+8k2C8xsjYIyldTesKDXBeLQxh1kmppVmCU6af9SC8gWhhoBaikmM2lAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Dvt90swT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Dvt90swT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31B51143D;
	Mon,  3 Aug 2026 10:22:13 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54AE93F632;
	Mon,  3 Aug 2026 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785777737; bh=270DIz9UlFUEplKjpbOfvTNB6/KH66EKTiY4acDrCsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dvt90swTb12jtxgZqJdx5XZK5shxx6M56TklQ7OaF+gMSpmJR7tgPHL0JxY6YOtcs
	 woilsiKJ2qDY/A6hznqV0hRnmitcznw1J0y40+5xptuvd5ALOgadE6AnbyvMKhCtky
	 M002Of/uy/BHNeM7YKo28K8va0ff9Ppg/zL4p/z4=
Message-ID: <9176e56f-5f08-47c8-93ee-e4e1aebda37d@arm.com>
Date: Mon, 3 Aug 2026 18:22:12 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v7 07/11] arm_mpam: propagate MSC access errors for
 mpam_reprogram_ris_partid()
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-1-andre.przywara@arm.com>
 <20260731170324.2927758-8-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260731170324.2927758-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/31/26 18:03, Andre Przywara wrote:
> Allow the mpam_reprogram_ris_partid() function check for and return
> errors, and propagate MSC read and write errors from the lower level up.
> This also covers the callers of this function: mpam_reset_ris() and
> apply_config().
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Review-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben
