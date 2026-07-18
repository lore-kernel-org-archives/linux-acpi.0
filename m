Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A6176FB1;
	Sat, 18 Jul 2026 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365750; cv=none; b=fudrgr0djinB3U1yctW8xmgJDqAbs7zptaJfE7u9zR9kH1md6wltgPK+RPGN8J0axZiY21rQlZFVRZbIjlYWb30gZZ43AKl3SbZmrohlWk7ylxkEC0FCPTkoUVo0plThQxsdNN3KIhfsFYUebkT4icEk97TGTuv7o9s+3ZCz8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365750; c=relaxed/simple;
	bh=w0B24LlidNvGjNUgSt9LBZLrJj4A7Z4lVPoAEvy4veM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPCfTSSrlvV8holBmhwjO1/HTGJm58knalu32W9fA+B1wg/ofeusakszICy+531Rab9hL2vrV8KOaPM/MjeTOc1gnCt0McStA+RxhDGN3N/N7kKSRE80ozEWDG6Ar/myZNA0CVq06QObD27CS8Xg3mhfWlUWyqN1BQ4s/5cibcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rQIb3hha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rQIb3hha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F681F000E9;
	Sat, 18 Jul 2026 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784365749;
	bh=S8hK1lCrVVRcqazRAxEdm3QgRzdv3fDryM0evzBoxsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rQIb3hha0bHd3dtQHSI3Isd/MEI1wkZVLCfryJlvat0HJcsn8dBOsTaOFyUBTQpiA
	 PYAiDzS3HiZ5un4Yy0uTptivSEWEbF0aPfgb8XC+ahN97QdxoxiVqUl6cnazmIVSEY
	 nhbpGsEmWiQ+KOz9z0MGNrWI8FQy9h/K5G4rop8k=
Date: Sat, 18 Jul 2026 11:07:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Metehan =?iso-8859-1?Q?G=FCnen?= <metehangnen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/4] include/uapi/linux: add gxfp_ioctl.h for GXFP5130
 fingerprint sensor
Message-ID: <2026071801-headdress-gab-348e@gregkh>
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
> +
> +/*
> + * 4-byte MP header + payload must fit GXFP_TX_BUFFER_SIZE(512).
> + */
> +#define GXFP_IOCTL_TX_PAYLOAD_MAX 508u
> +
> +/* Maximum protocol payload bytes exported via read(2) records. */
> +#define GXFP_IOCTL_TAP_PAYLOAD_MAX (128u * 1024u)
> +
> +/*
> + * Stream tap (read/poll) record header.
> + * Followed by `len` bytes of protocol payload.
> + */
> +struct gxfp_tap_hdr {
> +	__u32 len;       /* protocol payload bytes */
> +	__u32 type;      /* MP type */
> +	__u32 _rsvd0;

C variables do not start with _, this isn't rust :)

And are you checking this for 0?

> +	__u64 ts_ns;     /* ktime_get_ns() */
> +	__u8 head16[16]; /* first 16 bytes of payload */
> +};
> +
> +/*
> + * write(2) packet header.
> + * Userspace writes: [gxfp_tx_pkt_hdr][payload bytes]
> + */
> +struct gxfp_tx_pkt_hdr {
> +	__u8 mp_flags;
> +	__u8 _pad0;

Are you checking this for 0?

> +	__u16 payload_len;
> +	__u32 flags;

No definition of what these flags are?

thanks,

greg k-h
