Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792850498;
	b=Yv9/wrGQvN3At9aqfx5okgx1iecmp9HHA3nXN7/NBxtC6UFUgUISGTXLBBlBRnXJirao
	 zwS6dabcJGq8H8FY4T6OXRI/9QWEzLLYT6rqcqTxJ1FuP+RzxvspUzkdTeDarSFFgP+PC
	 mjek4C+hx+fctNm/J1FnHxUbykr3iIOdFSGFX9fDMCL4R1sCzBfupSGLs4sC1i7kUWStu
	 nuSZqYeyaBgXq3PvtAS6lKy+VxAJ1iqORXxtIGl/bcVk5YTEYLNFlv1pA9cpSZT4LC0Ph
	 1FXsWTzSCRuVeZDsltS2BA4Nd3mTw2Zf5F08hkvXwS4dTTTQvvbQ3STvtsGjzf3/Hcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792850498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Hs2l2qy8RZsJLMHRlnYs8TNlHuEDUdu45KHJmPnrBpM=;
	b=n4Ju30jtcGn7Oo4UxA8ZlkZJBdUgIqm3Q84JYUBB5xB+XSo9Gfb6iOUZWHMXWJD5n39p
	 T0tJ4s47pL38rW/dcw/jyzTiLgWDwT6E3sIQsqJfgzYplQJcfjBy/23eRbsJaS6nxm8fO
	 zj1Uy4i/M4vE5LsES+EzitRb2WCl7LtPf3AxlCviHepGZPdBLlkDhu1W+Gf2WJ9qHqEWh
	 8lbOfz+u8TY95fKHEJpXGtONlRVsE0ZTv/tWkqjijV3CAOjFBeeeNTlXSCleFjJqROvUd
	 87F1X01l5igGX7gu96v1LXIOKgItR8d3Z0DWJLpDTlxJcJ5d3OVbegzmDn+QpT6rEmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RIy57taI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67545606A31D
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 14:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67545606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RIy57taI
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be3ea5a7adso1302313e87.2
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 07:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792850495; cv=none;
        d=google.com; s=arc-20260327;
        b=cuxuWQbBVHwhpWjK+MDAXMrzXNvNfiUl60l3gkaIlL0Lulwni2ul7U6rOgu9H25dQm
         Ir5P8yNAuLrhV6ATzUVLgXnqPB07EMNsxV/8ytyTyncpdnNy3KwmQR4ptcpZVRXnfEhf
         iKp22rPf5zvbTC8G50bNvFK86t/CAj0whSLMYPY6PTkodS4M0pKv5hhNXvd89oaTcEdQ
         CiS7nS/qlzPR/F5T1R6Gs+54N8WV7+yHjM+I30zN7VlERyleIF3uSuBPhR/7027+nQTT
         FLK6yNS+4v3JKL0hE3iv/j46n8qRvswfIcXYTdkX/R6xGDcD78nIlXpMA6yeYB3shSip
         8/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Hs2l2qy8RZsJLMHRlnYs8TNlHuEDUdu45KHJmPnrBpM=;
        fh=Cp9phXryodR1JkL9v0UYMGJwkpWkjsfG2uZ8WUtqcNE=;
        b=lPrY9CShDZ2cmAW3yKYxrGMrYSsEK8Voht1/3Aa//8NCcVeTzgU4hyEKv64hpXbkq8
         22PCphO/Z1ifYvOJxMPrxu36HDB9uGD98uXzsophmdKm11aiaN+BvLjozJGAVcYw/Ru6
         K4A2YMR3OeCK1DePi8G1G4Q5cHh63d3U6bmvDlAR2WiQ6Sc4KXZgj+ELKVqgb5b/QL7u
         Rmj3rhXG8xJpPXMN6aIQJlLyNWNU+n3U2ahkXRI9q5tmCLNqU0KnTRW9GYM2jYCplrl8
         UeKZzo32szT7zu4Kj4Km+wfPBGMJeUZMAD5thtMcN2qJ6w0FfaljZVQWUsOB+KV1nowa
         Gt/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792850495; x=1793455295; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hs2l2qy8RZsJLMHRlnYs8TNlHuEDUdu45KHJmPnrBpM=;
        b=RIy57taIvA7vatJdScZJFnzWwk720Ygb4ewOH/fBbPbMLo4CmW4cHf6uEI4BNoQSge
         ihiWSpeanpYw10ZEjoH0PmC3W7j1YZxEyUmGoDBb7yMXEXPbGMy4/j4GBBEl0tmGtIko
         f3amjkzsWV8Ire6s9F0/0j4bg3yUuMz7ijiMxDnexnp0iwt/e7w4YrvzJ3svK/xHTqJj
         Nd1+YAdwxsZvbUFUGxcSws7WenrswcH8wBkrGzI3u0cNSHbQFQfb+JjEYo7GXxowtzz8
         3gcv+FrfbcX7VjeaZwdNCjtO0NLfMTxlNdqVq9ILg2gJ5F3yWLNyX645k490Jbo1bjUC
         5kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792850495; x=1793455295;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hs2l2qy8RZsJLMHRlnYs8TNlHuEDUdu45KHJmPnrBpM=;
        b=iPAPpnFdfvUasT04OSqEAEs3yBqv7H+0fC1QYzoYwv6a/JhVh0X3FaDmeQ2QSGCO3+
         bFrxLJkaK0iQE/JP2qGOxMjM/tfw3CODiSe1yw8WjYN+15L4xz6BpNr+D/sJhTLZS1kk
         JqjQrvYt9DxlJOET+HHWGJ5gJ1S+Zpbe1U0f68huEW3DmWX34bEF9aimC5izChtUxb3W
         U6A/VrhpOEqcsSIqDwErbxDu+HqDJZOww2+aA7dyGJD0lXWs0QHD3kC3t73xq5xNf8Dj
         IcxEFaIFK7zO8k+1zGuyUdhtDjFUgF8vfFZePfgn0+Bk4qVEGqbImhZbkb0ApXUC5yws
         w/ng==
X-Forwarded-Encrypted: i=1; AKwUvByDsLtPhyzFZ54/Xu6GP+3XIHi8V79PJ9kZKDHI9vCUdaOOp8pAw8JLWk0sTfYL5X4h8WOYa4QfvFnt@vger.kernel.org
X-Gm-Message-State: AFq9FYIumrCz9yHRpBSuy3UEj5FqEXbhFWna7PNLSfwp4w5iJy0mYU1X
	pWo7T8xq3HnU7LEI10dUZwIvK+/09MIeSua8oiabEOZwHJ1HsWUOv53xT3hk9+8U3nuWNX4hLHl
	yYkyBvy1e1Cq/M9wxLjusz+pmSh7gj6s=
X-Gm-Gg: AYBFou1XvMCB96Mje9FCyRtJp8HRkSN8RZK3KlYkReL6C9Cfk/+hgXwRAcL9mGuSKv1
	xeIWm2viVmWM5Iw58dNUV5V8cKou8r6E1IZFisUoyfgH5Z9n03qQctEiy1U0LJX4dOzjH5/FARq
	Ft5niLQORzylQPQy7veAsDgSRXgefwuSVvdrPVDC1yR3H2xaEYqGArw0dhbpuBnj6UOq/LczE7B
	o0E6AOse4YIGbf9/Ymj3CJpO3V3QSG7bcdaL5n8STgVUojSNI6LArTxsoXWB5IkDwclMhzpkYMi
	A+yytsoJpoZbLhwaoR1hwlhwxEE8kMfIpuwNB5TscPuT+fnVjbWn2J8azMpQoj1kuDYYg0lM3xw
	8QqdqGblFwzUyFRYdQfCQSR6wOVb2uNeK9ZtbRYhWxBX56ajRzcjG2Ss99Imb+4f/peBN/rk5Gi
	SQWLvbYHr467KicYc6IkC7xLjnzrtmtpNv90hL37PkQdThtAHmQxPU
X-Received: by 2002:a05:6512:398e:b0:5bf:b144:fd00 with SMTP id
 2adb3069b0e04-5bfb71c809dmr779570e87.13.1792850495146; Sat, 24 Oct 2026
 07:01:35 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260829145516.13500-3-edward.blair@gmail.com>
 <20261002082552.7084-1-ite_pd@ite.com.tw> <CAJDQNghzjreMHXTVEWTZ-Oyo1cCpzLyDUyt68EZvPD30Wp0txQ@mail.gmail.com>
In-Reply-To: <CAJDQNghzjreMHXTVEWTZ-Oyo1cCpzLyDUyt68EZvPD30Wp0txQ@mail.gmail.com>
From: Edward Blair <edward.blair@gmail.com>
Date: Sat, 24 Oct 2026 15:01:23 +0100
X-Gm-Features: AclHuK_nB-JD7Ut89NWc6ywX86lVHxDy-fHmXyTJWFi5xeriSZppXukQ1Oo5v_Q
Message-ID: <CAJDQNgiJCqAJQ+7zNLd+UD9vMuzu9e46zG5b5voKD+_gaKJcww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: add ITE885x I2C transport driver
To: Amber Kao <ite_pd@ite.com.tw>
Cc: W_Armin@gmx.de, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	mika.westerberg@linux.intel.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Amber,

Thanks for reaching out, and apologies for the slow reply.

I'm happy to drop the separate transport driver in favour of
ucsi_itepd. Would you be willing to take the lead on adding the ACPI
support and any handling needed for these ASUS boards?

Please feel free to reuse anything useful from my patches. I can help
test your changes on my ASUS ROG Strix Z790-E Gaming WiFi with ITE8853
and provide logs or ACPI tables.

The MSFT8000 enumeration fix in patch 1 is separate from the transport
driver and has Armin's Reviewed-by and Rafael's Acked-by. That should
remain part of the solution for these boards.

Thanks,
Edward


On Sat, 24 Oct 2026 at 15:00, Edward Blair <edward.blair@gmail.com> wrote:
>
> Hi Amber,
>
> Thanks for reaching out, and apologies for the slow reply.
>
> I'm happy to drop the separate transport driver in favour of
> ucsi_itepd. Would you be willing to take the lead on adding the ACPI
> support and any handling needed for these ASUS boards?
>
> Please feel free to reuse anything useful from my patches. I can help
> test your changes on my ASUS ROG Strix Z790-E Gaming WiFi with ITE8853
> and provide logs or ACPI tables.
>
> The MSFT8000 enumeration fix in patch 1 is separate from the transport
> driver and has Armin's Reviewed-by and Rafael's Acked-by. That should
> remain part of the solution for these boards.
>
> Thanks,
> Edward
>
> On Fri, 2 Oct 2026 at 09:25, Amber Kao <ite_pd@ite.com.tw> wrote:
>>
>> Hi Edward,
>>
>> On Sat, Aug 29, 2026 at 03:55:16PM +0100, Edward Blair wrote:
>> > Add a UCSI transport driver for ITE8853 and ITE8800 through ITE8805
>> > USB Type-C controllers found on desktop motherboards.
>>
>> Thanks for working on this. I'm from ITE, and I wanted to let you know
>> that we have been upstreaming a UCSI driver for the same controller
>> family. The driver was posted on 7 Aug 2026 and has Heikki's
>> Reviewed-by:
>>
>>   https://lore.kernel.org/linux-usb/20260807-ucsi-itepd-v7-0-998ac11ed0ef@ite.com.tw/
>>
>> A follow-up series extending it to the IT885x and IT527x series has
>> also been acked:
>>
>>   https://lore.kernel.org/r/20260924-ucsi-itepd-it527x-v3-0-a7392aa087f5@ite.com.tw
>>
>> Both drivers target the same register interface (CCI at 0x84,
>> MESSAGE_IN at 0x88, CONTROL at 0x98 and the vendor interrupt registers
>> at 0xbc/0xbd), so it would be better not to have two drivers for the
>> same hardware in drivers/usb/typec/ucsi.
>>
>> Our driver currently only matches through OF and I2C IDs, so it does
>> not yet cover the ACPI-enumerated ITE8853/ITE8800-ITE8805 devices on
>> the ASUS boards you are targeting. Would you be open to adding ACPI
>> support, and any platform-specific handling those boards need, on top
>> of ucsi_itepd instead of as a separate driver? We would be happy to
>> help with review.
>>
>> Heikki, Greg, please let us know how you would prefer to proceed.
>>
>> Thanks,
>> Amber Kao <ite_pd@ite.com.tw>
