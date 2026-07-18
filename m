Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F293890F1;
	Sat, 18 Jul 2026 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365866; cv=none; b=JqNad6Nc/oE9I+MKge1VXfx/39uMu3EHXjdBbSe52pMbX6U8dWO0S+hPVmBkuatjevdrsSRg7y/0kbEM/IJLOZx/L/JRsBIVBM+Tx9J5AtBoReh9sm3N6cCAR3ZEWc3jeiimhFjHjaOtLw79Zfit0NchoqpLmzmYjuZ8GmFBMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365866; c=relaxed/simple;
	bh=rRCFx7q1d0wgIUYZNM4zKF138iKRlivg4jQ+nxmJ7m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izNKwGIY0MAzw0sjZB9rSfK2xKf1xRaLSYmw6js+zdJBl5W56Ja4iEMpguIKB7lCnZnVCb1OhNx53FzqJkg2+awxj0/zvUM1Zl60FVjbaov/UxdpWHQQOAVhi1/jgyd6GnAaVd+WD0sPjiE1eEzZdHVbTNfrzo0ek9/GuYzsePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rM/nqK5e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rM/nqK5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010C51F000E9;
	Sat, 18 Jul 2026 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784365864;
	bh=MB54kY+YOtgPpKDd9tqdT5q4K9aOdVhClJcGMDb23xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rM/nqK5eD1itsD4bw4HDlhUYwZLo8igTl5h+TQ0nH9o3J9En6I8CvafO+HzbxLq7c
	 smD/6Ukp+qZxmdW272f8YFZOnvIq8uC8WGvylVbbBrfVw9vPZ2AWkHbJJ9zV6s5EnA
	 tzdQFxE1e7siLKudqJFmaUF8w3latPlBTfmuR4jQ=
Date: Sat, 18 Jul 2026 11:09:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Metehan =?iso-8859-1?Q?G=FCnen?= <metehangnen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/4] drivers/misc: add Goodix GXFP5130 eSPI fingerprint
 sensor driver
Message-ID: <2026071828-blunt-survivor-834f@gregkh>
References: <20260718081431.25456-1-metehangnen@gmail.com>
 <20260718081431.25456-3-metehangnen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260718081431.25456-3-metehangnen@gmail.com>

On Sat, Jul 18, 2026 at 11:14:29AM +0300, Metehan Günen wrote:
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -651,4 +651,6 @@ source "drivers/misc/mchp_pci1xxxx/Kconfig"
>  source "drivers/misc/keba/Kconfig"
>  source "drivers/misc/amd-sbi/Kconfig"
>  source "drivers/misc/rp1/Kconfig"
> +source "drivers/misc/gxfp5130/Kconfig"
> +

Why add this extra line?

>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index fed47c767..e85c68aa1 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -74,3 +74,5 @@ obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
>  obj-y				+= keba/
>  obj-y				+= amd-sbi/
>  obj-$(CONFIG_MISC_RP1)		+= rp1/
> +
> +obj-$(CONFIG_GXFP5130)		+= gxfp5130/

Same here, why the extra line?

> +	gxfp_trace_logf("cmd_timeout req=0x%02x expect=0x%02x tries=%u",
> +		req->req_cmd, req->expect_cmd, req->tries ? req->tries : 1);

Please do not roll your own tracing functions, use the in-kernel ones
instead.

thanks,

greg k-h
