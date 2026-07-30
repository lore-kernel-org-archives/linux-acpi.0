Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1430840927D;
	Thu, 30 Jul 2026 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410926; cv=none; b=iX8z3QPPgfQoOvOQlATRsYaIMC4RaKs5LQTovaCuCj5RYrFIdjFpRMIS+gQdwUEIcA8w5y5/kTZ2yP4pAxXBVRPSZ7lbMtspMKSrBWp4i7Rw8Z+Y1afJCXGavyQn4HAt4TqE5UCpkLTjb0vi32PFOetaP9XXXR5RcMc7zeSFSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410926; c=relaxed/simple;
	bh=tSCp+PgtLkdlHR4/BfgCtxQ77P6JA0OVd1sIwSXnFRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfbXmh88y+oG78QajlcBlQXQki2zadF00DOvfv8HHRiRITGfZpsC5nVd/RH0Xag0jXRewDJ3WEmBoVKUrit39umgHi43aKgZWXwP/uq4iUg0QQ+pk9nrrGUnmGbBAEsa/dx0Rmb/zTaCo9G7geeNLTeBJl6tk9w9W+yaDJ4tMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ROnyVbZd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ROnyVbZd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B4E81684;
	Thu, 30 Jul 2026 04:28:40 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3893F763;
	Thu, 30 Jul 2026 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785410924; bh=tSCp+PgtLkdlHR4/BfgCtxQ77P6JA0OVd1sIwSXnFRU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ROnyVbZdNiR1uu2vwlO/1Zh+MSOjfrP8BtZ/JjNQMDrkLqKAPiwtdfAp5rQk3Ni4t
	 e3Cq3Lgg/PvTOEhFQc1dRP8mvOQYzZ2+vvcPe6R/aI4qibKWh6lMYdNkJJfnBLqF2c
	 NqVywHCz9w5wUacKN40JjXiqQkW9uu98N5+zNy8Q=
Message-ID: <bdeb9012-d333-439b-a4e5-b652e8380f78@arm.com>
Date: Thu, 30 Jul 2026 12:28:40 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v5 06/10] arm_mpam: propagate MSC access errors for state
 saving function
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
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260729134124.2506269-1-andre.przywara@arm.com>
 <20260729134124.2506269-7-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260729134124.2506269-7-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/29/26 14:41, Andre Przywara wrote:
> Allow the mpam_save_mbwu_state() function to return an error, and
> propagate read and write errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben

