Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794341724;
	b=SVzDQc/+XATWSvCVORZuMXcgXenFOrVniJFOmabs/hQwIP+FrXX8L4lfrKAR8XwhiAss
	 awSkMnBPOvNLmy+/rujKIW8ATWBH9+qNoJQ0kLEw6GqtW6Kvq4fs/6e7JXPFTJb4HcJ93
	 My/tOPkvJMrCJDlfUoK3cr8+8vh5gKlAVxcP84Kdh301ZocZRZdZxCNYj3KJAbp7PY0or
	 UlR8ZZs9RxKaJJWgc3/sOJZ6WsIw5U7j284n++gI0oJeY9Y/5Q2LQUkfSLS/Ush1VRKIa
	 x0nw2E2FILoxRVl6T0LoiHTotwwZ2BugBnBy+mCydzSYd+Z6uI0M1n9CE8NdPs7mTcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lJiT+8IpY9D/26sFc0x6AV66fD9LP1gmMsQhUCQo140=;
	b=oy5LeEhe7guSDjocM5nnyCb9aDAfEhZlQUqduDwsTZcLA7OT2b9/ubrmVQxYsYqDgQWt
	 6PTl8elzvF472j2Njqer53SABx/jlWurIE6JgXrtWIjkfHM7KiNedzILEmq4r5Uq9eOK0
	 qPDbAbniDOBbt6UXYSt0vYk3RYIQWipH5ZrYEoJINQIrAAFaFqr1sQDRE7DwUY4SJGXrS
	 eY8VrlguUnmHxsODHYrleeeO6rrvz1L3q0ugorwn+pHNa4+wILZ5qBYF3aCfiP8R9UgFF
	 BzdTVNm1COJftxdCWe2xPZUUggBJ09QuC1Zrk3ZIntkpKbthb2ZhHDlB8rXBn0VbXMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vi0rRR86;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B41606A320
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 20:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B41606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vi0rRR86
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b30ff12f84so18795027b3.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 12:15:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794341723; cv=none;
        d=google.com; s=arc-20260327;
        b=GWsiJ8NPzUc1FCVHl3VhLD/lPrjR8zQON8ZOkFEVEDnUZLJe9qcvgL81f4HZsDV58P
         c81zKWXGPbXoXnMGCGaJ5dlw6jvjdCo2eNf8OaqUwKFl5bTEYCZillun3VyoZQDPzAsn
         VU36L2Zor77uuyrD25UA6B9Xv5sfxTTpyQGW+6hq5q1s4O258Z9HgsHksszOoqwnT7vl
         kDRFaiEpLk4/AwlhuJt1Lk7kgmyyrC/16i2v5vuRqFGqG9i98JIZZKsPtYv2Sk9Evtih
         Ck+cdiwvzPz8NWrKup8HJaPVq/9NcpEsrHwqXDZlCs/CsroZLvRqZYl/197FzHVU8Oh3
         p2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lJiT+8IpY9D/26sFc0x6AV66fD9LP1gmMsQhUCQo140=;
        fh=OADeAYWO6bSTboYHwVrkwE8exWkOaAgPQ3batPNlFWc=;
        b=VoqLY2VwFKYhiNfvfNs40R2Tf/CP/BrTbxWtjIPyOdN1wxdJPX3hB0rxLbbdt0PW7E
         MdYdLUkZCd90ehlftxL+O1PpWIzy4ex6ai1V6+aK1lgvtwfjSDLnq7YArDbec0vxe/pq
         qqHqN3UT6TseYDKyCki9bD3voswZ1we9fuJHpVLZZpVGQA4/kh76Y+hQMNAeHF9HGXE7
         xSXmVWR83nIt3EAmb62G1IWGWlkmlATfxhjSryNltlilimEYmh5+6ZGygDUQHL/RTICo
         tBPsNyTpJPAEQlmL7nPAzE04vPukwt0Mf9fze3tvLf48Wfb9tvoWelhm/AvkWJFZUgN1
         o1bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794341723; x=1794946523; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lJiT+8IpY9D/26sFc0x6AV66fD9LP1gmMsQhUCQo140=;
        b=vi0rRR86rLgaCrpxolO2NCtTdCGuzamlnVzJOpe33bEraVmDP6+GWqGypTu5hO4688
         gzEf8o0cDiBwAhmSQXGSlZTrXEjGYDy14awolWCbz0qTb2KMpsGWyR6DYNYmAUgTlDCU
         CMk5thnnAmX3TK0NBjNMaxg7r/AvXoH82dYxq6HhkeOnfsPrf3IJ4y2ksurH/ID/+ju3
         aPYuRRCxfQ/ZZFhAwNy64a4/HX3546ldnSlmP32BJeTvbP5dbFyY9n7nb5IUAc7TFP+F
         jUsQUR3zZp0w1VanZ4zM2Ju+hQ+5r+2XmtEcx0BCwY5E5KUAtMw4H0Iy6GvLsAGB7idx
         7w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341723; x=1794946523;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lJiT+8IpY9D/26sFc0x6AV66fD9LP1gmMsQhUCQo140=;
        b=WwY9Ae5m9gipZSBuO/iBXnZpz7DF9s+3Aed37nCiyUX5g44ct4G9sKQIyTO93D8sye
         FzDgi8heoK56xjCH/r4VaY2AA7UrTshhTukvW/1nYN4ztnILrGbs0yXkfrIDjjbjF2M9
         5FoDUPRdonfa53n9Ro1FRTUG+zlMxX/iry8XTeCxgLSYHV6F4fYR8/H0Tbr5bl7Wn9nm
         jHzKFnLYwCElhyurMKVsp78/T3ktwluvya+kKxoKqHGFQ40GC7k6XUm6ZdPsbjdFemSX
         sGh1926Qs9RHb1PsbqWwyflx5q3DsDRTmVqoKxkqdUvDNffiPpyATS8YlWqI5XshPQrl
         rKeQ==
