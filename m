Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E753195F9;
	Mon,  3 Aug 2026 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777798; cv=none; b=WSCzuJpQbHWfsBYyWqwiLIqGVi7YbHhGN3EFHiDKzmMOFBKkIBKyOWycaZ3mNt9Dy2R6yqXgfgHcfrqD3GWQHgEanPUoyNyetyQo9d4PQwICso6FdJg5IHVvqkKB414mSk9Eh7z6Zh292x1aoAD5oFxgpcRHdgumSUbc6LeA0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777798; c=relaxed/simple;
	bh=QXdbYhODgNCoMjuMI7rdU8rtGREIL8W7KMH0uM/frs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnCliXsovlY1RXsP/MPJCYbnz96NB4G8dKxsjetmKB9YeyiXZmgfUVm58r2Pux3BK+gvxFpERkkeGCjX1X2/INLJUvI3MX5OKvyTQdhQwqsZDqqpbN9VPEz/O0NY3RW+RPiMcAUGqXR0lSioq+idA12cTeAy8CVJ85LJ5aiOG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hwcoKEA4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hwcoKEA4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF5E9143D;
	Mon,  3 Aug 2026 10:23:11 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2607F3F632;
	Mon,  3 Aug 2026 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785777796; bh=QXdbYhODgNCoMjuMI7rdU8rtGREIL8W7KMH0uM/frs8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hwcoKEA4gDomXvwry76t8b6kHyEWSf5XGAB5rkLQ291RoxdvJLA531KCJmhVX2tRo
	 Aee9Y40uk9JHS4GZSIBK3iPD2xqCdgvatEJaB4QKUxdh8iJS45lyOpBgY0NRZKA6mC
	 Ea58Z1YwQMyKl7yLj5gce4PcJ6xinidZP/WlOMPI=
Message-ID: <b3fb8ba7-f85f-4312-8c40-99320b55e866@arm.com>
Date: Mon, 3 Aug 2026 18:23:11 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v7 05/11] arm_mpam: propagate MSC access errors for
 __ris_msmon_read()
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
 <20260731170324.2927758-6-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260731170324.2927758-6-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/31/26 18:03, Andre Przywara wrote:
> Allow the function for RIS accesses to return an error, and propagate
> read and write errors from the lower level up.
> This function is a bit special, since it can be called via an SMP
> helper, so the prototype must stay as void. So propagate any errors
> using the "err" field in the struct passed in as the sole argument to
> that function.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben
