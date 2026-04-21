Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A782BDC0E;
	Tue, 21 Apr 2026 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765941; cv=none; b=VCqAzQsagKlFTyR/cKGamw+vQ8WoPsv4jd9BqUeXQwdvh71fvjHy87Ywm3Lv1CGxiDC/jGadhYJXg3pPApX2BRSD5P97dQGUNE/p3YYK1NX2FYDxPPYO3F1klL+kom4grTj+St8F5zwIuesywhnjyN8SnGrQq/WzfTNvH5mBHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765941; c=relaxed/simple;
	bh=/IN9k9jbMjqCH+zPMrCvuJ2eynEoxIBunTPuv0XTB58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2vulLBSjzjVULXrWtTllPRJYQgrtpJuepOSZSs49jfYG0Jf/Iwrbx3Zk6s/RXz5zkBX0tFumctt+3wH2zDBJ7pH/Vnk+3mc1HDZfSvrDMESSHr1n1tKIIZB52IpSv3XOXUadaZ691xBkeeN5EQmqW6TagRcLyOCOOc/jnLLAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwaXEmCk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwaXEmCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A79C2BCB0;
	Tue, 21 Apr 2026 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776765941;
	bh=/IN9k9jbMjqCH+zPMrCvuJ2eynEoxIBunTPuv0XTB58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwaXEmCkmRFq4dLagw+MbXm1rqtgd39Q7yihPYYYWu2scPcvO9CWYgl2JwXB+MiuA
	 wW7hXTcvApyRqdVfusE8IQp+NAomgN6MyKhq26gw48++u8HYd5zUF+aTtcJwUZu8OQ
	 +r7i4CJsppE1YZgsFHq75DmVrWwuy9fyHQpSebuMlfRCK1v+ZExw3zHW6JNHsKYqtj
	 FB2a6DDZKZbTt3lomvNyVqhEK2DMUFXOd+tgykpEZYpiKvYlMAqQc+3Pb1A0ebrlM5
	 cb0H9HxjwKOMhVCHI0WnC+IUioY2BcLu4W1IxhWGaGXMaPd/i/Fw9ph6uJs7IAmY9I
	 RAHA1y0dCFaiw==
Date: Tue, 21 Apr 2026 11:05:37 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Huisong Li <lihuisong@huawei.com>
Cc: jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	Robbie King <robbiek@xsightlabs.com>,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH] mailbox: pcc: Fix probabilistic command execution timeout
Message-ID: <20260421-adventurous-victorious-caiman-dce291@sudeepholla>
References: <20260417031429.2509443-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417031429.2509443-1-lihuisong@huawei.com>

On Fri, Apr 17, 2026 at 11:14:29AM +0800, Huisong Li wrote:
> In some scenarios, PCC command may experience probabilistic timeout.
> This is primarily caused by the chan_in_use flag being updated after
> ringing the doorbell, coupled with a lack of proper memory barriers
> across CPU cores.
> 
> On fast platforms, a race condition occurs: the platform processing
> completes and triggers an interrupt before the local CPU sets
> chan_in_use to true. When the interrupt handler pcc_mbox_irq() runs,
> it reads chan_in_use as false and incorrectly ignores the interrupt.
> 
> This patch fixes the race by:
> 1. Moving the chan_in_use update before ringing the doorbell.
> 2. Using smp_store_release() to ensure the flag update is visible
>    to other cores before subsequent hardware or software actions
>    are triggered.
> 3. Using smp_load_acquire() in the interrupt handler to ensure the
>    latest flag value is read before deciding to skip the interrupt.
> 

Are you seeing the issue on real platforms or you are just reviewing the
code. I would like to test it on the platform I use but I don't have it
handy, so may take some time.

I have added Robbie King who also has helped in testing this PCC driver
in the past.

-- 
Regards,
Sudeep
