Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184087;
	b=OMLzl6f5omxC1XbcC2MbwvqpSDeIu//KRnwXlP6YxZt2HixoW4T/yHQrBwwtvWXQi9f2
	 YRXIJuFR5m9jQY5VWMo+b/Ecb61WIDE3jN2XQBSMgS1uApY7FO5e8T09DvCOBSQKVQMOW
	 IHt2avUrFTNszFlzBqe0bcWMcnw3goxNOdJXCYHYwwsX+G/qi+JxGNory/vrh/+2MycnA
	 1akaBm72jKTj72Ty6LxPq4eKyiZ/u2iNVfQjCKln4TMI6weMxyVYaKSMg2ycFNs8syhnD
	 KgQzCMyr80uTFwPMskQwujnhtt0ONE24d02FncqMlLzqLdEzzgn3yxILU8mwb5pKZZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184087;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dnxxg6F3YNHJ5tIqJyZzkJIccsYuMgcijR/B79RROuk=;
	b=amaASHE8VKlW/ThSxAt2OGh5dPnM+sGU1zEHIZLmMJXK5Ndrvg1xQ+iCPeUO5ixTuq7o
	 vvwQNnkR1Vlejj0gWQOaD8g66/lpIuUbLC9jE3w6YsvUa5YR0eCeMHyfHVOf4yYr50S7l
	 rDfYyH20ufsFLS4dpBpET0pJ0gKjIDex3yLQtuRkgeYlNNGy/96khrhbsmnA8JbWg4U80
	 jNkKHPZqxghlvyMCaKS8w8N5EbQ1glkcUxHLfSus27sRlFgFS0GTO5pM8IbGfSdvlMZLr
	 ZfXxzKNE3FdrTbhOkGgktECwz5OJOEqxyya674Hlh75SSNG0NBKbVZADXlq6WTgXB8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORAykmni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65743606A32C
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORAykmni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1471F000EB
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 14:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795184087;
	bh=dnxxg6F3YNHJ5tIqJyZzkJIccsYuMgcijR/B79RROuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ORAykmniYijHZOkADhSgjU/fzDOyv635wEHseBSrT0A1ZUxMWlBJdqiiOFfmN6Ply
	 HCTx4JjbJ8va3oS0rVBfBb8cwVHf2SHlCniQpHV/ZoDQPOmyP7SZ5ukRuxK73EftUk
	 pAQiFLAsgF8gWfFeiotXPHUU9fVZZUABNlOAsMUpWQuU8YNAQls22v+4TdEAzDQH/s
	 nPdexCO518PlATtSx20PyrFPdq3jYOEQ21e1g7u66gpATMSJ/s24gkpoH+1tTjBcj5
	 iqC1S9g5zJ6ACmq6sBOhlCRxHixpygM5Eixj7JfLEakEto7QS6iplmdX91UhwIHuhq
	 ++Lk4HcRHZ32w==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ae81ae52ffso5924131fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 06:14:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEwMwwFF5LMCg3rwUgzXOnaWuCbo3jHdEcVtmPt+xTo2y/zS0iG771ni+ZbqtDjXzMpcFm7svTfAd15@vger.kernel.org
X-Gm-Message-State: APuU4Z+yLii7lffJupXOeNuBZ2WwR8OHo6OZMYyPESDxyXIlf+nbnNl8
	KZgeOoEar292Bms5dA17HPH+sEz6gXEkghB/8yBMkqeGizssgr+8WEGlIumuiTrxKiOarTL1VVD
	1GXMTsZQ9wRJYbvA6L2BGnwJHBr/Ah8g=
X-Received: by 2002:a05:651c:a1a8:b0:3ac:48a0:e253 with SMTP id
 38308e7fff4ca-3ae7fa1a13dmr10878491fa.23.1795184085597; Fri, 20 Nov 2026
 06:14:45 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117091534.895868-1-christian.loehle@arm.com>
In-Reply-To: <20261117091534.895868-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 15:14:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gXd-ks65-GxuzvSfCtsHcAetsFe+ofTsXSCOjqtox-cg@mail.gmail.com>
X-Gm-Features: Aa3M54oLq-mWMU5TZaipZN5wQVcszTvM9H8NHBYEr4LkukbKHEN3x4kqPnPmul8
Message-ID: <CAJZ5v0gXd-ks65-GxuzvSfCtsHcAetsFe+ofTsXSCOjqtox-cg@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: processor: Restrict unsafe driver removal
To: Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, ashwin.chaugule@linaro.org, 
	al.stone@linaro.org, miguel.luis@oracle.com, catalin.marinas@arm.com, 
	Jonathan.Cameron@huawei.com, gshan@redhat.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:16=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Hi,
> I've had the ACPI CPPC lifetime issues on my list for a while, but I've
> been hesitant to restructure the code again. Looking at other users of
> the same removal paths, I found independent failures outside CPPC too.
> Do manual bind/unbind and processor module unloading need to work, or
> can we disable them for now instead of fixing each affected teardown?
>
> Manual unbind and module unload can tear down state still used by the
> acpi_idle cpuidle driver, processor_thermal and cpufreq. This series
> blocks those two operations.
>
> Patch 1 suppresses manual bind/unbind. A second unbind after a nominal
> rebind dereferences an acpi_idle device freed by the first unbind; QEMU
> with KASAN reproduced the use-after-free. A separate test left a cpufreq
> policy capped at 1.6 GHz after processor cooling was unregistered and
> bind reported success. Manual removal can also free CPPC descriptors
> while cppc_cpufreq, amd_pstate or intel_pstate access them.
>
> Patch 2 removes the processor module's exit function. Its cpufreq
> notifier otherwise leaves QoS requests attached to policies on unload.
> I can also reproduce a use-after-free without CPPC: unload processor,
> destroy the old policy, reload processor, then remove a replacement
> policy. Module unload can also free CPPC state used by cppc_cpufreq.
> Keeping ACPI_PROCESSOR tristate preserves late loading and load-time
> parameters while normal rmmod returns -EBUSY.
>
> Ordinary CPU offline/online does not call the processor driver's remove
> callback. Physical CPU ejection does, and is outside this series.
>
> Christian Loehle (2):
>   ACPI: processor: Disable unsafe manual bind/unbind
>   ACPI: processor: Prevent unsafe module unloading
>
>  drivers/acpi/processor_driver.c | 26 +-------------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)
>
> --

Both patches applied as 7.5 material, thanks!
