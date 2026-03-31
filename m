Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF93F38F92F;
	Tue, 31 Mar 2026 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000399; cv=none; b=AhlK88Tf5BTe5NN9MYglLuEUFlrJk6YK50g/XjOKvVAwTIUogMqAcJERWgPFcFh1zfMsHwMLH1SgI6ROj9TrMTXniCgtPkAzifS17a05eqMWDumhCBbxYPZe8NOYZnTIVPQyLh9krhNtBDEU1synJQeOuMRjfWIPdCzQSNqLijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000399; c=relaxed/simple;
	bh=1MwI5eBREz7P/+6XkAa/044/SnfCZrJcQjExGg4Jf0w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=brU56dW42FP+sC6iQ5x0TBsTF01J//GKt7Ll8KcGQe+iSAUkISGibECogSMf2R2EcjjCyQnjTRT1eCa4uAIe8ZIuMYXIsgjj/csuaS/xJgEJlWnwH0D9cKwPWvAawDqReVq7Y4UFbmXqoQjsrdksy7fr5f4bi5VuFbxLVtXpe30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk+lq73+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk+lq73+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87D1C19423;
	Tue, 31 Mar 2026 23:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775000399;
	bh=1MwI5eBREz7P/+6XkAa/044/SnfCZrJcQjExGg4Jf0w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Qk+lq73+jj6EU2YEdhL7npWBVeIE9CvtYQMLA39DjN6G8iFEHFNYuCq3wEshGd3it
	 FhtTSFowPyga8Nnhl0zchbfCnOVyYcKmOEs686ugnDDd8ZNyXvzAy8YCVZuNi2Eekb
	 u2mrLznLQj6XRBoizMsIN1w3Gobpf7D2ga6QS39EAHLnb5ggI8akj3HuPwJspRzwPM
	 +g3rO8yTLpkYu4A//y3jb0X9YCpYNaTqzFFuCHXygEvMndUJvilEvFHIwo8GEGC2M9
	 YpU2cQTs4g1ZyQUujqzuSfwQhTSEGMvbfBydeim0hZgRxG+hJ5f94MypfYFcGuyQmd
	 axFJtj0sQu7Yw==
Date: Tue, 31 Mar 2026 17:39:56 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Sunil V L <sunilvl@oss.qualcomm.com>
cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
    linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
    Len Brown <lenb@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
    Andrew Jones <andrew.jones@oss.qualcomm.com>, 
    Anup Patel <anup.patel@oss.qualcomm.com>
Subject: Re: [PATCH] ACPI: RIMT: Add dependency between iommu and devices
In-Reply-To: <20260303061605.722949-1-sunilvl@oss.qualcomm.com>
Message-ID: <3c2783e0-f41b-3bee-71f2-60f2246ff63c@kernel.org>
References: <20260303061605.722949-1-sunilvl@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Mar 2026, Sunil V L wrote:

> From: Sunil V L <sunilvl@oss.qualcomm.com>
> 
> EPROBE_DEFER ensures IOMMU devices are probed before the devices that
> depend on them. During shutdown, however, the IOMMU may be removed
> first, leading to issues. To avoid this, a device link is added
> which enforces the correct removal order.
> 
> Fixes: 8f7729552582 ("ACPI: RISC-V: Add support for RIMT")
> Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>

Thanks, queued for v7.0-rc.  Something that would be helpful in the 
future, by the way, is if you would describe the issues observed in 
greater detail. 


- Paul