X-Forwarded-Encrypted: i=1; AL+hErFTP5RgkC+sQlOE79Pm81AHEnJPesV3wKGTvLWFZsYHP7107yoxNj5nfs4ujR/uQrdJdDZfrTE51XDF@vger.kernel.org
X-Gm-Message-State: APuU4Z/SFaUwqnx3MgaZ+MFM1kqRPYkT0DQvBnp98oOAmUEHn16tnw5/
	XD/nmlW05vyOD+a1Qe5jCMcczB2gaXZsTmrBJE9lqcuo5GNKiSkaiCad26I3SYYbv7Pys6CzDwW
	jseIy8iVPAeSkXp11zcdD1gNm/xIXO0nXRx00
X-Gm-Gg: AYBFou1IYPQn8q0X0hPRJhp2DVk4IiK+2+xTZQkUqPSlWrp93AsWQ07AZjcdR4io8Rq
	WGbb1lClIMmEswUNFeslBNkhEjZQLSWUB1scpZiYDVgjWVVb0sC2uVzTLthjoyK/ll+0Pnz9x1N
	j8HkRvU9Oh0fRIPJuiDJyLTST6cIuwcca4f/QkNjaxIEl49bjOy1iKhE1wxIiM3JUGGqBttqIAd
	6E8Udqmn4qpicfn809iLa5ZGCOXtwvryMtn5h+5zfDM+QRz/MhaYV6WZWU+ZPPnG7fcLJOGNs1M
	WIfPlqlcNzkwwfSyJKt6HE5ECdjSAX4DfrKUmGKhoxLywRTrHQrfVTYQUYJHH7qPwtdm06/S2Wb
	m8CZlNTmPJACAWu0qOvds2Hhyp/zR9o8B2u+nLvChueG9mo8j8WJboq7put+tcgjf5j/cVhk/0D
	CllW0zjwVjFRvk/8mjoOvmgcybjDGKst1HoPnA3cwIBx7KHwMUIOVsaqbMdknsThN1Xc60K5l+8
	PCBe3BgPA==
X-Received: by 2002:a05:690e:43cd:b0:67c:28fd:8f1f with SMTP id
 956f58d0204a3-67c67f77ab2mr227205d50.57.1794341722999; Tue, 10 Nov 2026
 12:15:22 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109210146.57766-1-sidchintamaneni@gmail.com> <avI7g14oGpFKlJnV@ashevche-desk.local>
In-Reply-To: <avI7g14oGpFKlJnV@ashevche-desk.local>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 10 Nov 2026 12:15:10 -0800
X-Gm-Features: AclHuK-s036JOQbw6HtDykqOqg4xoznKSez1GVAhjg431vKNmBxRayoAL0gmlkM
Message-ID: <CAE5sdEg3VKZuGqpt1Sm22Dsuh8HUFi-9w2GWEAicALS4ECXQ_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] i2c: designware: Add ACPI ID MSFT0006 for
 Microsoft Cobalt SoCs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, apais@microsoft.com, rlmenge@gmail.com, 
	hargar@linux.microsoft.com, Jarred White <jarredwhite@linux.microsoft.com>, 
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 13:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 09, 2026 at 09:01:46PM +0000, Siddharth Chintamaneni wrote:
> > Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
> > on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
> > in acpi_apd.c.
> >
> > Without an explicit MSFT0006 entry, ACPI device matching falls back to
> > its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
> > the controller's actual 300 MHz clock.
> >
> > Acked-by: Jarred White <jarredwhite@linux.microsoft.com>
> > Acked-by: Jeff Kirsher <jeff.kirsher@microsoft.com>
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > ---
>
> Where is the changelog?

Oh I just dropped cc tags.

> Haven't I given a tag already?

no, I thought you were suggesting that I repost it.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
