Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057843D9023;
	Fri,  4 Sep 2026 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508624; cv=none; b=blbNYRjObJx00B1Jhp1cPncPCy1kRiBmx4u4dojfPvcrcVKxVs+609XHIZEVFoJA6G9PtUUc7JyRQ47LvTsuNg8t2I7mwyagCgSIub8j7cZcw2KtDx5YjwySlxNtHYPcA/8HzD2BvUwkEj9VaLFXEmH8Ge6in81ztSQSfl5pYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508624; c=relaxed/simple;
	bh=oWVklq9ai4S/bCG05vOuUEy9uf8pMgH9ircR33tv2xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ypb4J4KnLMYIkzN/r3o/RlgciuoKR2deFITfl/LC8kZwVB9EuuHRpRJFtnsE7vzncPfZ/h2ph22Rvz+QnOeRU1lvqh3qxv4U3UPJCyaKc2LuLhkE9TzXfbZs8Xt6PJxHkcL+0srBIX6XoBgloxsSb/2w03TwbLAKfekYlboc2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA41xhIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA41xhIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0105D1F00A3D;
	Fri,  4 Sep 2026 07:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788508622;
	bh=OSLjWQWyCpfRxWfLXacqeixxCMB4Dp559C2UBIbZd48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nA41xhIpK0e/3gdQ0bY/jVg8MrVq9RIkszH7MZhP08IakBQWe5dEfRZaigI2CSomY
	 sGn1JJm2qAFW8VJ3s0MBoGuNDgBdrhfslEvjQPg9Y5VSanJSiitnlZR52bSqLwNQLO
	 ugotR4KZN4URDBGrbMFpyeOxlCqYdqihpNq4nYv/rv+Hex5zuCm+qIgLmkHLmjjKZR
	 4S5QUgsaFn8U1GhSGS/j2B0XXbN3RFVhdSdMZ7cQQLK5NFV5DfcQ4MeF1UCObwD19Z
	 yTUJd1aBRhO5jlLtoFmbwCiRVakONj3rkxgLE2PdLFW5/YYNJdCsbpKu8nF+UiDm5a
	 3FRertvrzeqZw==
Message-ID: <0587c422-8279-491e-b377-af623e13366c@kernel.org>
Date: Fri, 4 Sep 2026 09:56:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook
 UX425UA_UM425UA
To: Bartosz Golaszewski <brgl@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, Kivan <vaknins33@gmail.com>,
 Linus Walleij <linusw@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260821070651.39763-1-vaknins33@gmail.com>
 <178827844334.39529.382963115769227795.b4-ty@oss.qualcomm.com>
 <aplfrNXzNvgbMJf1@ashevche-desk.local>
 <CAMRc=Mck+ft9wmWQLcq4uFTvH9u_rB_bFQ6tGtG7YkYdbowJaw@mail.gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <CAMRc=Mck+ft9wmWQLcq4uFTvH9u_rB_bFQ6tGtG7YkYdbowJaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Sep-26 14:42, Bartosz Golaszewski wrote:
> On Thu, 3 Sep 2026 13:53:16 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
>> On Tue, Sep 01, 2026 at 06:00:46PM +0200, Bartosz Golaszewski wrote:
>>>
>>> On Fri, 21 Aug 2026 10:06:50 +0300, Kivan wrote:
>>>> The ASUS ZenBook UX425UA_UM425UA (with AMD Ryzen 7 5700U SoC) fails
>>>> to stay suspended in s2idle (Modern Standby), prematurely waking
>>>> after 1-3 seconds with 0% hardware sleep achieved.
>>>>
>>>> In the laptop's ACPI SSDT tables (SSDT15), GPIO Pin 24 (hex 0x18) is
>>>> defined in _AEI as ExclusiveAndWake targeting the PCIe bridge device
>>>> \_SB.PCI0.GPP3:
>>
>> [...]
>>
>>> Applied, thanks!
>>>
>>> [1/1] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook UX425UA_UM425UA
>>>       https://git.kernel.org/brgl/c/1900b5a41493e7050c68c1e62780d6fb9a209457
>>
>> I thought I am going to pick this up via my tree...
>> But okay, not a big deal, I don't expect any conflict in that area.
>>
> 
> Oops, sorry. If any conflict does occur let me know, I can revert it or we can
> fix it in tree.

Regardless of who's tree this goes through I would like to point out
that a quirk like this really should go through a fixes branch
for the current cycle (no idea if it already is on a fixes branch,
the "applied" message does not make that clear).

Regards,

Hans


