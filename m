Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946168;
	b=Kly4sGI4KkIztEcULUtwgmRazDW+NzDCZjeN/oi2vymAOpZmrkhGAAWomMiNydl7PLuz
	 PU3PQ2Sxc1Hd/8JR+gK1MATsbv/4+JzH5FobesSd5MzsHYwyqCQ1i2IoizaQk6dJlwXrA
	 BrdqR8UYnP5cfq/WHEPkSqqEdSbmp3sXJoNxKRVaYStH6MmvhQnAcYhkhplQ1iVjd2ToP
	 +c4G9TeOJjeRQUzS2CJe7ll6qG2PfPh5gWfnloth8rpQ69m/H+ngZlr9pfOK5RX8y+D+R
	 behbhnpA1E0Yw0tpZXBEaidrliJi2DmAG2IU2/w2v4WpMHh6TETQnI8iRyQiMTqHbEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946168;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xobMW25f3cW1ukQgv8cksSp77nAYWp/OwUuvqXxfDTc=;
	b=xsuqcfKyyEHcvGL1HfpD1J9pMFqQlyNPFJk6lf83noa89N19VJkGtLi4x9+LhNeA9IyF
	 miWOroWCgWM9uq9bVhb+YJJjUk42Scr+KQPmKABhT8bQv1ENbHnyhdzcItmC+oIY0DIcu
	 3xqlPS+UJwOBLdQvyh10v+yo1o0zuGJNy3+rZTQq8zIwaUG8c8qVP1e8h8hVm6k4BBEaV
	 ZmBvEYkhJS2hS5B6I3uLW+0iSDGxoP4yNwTApLbYPakE8ufc0e1BhnG0RaoW8H+lmqbLB
	 ZBAp/SulWWh2KdqrJHSYMOSna5xBcHMLQSv+oPPRrrL1Y83jN5H4K6RDZ3Cjrs/Pqtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJDczKlw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4B606A32C
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJDczKlw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786E01F000C5
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 20:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946168;
	bh=xobMW25f3cW1ukQgv8cksSp77nAYWp/OwUuvqXxfDTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PJDczKlwWOTgyFoe9HctTF20r91TmGIrn4VKrAzgxxkkfgQonKExrtLzcvJJDXSdX
	 MYzF2NDEivE37UC9XU9ftrtVGWR3KHObITvOZjndePi1fYOgE2lrjQA5K7ByF5k8pF
	 D8SqAYnTxpWIb79IZken6oEG6Ft9cy1do+ng8MvSEF3f6lwQ1t2MR1h9NCgT/pbAl5
	 qhfgTIeDhiMj2acc9jgVOKihkQRiEHNoXb9solO95xCyBtDjILcUg59GadPQyvvFWe
	 VhJT41hKXVxQgqPvAiR20EOlacBCKIlnZ6sBQRpKXI6TSiEh0By8s2dLMzVH3j5J4e
	 jtYWAJB3IoCXQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ae5ab4fcdcso3019301fa.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 12:09:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFdMxd0ukb6ix8ZwK1KL9+2VMz7omRQLT7kwU2O/VtASM1qABhkFHlexqLAOp+1K4MewPU0bfA/h+us@vger.kernel.org
X-Gm-Message-State: APuU4Z/ugbLIkABIKk2ayEtUeECbCEAjgHn+PKcrJNdtEegxrhwG60jC
	3ArpVogLSOd8iik2bIClUr8OBTGobXsiaQoW0D7dmu6+Mzf9lNmgzmlW/+VyDHPLr7GjsVPW6Bn
	gO/lz4lM7/6/h/Ipt6gMzGWEhkCv2uFU=
X-Received: by 2002:a05:651c:b27:b0:3ac:9a09:b1b7 with SMTP id
 38308e7fff4ca-3ae670b31e0mr740631fa.12.1794946166809; Tue, 17 Nov 2026
 12:09:26 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110144436.1529000-2-ca@modelmiser.com> <CAJZ5v0jTHbr2KD3PXMdcOCs+QUrGrjGGuxOH7cbOe4kEF77d-A@mail.gmail.com>
 <20261116200935.2464922-2-ca@modelmiser.com>
In-Reply-To: <20261116200935.2464922-2-ca@modelmiser.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 17 Nov 2026 21:09:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gQgAAHWwS1ftxaTKHSeq1ADH7-Z6sm77d=_vWBrrkgTA@mail.gmail.com>
X-Gm-Features: AclHuK-CqX3dtTSoLW1P2lxrGKci-oQX1R_DqmMxIHKY2EAauwDBHTfATkyG-EI
Message-ID: <CAJZ5v0gQgAAHWwS1ftxaTKHSeq1ADH7-Z6sm77d=_vWBrrkgTA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: pfr_telemetry: keep the state until the last
 file is closed
To: Chad Aldreda <ca@modelmiser.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, 
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:09=E2=80=AFPM Chad Aldreda <ca@modelmiser.com> wr=
ote:
>
> On Fri, 13 Nov 2026, Rafael J. Wysocki wrote:
> > Applied as 7.5 material, thanks!
>
> Thanks. Two small things in the applied commits, in case they are
> still easy to change:
>
> 1. Shuangpeng Bai reported the pfr_telemetry use-after-free in June. I
>    posted the tags on v1, but v2 did not carry them, so e788ea48810f
>    has none:
>
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/178144969601.60470.350897430189995721=
2@gmail.com/
>
> 2. The message of dacb7cef6f32 ("ACPI: pfr_update: keep the state until
>    the last file is closed") also contains my notes from below the ---
>    line and the diffstat. Two sentences there no longer match the
>    commit: "kzalloc() rather than kzalloc_obj() ... for the stable
>    trees" (the code uses kzalloc_obj()), and "No lock is added. A call
>    that passed the removed check can run during the unbind ..." (fixed
>    by c0ab3714e87a). Deleting everything after your second [ rjw: ]
>    line up to the patch.msgid.link Link: tag would drop them.

I'm not really sure what happened here.

> If neither is worth a rebase, no problem.

I've fixed up the above, thanks for the notice!
