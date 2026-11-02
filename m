Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793652794;
	b=D6P/UPsAnqdPVrvVxeML3VKtb5nEXwcEN8PrCZY1ULFYbExqF77A0t/9GBxHYgq6dmY2
	 6fCuJy12AcyzJCLMgoJJAduRlu2zTbZpvU4WspU/yZ41PDqqe3c8Cq4fw2/8qIyKNwniq
	 14qSVVf04GdSWFxHyETt9x/RLGkEyAa1YKZWVR7bCUso2zz0y2//dtk12gySjTXXiQTvZ
	 kvLPlJMJoDfkAuUoG8l4qXpVU6QjxRnEjjgi5H1lLRoN9IPOgZdxeHmrbkvbOjuUn+Bup
	 K8lwC5kWc5uON43XTfis7EnRP8PJb22fvmArLi2JR7Ql1ZdRS7auYVWS/vFGFtXlnKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652794;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=MQiHq7A6R1DQboWHCZtXqfzX/6d18KTzCMTz6VE1SCbclxjcnoW7fYHPim6KWr51pOkr
	 GjEm/UV8NaI5Dphz2fi8tGzV7VOwG5UVhKmzowVU2hYlzMEoG3wbr5sk9Oq+XMgiHBVeH
	 8B9FpyhJLHUoa7U5la2E0RgzZO6Pg3lGyF0Am3Zn+JZmpCd1Ahk5rS6n83o0s0MnKurjH
	 epoM5ql5/FNvzfcZqi2xNowEZm4BkDPTmEukr0u4bPI2FXnRqLwPzaF3BalFZCcxDzPNp
	 r3xQ8k6qw0Wl5Hy4nLik4GMUdl6qkybYYstRFDDCkpFej+t/QmYTBeYIia19f9TCV4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ILbC3qNV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20293606A32C
	for <linux-acpi@vger.kernel.org>; Mon,  2 Nov 2026 20:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20293606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ILbC3qNV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=JrjqNRqP10lz+xwTaT1N5hOMraQMewbNcL6ZPtYs/6qBeMDZq5lyggz1hz5TUE2wvCqKwM
	IXQbQRbVn/7mLpXXty1C0A86MwLFP717upzSrzHF5Nt1PiF43MqFrw00/Vf94oFs2+EMGE
	o+EsfhfOm9/h5ijPwHR98WSryq3gxtk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-2i_AJ8PnO9OAYm78qOk1ww-1; Mon, 02 Nov 2026 15:53:09 -0500
