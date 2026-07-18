Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6237EFFD;
	Sat, 18 Jul 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365647; cv=none; b=FRwnpiMcg26A1qWSnXKwSe+QdbOYpHgfQB72oaJhsMQLDaZ6ecXKCYT84SO0FrSlQcMlAPta1VVTKvnUuINedFCJZspBlVjyfcwM5KhDZYcsmCq9mZySQAeKuZPTch+xmE+nEKN1GpljQL2L0G40jVgdSnz5ZIh70xHFlf9mgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365647; c=relaxed/simple;
	bh=rjxbfj83Rknb2pmLBxMO2WitSWlbpDC3tnyBkDQl/8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmI1rud327dVZLsLe/7N2qlmB2XxMDessiEGdZChav4r/3rPT1/GgFd5WGQ7KN+xExTqlL2H0ttHie3WN7qzj+5/bA5oRAShZryS0CYoMF/bzpkgZ4Y4RBcKuWdOVyFXFeHzUm869jtzsD5rpEGmET78tE4uNCfRvWhrplkvvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mwf3nhpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mwf3nhpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8D51F000E9;
	Sat, 18 Jul 2026 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784365646;
	bh=Zwliyx/1NmJrok4UHwtH9x/cbn6LKLfRS/3iQ6MO0nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mwf3nhpGd6o55a08RbzCOhMi18OTY29UIIBS0BxyhTWT1tnCPxrRgndDa6aKP0AhV
	 fW7KpQ/G9fAtFBlDLxYVgvJwdJPoogdBsgp0MDGnhaHrPDlhetEIZFuBW7hAd7vVbp
	 SIgpxsuVsbIkqUlGUkjMSfOMEEO03nGnvkW279Bk=
Date: Sat, 18 Jul 2026 11:06:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Metehan =?iso-8859-1?Q?G=FCnen?= <metehangnen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/4] MAINTAINERS: add entry for GXFP5130 fingerprint
 sensor driver
Message-ID: <2026071842-trillion-ogle-1f66@gregkh>
References: <20260718081431.25456-1-metehangnen@gmail.com>
 <20260718081431.25456-5-metehangnen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260718081431.25456-5-metehangnen@gmail.com>

On Sat, Jul 18, 2026 at 11:14:31AM +0300, Metehan Günen wrote:
> Add maintainer entry for the new Goodix GXFP5130 driver covering
> the driver source tree, UAPI header, and documentation.
> 
> Signed-off-by: Metehan Günen <metehangnen@gmail.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a674e3652..7d18b5410 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11048,6 +11048,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/connector/gocontroll,moduline-module-slot.yaml
>  
>  GOODIX TOUCHSCREEN
> +GOODIX GXFP5130 FINGERPRINT SENSOR DRIVER
> +M:	Metehan Günen <metehangnen@gmail.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/misc-devices/gxfp5130.rst
> +F:	drivers/misc/gxfp5130/
> +F:	include/uapi/linux/gxfp_ioctl.h
>  M:	Hans de Goede <hansg@kernel.org>
>  L:	linux-input@vger.kernel.org
>  S:	Maintained

I don't think this entry is doing what you think it is doing.

Was it created by a LLM?

thanks,

greg k-h
