Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADA63AEF47;
	Mon,  3 Aug 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777871; cv=none; b=gPjBMSSma5pB57cijA22wa471gl/gW74tjWwd53pyCHPlBgFUUM1m8vS82x3zkIh8AUYLtvIfFhlBQDVB/0XvXGiN8WdHddrKWUVRaG7Xn8JEoNncm2BbKge8/wxBUTdy7tWyMjniuhHb9O7vcnX8XxoMzQCxZ2Gb8D80gDECyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777871; c=relaxed/simple;
	bh=f6bpgv69S18gRY4BSwh25O4n1LJwXyI+7lswDU9KAx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hvu1pZolI/Mvu2m379c/lF3vgAJzYOwnCwxgpSsyBIEX0ikcuyLsiOmhfdgitsIyQlL5R9CwMUspixPKdIUTBgOuuLIk73AKGzmJ/2gBPQo7PCwPxzgf0j9II+N4zBwAy+kVo09J6BRf0XDX/kqGIz4o0HVRmtFPU5h+4jCOD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nQMMI12H; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nQMMI12H"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE3AA143D;
	Mon,  3 Aug 2026 10:24:23 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 007423F632;
	Mon,  3 Aug 2026 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785777867; bh=f6bpgv69S18gRY4BSwh25O4n1LJwXyI+7lswDU9KAx0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nQMMI12H45CZtRsM3jkFuuL93/8Tk/lnebaXOTk8Cgxxyhva63Z6+b61jc41ATzJn
	 Z0jf7RIOMpECPir1eLUnUtL7wW46RLl8YHq6S3hFOD9fIWjP9uE55JIaUGRDatYosL
	 Ria63P4FrbbrZHfzOsOc5GhBrddskkKmXSHz1X9U=
Message-ID: <c078297a-c68b-44e8-a80c-c57f066f023a@arm.com>
Date: Mon, 3 Aug 2026 18:24:23 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v7 08/11] arm_mpam: prepare mon_sel locking for MPAM-Fb
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
 <20260731170324.2927758-9-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260731170324.2927758-9-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/31/26 18:03, Andre Przywara wrote:
> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, and when taking an IPI to access these registers on platforms
> where MSCs are not accesible from every CPU. This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with
> MPAM-Fb mailbox MSC access it must be able to sleep, meaning a mutex must
> be used. So MPAM-Fb platforms cannot support an overflow interrupt easily.
> Clearly these two methods can't exist for one MSC at the same time.
> 
> Change the mon_sel locking wrapper function to only use a spinlock when
> the MSC is accessed directly via MMIO. In case of MPAM-Fb, we use a
> mutex, but only if we are in a sleepable context. If that's not the
> case, we return an error. This should not happen, as MPAM-Fb by design
> does not require an MSC access to happen from a specific CPU, so there
> is no need for any IPIs or preemption disabling to satisfy CPU
> constraints. And since overflow interrupts are not supported at the moment
> anyway, we also wouldn't meet the other case.
> Bailing out early is already happening in rare occasions today.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben
