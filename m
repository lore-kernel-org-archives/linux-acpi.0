Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89EC3EDE5D;
	Thu, 23 Jul 2026 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798175; cv=none; b=u54ciJRZjsC+oDmDB1abD2epfuQTTVI6DtNBWebpZtttHw6zA9OPSxZozz4N/ELxmFhrcGWLL/uWTlmloXTrVfV0irT/0acykBTEPGviZv8AHtxiNdMv3Z/J+rVJk9Ayxa5SAH/hml+WSpv4YpxZoWH8sxe5cOv/VvbexYrZKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798175; c=relaxed/simple;
	bh=aPr40JF8CTowQxlzYfCJk8dxql/HsambQJecLXlp77Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdl3d1Txo9hbowqkNXbfggPYg3TEqi1e785loj02LpRYqeIe7YQotUlle+eWbeUACRj5l/kr3lq5SaQNmcuUp/BrlcqfAgsRiTEuQSLyrom03XNca4D/6vBDzHBJBUX87d/qyJckD8nIfo+pPSZpvvZOujfx7IjHeyvOSE/FE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E511F00A3A;
	Thu, 23 Jul 2026 09:16:13 +0000 (UTC)
Date: Thu, 23 Jul 2026 10:16:11 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: jassisinghbrar@gmail.com, lihuisong@huawei.com,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mailbox: pcc: Fix command timeout due to missed
 interrupt
Message-ID: <20260723-mastodon-of-simple-criticism-2bdcc9@sudeepholla>
References: <20260717075649.467172-4-sudeep.holla@kernel.org>
 <20260723031051.156890-1-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723031051.156890-1-admiyo@os.amperecomputing.com>

On Wed, Jul 22, 2026 at 11:10:51PM -0400, Adam Young wrote:
>  
> +	/*
> +	 * Set chan_in_use before ringing the doorbell so a fast completion
> +	 * interrupt is not mistaken for a shared interrupt from another
> +	 * subspace. Use WRITE_ONCE() for the lockless flag update. The
> +	 * ordered MMIO accessor used to ring the doorbell keeps this store
> +	 * visible before the platform is notified.
> +	 */
> +	if (pchan->plat_irq > 0)
> +		WRITE_ONCE(pchan->chan_in_use, true);
>  	ret = pcc_chan_reg_read_modify_write(&pchan->db);
>  	if (!ret && pchan->plat_irq > 0)
> -		pchan->chan_in_use = true;
> +		WRITE_ONCE(pchan->chan_in_use, false);
>  
>  	return ret;
>  }
> -- 
> 2.43.0
> iAt the end of the above code, 
>  WRITE_ONCE(pchan->chan_in_use, false); 
>  should be 
>  WRITE_ONCE(pchan->chan_in_use, true);
> 
> In order to keep the original semantics.  The flag is cleared when the
> messages is ACKed, not here.  This version causes a hang.
> 

Did you run and seeing hang or just code inspection. If latter, have you
considered that modified code sets it true before doorbell is rung and
set to false only if there is a failure to ring the doorbell ?

-- 
Regards,
Sudeep
