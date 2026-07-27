Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42F03D5C0B;
	Mon, 27 Jul 2026 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785191874; cv=none; b=VSCz8V7A0seYtyiH2wCrAFa54lzCO/uF4qBdoSCPqRCRwja0s6adnEHzbfb+HkpjM6FNcyIIvq063FQec/A2Cy/eka90B2NuQDPl9+/GI1u4Rou1DllGhOmYExV+NquORzU71QcRCW5F7Kw47mXbESGKsu3mRzQ2jMbHSfSDYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785191874; c=relaxed/simple;
	bh=6O7ChbJwoxYZSUUEha+5LdjjPM1Jl8PLPSH5pnpyCg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HE/+SrNsvMGzizif6G1VBJs7Bygre9bxy6zTRrc2biJRzUVNiR+r39rUukqmsU5J+qRDWRZ7ajHDWRksznqN083UWlua3ORfkscZdLMbTNzMCyF3iPd25YrYoaGXhEyZVg4nJsekY+lcC7AbCQkYkn6VANNzQ3nnHFd0YYDZIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcr2ZhkX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcr2ZhkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E881F000E9;
	Mon, 27 Jul 2026 22:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785191873;
	bh=ntfNJBiNkhpiyDicL/SzZGec/VqCZFSbVnQ9ysVYwHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xcr2ZhkXhg7aBbwaoTu04yPSZsUl4WcmtFKLuoFsmZNkordwS1AuuITyV47NftNDq
	 +VeMsmfOqSg0mzCxmf1z7HOkO/DxklmIlELqJe/UGzL+n5InMhS0LwX3Vqd/JWlmEz
	 lFAJhvqUax8JwtdCG19FyRgphlJXobKzHs2xJINT4MdZlS9x+Zs6qek25jAGu+kAzK
	 LFv4b9tUvs+OhRVFvRvsVOXnPWM/zqxQTA3aWnStkjHDVy68AYeQyG/2rJs7LaJ2Jf
	 i8r6H7dPDeHm2aEXDb1jiEV6oSQyszliGDQ0rfJoU5jjvPspuMLTKAVmqrFsQpnxq0
	 N2TKdT/aQNTLQ==
Date: Mon, 27 Jul 2026 23:37:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
 <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>, Srivathsa L
 Rao <srivathsa.rao@oss.qualcomm.com>, Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>,
 Srinivas Ramana <sramana@qti.qualcomm.com>, Niyas Sait
 <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] arm_mpam: propagate MSC access errors for MBWU
 counters
Message-ID: <20260727233749.3c44257d@jic23-huawei>
In-Reply-To: <20260723155454.1760823-4-andre.przywara@arm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
	<20260723155454.1760823-4-andre.przywara@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:54:47 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the mpam_msc_read_mbwu_l() function to return an error, and
> propagate errors from the lower level up. This also changes the users
> of this function.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
