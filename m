Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795305634;
	b=K4etnK6xVVxQHqpXxg/zFeP2AlgP+OygEKZYn0dghrvcQ6EI1wTWoAL3I3K4PX9GYCY6
	 6gUcXkvDBK0gsiDpmCojGqiNGZ3JeYGb+KJBprXeFBJIMRCMIuWgP4xQguMzIqXTMhLvc
	 S8J+6qvpK+3rjW8CePr3YtSlHzU+waXK7/D+xx/br7m70q/PI+OPIjuENxh6FRlFuE+WL
	 dW6F/J7YF7hJhhl5ZbRnV6aaOx6alZg4AHIs1JwKkcwemCKSF1Q6xXtBs1DBJD3rv2sKd
	 tVOy+K6LDNIpKpHaRcrQNbiChgQoOSBtn4iTi07hKQ2Mgl/62+deuYTSDm1r25TfOTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795305634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oX79inJRzxgZwR0Tcie38RtbzYQdIj/eTCukvbMNytI=;
	b=GSm8FS/xoYYanMRDbn2LIg6uHhFTLFzmwk+msTW3u8ApZglhrO8RoQvWkd08tKabO/Oo
	 09xT/rYOL2hZJpgIy6PZ7/O0TUVMp/gmMjxVHGoHxGn6mLVKKrLpT7CAGECE/hA87WCOi
	 0hmczv5dFGwFeOJ36uhU0pV3LeIDDUf0oQ5SjbOKi0ZZCbyvIHnzebWd5bm2+6fPx44cu
	 VB2ELf+PBOEgVOL699Mt7p0bq4yJ5kezURPeDSU0QmsAXLo8fhI6Oasg9O/7pdTKVX3a4
	 9YcBVZZ7hDxkk2fwQXxP5CBwOytTGQoKResmx5Txfyjvrj4If3c08scbFK84r/ys1og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4RcuYCf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5334606A336
	for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2026 00:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5334606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4RcuYCf
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-862b090e3c3so1191015a34.2
        for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2026 16:00:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795305633; cv=none;
        d=google.com; s=arc-20260327;
        b=Qe4NWtPXfi+eRq3iKSvFTBrk3YYCzMUcVg+2dddex9Y9jXwpe6g8OR4RmqpkSPWteM
         +2Fg33zkmlh1rOEanxZiH+ZeWXuyfdQ29nTdjLHGyRuo5NJ1JOFwDyN8KHBwb7AKpApf
         idJRr8a0ys9d0uFCMHKHRA8Ew3wcT1/BSr/aeZSKWaHdt4G+kpRXdXq0GL6mtL4AM0Lg
         mogHpZpzIgXz/QEFgqg9VOPug0+w4FwEgHkdYfTHGZGd0RTrIIGNY9V06jZ/c0ftI6bJ
         pbzJ6sv6DbcKK0cvTGb+LGtL5+KBDKGH6SQBihFLywR7HOvI413D0XRQZRvalbdoUNrX
         FGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oX79inJRzxgZwR0Tcie38RtbzYQdIj/eTCukvbMNytI=;
        fh=bnA3vrO7CGEPqUCrHCtutRaSx4WwrhEea3uEO/WglX0=;
        b=rV5+idiG7t2YILqnF30cAM39LsZDcI2Vf451TQnhZGcAKr4LBb1NOpZUNmD7qUXpjq
         mmx4P8mRnIdp4rGZ3yngXjZDuC4v/o+LgmcNKFNP4/npGo+5hHQ7hYD4UgYbwM7ihOOE
         GFfwBo72oFoXnqhn43bv2hdsVfcXGKhpVc2SMO8ELoZh4W81trgqKcVuDodUoEh0YvUs
         Be3rouQ2Ns1/Yqgfr+TmONkTGEo5U/TzkG5wu6Wgz0mjSHYyvIc6VQOLmJoI89TAKBD2
         TYNm8QTSK/+WDScjNs1yIYVNfSeKf09ATWCUbst2xlMgj6230hwjFTf0gzaI99WJQgFG
         mtwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795305633; x=1795910433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oX79inJRzxgZwR0Tcie38RtbzYQdIj/eTCukvbMNytI=;
        b=r4RcuYCfIn90HdIwxItumjaK30zdLhmUJVAGcRQ71nWGgskz24QbkTinofHlgkbenY
         G4MS+YOI2jv+T9Xu/GlYrHhhMxTKnQSORkt1g1N9xvgo09K+WmL6Ol4n4KlM7ZnHdfYH
         Dga8N+dVnRKwEx03n6ZRzaZUmZamKVkc3zEM3qYrvuR/ZiJ6LVd5aEscodL4zVuRKxr3
         1CeCqEP8fs5yW/L1fJ7f2jpubwiyYMJLqCP2Y6+Ydqe1XIaG30BcseHXiwDcr3LDh8h8
         aceKX/ezytlgYuce5vlrWJqmIhso+LfDOfRKsao1qd8ZMx8JiPefxktTgvAjr8j03MY9
         f62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795305633; x=1795910433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oX79inJRzxgZwR0Tcie38RtbzYQdIj/eTCukvbMNytI=;
        b=ik1dwqNDBTz6mEKTg7PM1le3zVAmQNcn1P/pehkveqJKVwggaOfjBn7z+yqxokiCjP
         wZgUULvVn0XQcQBvJdAJrwcrUtjM7X33J5Tmm2oFTG9DC90OzmWB7KduZdXAgm7nZ3EQ
         KQFL2x6bZG05qW9/V+wlh9LAQ7+IdfzT2XYEBtwS7HB1zXSuO/AifRdINnrH0zFWeNDD
         nuc9w41IJ4JwtfRNRe9vjxnUL2/xZkXM+wVJ/S4VPzecNW87Zj27n83v7nDtgIY3pd0Z
         DzOKtUcHYLAYYCyCYU3id2wLjHRRBXdbB7uC22LCzMIP/hTP1aasRC0ZfeF37tMpyDtR
         ttIg==
