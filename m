Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C58287510;
	Fri,  5 Jun 2026 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677228; cv=none; b=fIiCtsCM0YqfdYmmDjguMhPDr2XXjFzXSVwGKfhq2Rr9iB6aSxqp9DLhImqBOeaG2PibuO9mHQcboO4RYd7589a2kBX9Q5G1UvgTOmJSzKOb24BtcYUI6y5cwFa8qiEEip9fNnbSLzYT8f0q4LR6Z5rPakWZQZamAcXtt5SgcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677228; c=relaxed/simple;
	bh=Qg/YBABhE0Rg9kput4fZWHwdrf4i5lFSRYQSaJUB3uI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mmAzjrNnCedevsdqSuAZOIXY1EJgnazt3bppC6gLuTIk+c/C5f7v7Hwi5BByh4Ku01q9HbpOPKb2US71EJAI0XNhgaZPU0ppM17Rr9eDiuFxnYJzUSYmIVq+cfhNxkjQ6Z4g8QG7CgvEMmlIT+E1joWoQ9z3L1DKcJVdvr7/9iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Pov81wvP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Pov81wvP"
Received: from [192.168.201.246] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B16320B7169;
	Fri,  5 Jun 2026 09:33:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B16320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780677211;
	bh=y+cqViY/4ta5CUe9vhnbFU7MujI8/YRoroF7XKimY6w=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Pov81wvPXsobNzSWkFAR+lWcHD6+T7B7x3+Um3JRS7NENGKPLL0a8bJT5iJNL9OMs
	 24NfqwSjLDGun3x1qSonofaksmwrJzumMdbyd9aVqPCw2GtjTgP62O53MWPJYGCVac
	 rU2SA0X2iKIbC5oef/aXv8QqTXCQLbU5mJNbIunY=
Message-ID: <ff856534-28b0-4867-abc6-84698b8a5d81@linux.microsoft.com>
Date: Fri, 5 Jun 2026 09:33:41 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-acpi@vger.kernel.org, easwar.hariharan@linux.microsoft.com,
 jarredwhite@linux.microsoft.com, lenb@kernel.org, rafael@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: CPPC: Suppress UBSAN warning caused by field misuse
To: Jeremy Linton <jeremy.linton@arm.com>
References: <20260601235808.1113137-1-jeremy.linton@arm.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260601235808.1113137-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/2026 16:58, Jeremy Linton wrote:
> The definition of reg->access_width changes depending on the
> reg->space_id type.  Type ACPI_ADR_SPACE_PLATFORM_COMM uses
> access_width to indicate the PCC region, which can result in a UBSAN
> if the value is greater than 4.
> 
> For example:
> 
>  UBSAN: shift-out-of-bounds in drivers/acpi/cppc_acpi.c:1090:9
>  shift exponent 32 is too large for 32-bit type 'int'
>  CPU: 61 UID: 0 PID: 1220 Comm: (udev-worker) Not tainted 7.0.10-201.fc44.aarch64 #1 PREEMPT(lazy)
>  Hardware name: To be filled by O.E.M.
>  Call trace:
>   ...(trimming)
>   ubsan_epilogue+0x10/0x48
>   __ubsan_handle_shift_out_of_bounds+0xdc/0x1e0
>   cpc_write+0x4d0/0x670
>   cppc_set_perf+0x18c/0x490
>   cppc_cpufreq_cpu_init+0x1c8/0x380 [cppc_cpufreq]
>   ... (trimming)
> 
> Lets fix this by validating the region type, as well as whether
> access_width has a value. Then since we are returning bit_width
> directly for ACPI_ADR_SPACE_PLATFORM_COMM, drop the code correcting
> the size.
> 
> Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