X-MC-Unique: 2i_AJ8PnO9OAYm78qOk1ww-1
X-Mimecast-MFC-AGG-ID: 2i_AJ8PnO9OAYm78qOk1ww_1793652788
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3ab3061668eso242301fa.1
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2026 12:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793652788; cv=none;
        d=google.com; s=arc-20260327;
        b=r0F0qPytueVZUdht6XNvkr6MxMa+8tG8Gb6Eq6iHQGg98LMbj4fTF9O5kip9leYYsE
         SYGFQM/28KbaCKEnTqm9yd9QA/dvV4mmGIFjEimK3rV3AQtsViI1czzbVH9oxzE7tdQJ
         Q3uZLlms+5o4wYGwm3mde0YScQD7bwYd/DmBOm7hZPkmKKF9uWid19X6YiV/c18GGbUG
         sxdXUGbMv7f1YqfOTvoiRBorKGTAra9tTWxLyj3TVqvvaFVefaUr4iPnsaoeF+0aXExJ
         8afO0jVEzI8gt6FyH7zrVlp80bDykkDZFoDPZmAmx9sgL7Z8r25DBv8vG5Nw/DpVMEGV
         BJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        fh=loV/ISOJDG8g0YHcLbxNAxkNcuSLKspTr+IvmG+4ims=;
        b=frs9WluB/z3Ob1qwzJvkbposoeb8NLXTJKqfPqLBcALr9Z73Kw/NAMw8gIP4Z0e42n
         Uon+lyuWwEY8FWWNs/fkCajLR9Z5ELvzj0cOmRPH7pwQApx4xdx92A+JvIdyIeCPlWSh
         AWBuBZsJ0FzP0i2uO39TtR+RPGoVeC1BS1VUB87god3aFWvBg7V7RfjY3Sx7Y8CApRtN
         ziGMM601YTHaUSzhjWihsiqq/Ktwid9N3ioNQcPQ6dGSldxhSE9cHe0TWkdGCht3F+fR
         LruCjexTgahgISxJxEg4PUBBJkqtUaCH7v381kJo+gQZaknSePOHpG5rFKiYhTun6UyO
         ZJfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793652788; x=1794257588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=ILbC3qNVxcxSfLLqiEMczm2K9EWJDHjQ3jtHiRo8lvs7xOcCBk9KViZKbMYNn3rDyD
         1nRBZKRZevJudcNGThw44x8q3rGE46+/V3Lp15cYzXfiXGQHqy3zvhO0o48B5BncA5Or
         KbQ3kcHqkQQMolwwbUP9ub3434QutGVu8nmoCGzc2PCEhLmjOocqh+8d4XwIGdidYoBZ
         1xLTej5dBNXaVOsg0H9ykUYcbsfyfY1xRAFquEOh1DF007rqhduAsvbJpJIrCtz2kQKk
         jbQ0GJtS49pjk16tDcdcdHiHPoCzeSh4Rpt4Z21PkzyRrg6RuTlgqDQLYpdpsCCp4Dam
         yDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652788; x=1794257588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=SxM5mKLOK5wcteAfcyvCG0JEsr3LG75UNhyBNfxtTeiv8inUDH/ZYCtxTbVxErVimo
         dhkSmX2fsyDf6qTEYDXhnjFiVx/nctYNpiU3/CyP0Hm+RIkzOJBNOZqcJQAhHSqg2ORp
         R0BLe0aIKPttPlRMhqxmpYEIrK07uliRp2TwhJ6Mqwj3BgqAiHyzN9iyCJWvPKjcj0gW
         94FNvKd+4FchgDescBmXiQpafilv9eS1V2cPgnwvyDpUHkQgZnAveY7irlyrGSHJP6S0
         Om3nrBZ3B3oI5rTLtg0vWjUUrr33GDej134UPFVXH9+MMx/2doFQeR02/JhuAY0k99VJ
         Ao5A==
X-Forwarded-Encrypted: i=1; AKwUvBzcbk5T7G/bu+6L55DGOd7PFaYcaJ9JQBND4xJsUNgQwbeQnp+ZFFEnVnjKqeHnFOWU/xK+QmPeIQFY@vger.kernel.org
X-Gm-Message-State: APuU4Z9VK3EeUWSmsPW3sQsq9vo7n4E5LiaUMZfcEQa2Z/qorCMT+Uji
	9PxkWUMKZrIJIvqthsaDErXCuvae1L3a107Byx1idfAwz+68kzRRxuHCXsjNIO/uYhGgni5NpSA
	/YTiYsbD1REcU4ffBt/X062B5QanVMfasTkv4GOkp/dZTBJRgGiYL2/N7ztMcA634dYnerpu2or
	FJMP9tstG2E5oJRvL84nLGFuq2MfuRvtfYjz9VTQ==
X-Gm-Gg: AYBFou2RvJkgIZWS+n8XY/eshdlhwYgP+UzIWH53StvkUMoZWiR7hZM7NWUUabEC2c0
	EPIq0prPAKWdbROZRf+TdEYZCtlYGZobXosl3i8sKDal6W7T0gvkTNSbRhTO0kCuS3OkjeK9Mv7
	zJLTYH5pI3LZPIOXKrhZuM9icSI5FC8czR2MYKFNoYJgEvltjfHe/5ORlH
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id 38308e7fff4ca-3acb7aa83b1mr20499211fa.13.1793652788265;
        Mon, 02 Nov 2026 12:53:08 -0800 (PST)
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id
 38308e7fff4ca-3acb7aa83b1mr20499011fa.13.1793652787872; Mon, 02 Nov 2026
 12:53:07 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-6-irogers@google.com>
In-Reply-To: <20261027223847.652884-6-irogers@google.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:52:55 -0500
X-Gm-Features: AclHuK8pGzNf4aGPekLa6NQcs521xOugw8djA3E8ZMCjZ7yn89XzG5j_wIaQNFk
Message-ID: <CAK-6q+j-MS_5St04YFU11LG_Cjf1jOuS3q33qk_iK=7TE-iuBg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
To: Ian Rogers <irogers@google.com>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 27, 2026 at 6:39=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Signed-off-by: Ian Rogers <irogers@google.com>

A somewhat "big change" for just a debug functionality. Althrough I
agree we shout call "kobject_del()" early to avoid additional sysfs
changes during removal.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