X-Forwarded-Encrypted: i=1; AL+hErG7By6lUvVDgvAty6tfThXlJTtFMe0x+wkiUuba1H1KTRSqpaNwRTAF75YiSvZXQXGnTfwX00XfzWmx@vger.kernel.org
X-Gm-Message-State: APuU4Z8HS2nUUF2GSjrgkKNiXRPZ7/oxhD/GmPTgODPmchG4RrQP412F
	JktsJ85lqpMrWr+SoKAPo+VlegqWOSs2zhoKnV9y2bqe4fOfDqkFgaqJbyrNnV73IRePaYS27bi
	Ti0zy12vRQcsIRTHfayRKtoV6WmvI0QM=
X-Gm-Gg: AZFdTZeVVU12Bjq24UCkCVgwN0O8947yics+lq+JpTfKql1TUDOSo7L2eOMCSJivsUT
	U0nhWRnl7Yv7LY5CWnb8pBfU7t5wphgF6jUWqtQIaPnvptKJZLfnVuVXuSjiNT/jebiGKODQq0c
	St03xkpq8eNuj8xlDknbu1e0LSsbI50E8q41kOaaSrph+gEBVDJo87PKdpG9GM8k2+uXzCgieF3
	hY1I1YzmVLVXBcVVkcGOrUHe0As/3QPxvjgUubVNc1xFF8SyKTFZcwpwnNXl0eb3dskdnhhvg4Y
	95gCMyZOuERDD4+SP2sVtLg4yMawji4DfVfPRf5FSDKN+wAupntsJkDrzaS1FtP0tJU7DFVE5w5
	RzmhS3+hoyuoDyH7m/zDNqpej0uSYjazPkjsW
X-Received: by 2002:a05:6830:6a88:b0:863:3a1a:91e0 with SMTP id
 46e09a7af769-8633a1aa039mr1043518a34.10.1795305632770; Sat, 21 Nov 2026
 16:00:32 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-3-shijujose2008@gmail.com> <20261017055852.GBatMOnEl66YObvU5k@fat_crate.local>
 <CAG4KcR+NOKHNzg6FN-oLLHgUxeitZHKXg9cN7dz24+Ap=RrwSA@mail.gmail.com>
 <20261110071729.GIavLFCfLKzPx8R0i0@fat_crate.local> <CAG4KcR+ikfQEBjCZiNJ1CUz=u3Gtbk_XDroA_GQqYpgO4Lo5Qw@mail.gmail.com>
 <20261121194030.GBawHzrrCNCMpfr7Gx@fat_crate.local> <CAG4KcRKhE1UXwrhscUdSpDJS8R0t7kWp8RXZm8j_9yXYJSQ2KQ@mail.gmail.com>
 <20261121210749.GCawIIJcidCeWs3ij9@fat_crate.local> <CAG4KcRKzXNsvBWuuU2_aX5gO7u4vgKAK+bkrB2vgEFBGu3WJCA@mail.gmail.com>
 <20261121230942.GDawIktifTKlYhUlpB@fat_crate.local>
In-Reply-To: <20261121230942.GDawIktifTKlYhUlpB@fat_crate.local>
From: Shiju Jose <shijujose2008@gmail.com>
Date: Sun, 22 Nov 2026 00:00:20 +0000
X-Gm-Features: Aa3M54qnCHZib5IMTc_EQOb3UJ-aKnrHrCYP9h8mtw0fwRaNzLI4HvK65GdTkSg
Message-ID: <CAG4KcRJjU9WB7o0woOaAhtWDPoaL-52T8MUmbYJ9iC0EqP93Cg@mail.gmail.com>
Subject: Re: [PATCH v23 2/2] ras: mem: Add ACPI RAS2 memory driver
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com, 
	mchehab@kernel.org, ashok.raj@oss.qualcomm.com, jic23@kernel.org, 
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, 
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com, 
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	gthelen@google.com, wschwartz@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 11:10=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Sat, Nov 21, 2026 at 10:24:28PM +0000, Shiju Jose wrote:
> > Thanks Boris for fixing this and verified by testing.
>
> I cannot test because I don't have the hw. I rely on you to do the testin=
g.
>
Sorry I meant I tested with your fix, which worked fine.

Thanks,
Shiju
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
