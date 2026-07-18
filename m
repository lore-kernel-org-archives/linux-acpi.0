Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC63859EB;
	Sat, 18 Jul 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365768; cv=none; b=d5iLD6ll0W6tphlhAnwM4GEBcj6x2woYnRkYpDRqk678ooEYIw+ggc6LAlN2MGDxZ/xyjD0g5Cy7TRZGdPSG9kkpe62n0YytXIoxZBHxi56Qbu53f+VyLxyuU8f7aa5/i10Xtk5tJ/D9nq1i2H2xBIN/sw1kipRyY2nMvbT07vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365768; c=relaxed/simple;
	bh=p8Z4GMU2x4GxmzO8uZ7XMM50qtFMaoMtGsyGYvbpsLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPuJ2Vy+Pa7Gnpk361GAsjSqsS90sLKr7D1ZrOVztbl/rUryti4P2zxFCEyU8fO6uNOa3jh7nGOjunoMsf7cTZ4s16B9yOJxnFSaJCNzivf4UagE6jX8uT4yXcvyZmPmB5/tLkEPthL8Hrn7I4GmoJ6SWd4USEpGTOLlTev5RV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qn6YF3n6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qn6YF3n6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68791F000E9;
	Sat, 18 Jul 2026 09:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784365767;
	bh=deBObRfaAZlVeGrdDjmjKZr8UCWh91pqaVJu8Mqww5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qn6YF3n66s/geZsssIpooFkOu1/p4SGLqlND5uWGZeRHpZRyzgfe9M4Vpqz2CXIpw
	 vvy1XENDk52+G1PqueXF7bIRUeK2LgjzHZNcCLbgf5joXMedqkxEfqDn9bCMNbcLMy
	 LWoAY7avQRX0b5bN/F19IufUm/KWBVkc2e24JVq4=
Date: Sat, 18 Jul 2026 11:08:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Metehan =?iso-8859-1?Q?G=FCnen?= <metehangnen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/4] include/uapi/linux: add gxfp_ioctl.h for GXFP5130
 fingerprint sensor
Message-ID: <2026071855-booted-filth-ff9a@gregkh>
References: <20260718081431.25456-1-metehangnen@gmail.com>
 <20260718081431.25456-2-metehangnen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260718081431.25456-2-metehangnen@gmail.com>

On Sat, Jul 18, 2026 at 11:14:28AM +0300, Metehan Günen wrote:
> Define the userspace ABI for the Goodix GXFP5130 eSPI fingerprint sensor
> driver:
> 
>  - struct gxfp_tap_hdr: header prepended to every read(2) record, carries
>    payload length, MP protocol type and a ktime_get_ns() timestamp.
>  - struct gxfp_tx_pkt_hdr: header that userspace prepends to write(2)
>    payloads so the driver can wrap them in the eSPI frame format.
>  - GXFP_IOCTL_FLUSH_RXQ: flush the kernel-side RX record queue.
> 
> Signed-off-by: Metehan Günen <metehangnen@gmail.com>
> ---
>  include/uapi/linux/gxfp_ioctl.h | 43 +++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 include/uapi/linux/gxfp_ioctl.h
> 
> diff --git a/include/uapi/linux/gxfp_ioctl.h b/include/uapi/linux/gxfp_ioctl.h
> new file mode 100644
> index 000000000..c9c6c2d48
> --- /dev/null
> +++ b/include/uapi/linux/gxfp_ioctl.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __UAPI_GXFP_IOCTL_H
> +#define __UAPI_GXFP_IOCTL_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define GXFP_IOCTL_MAGIC 'G'

Why do you get to use "G" here?

