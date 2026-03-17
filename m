Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C050F3B585A;
	Tue, 17 Mar 2026 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748652; cv=pass; b=IY8Qv//Gz3zbuC10FcKJ92yCW5EWTIpHzKgg/upB2g++mcYFErZYYjl8pYp1k5OEPSP0II4TAwsPbIrQ94xwVMtEKeyY0maufxAYUKNuGs2vlpwwY3hlb4bk+TL7bw7BABw0WsqdPndMdQP29CYO1l0JEQByxh4B04ocGffIHHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748652; c=relaxed/simple;
	bh=MxLH+34DV61BwTt3trXr/Cy1prrIBfAwJvskGNnHjHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+R4IJhR9Mwx0RdWmv+1inD6bYhZIpV2TVd6ai+jTheaRReXtvTM/oxnDfV/YsuHee4CaFPPx25HOvQMr0NfyObhQtzgSr4vJil1A3Di5UOhbexSXMEsBvEWAlLjFomEbkmHnuEdRfK2UjjdTyOB9/fy5uKSFWnsgKnVPwg7AOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=bUt93yP0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="bUt93yP0"
ARC-Seal: i=1; a=rsa-sha256; t=1773748620; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j/aA4Hy38M8ma+L9i+MFiptQpcEg+mbdEGPjwsi+gEQQUFaVbvC0Gw0YGuCqEmlTMtoyOogNoe33dnICnQDjAnr2mdMQ0vWa6hMy9k7QRnzmMdTESLLbvsrCj5lbE16ilEZQlRmvUlrolH4VuSRZCEzG4mCa65wfgRSKVBqQxR8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773748620; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nKgDoE543kxzdo9jEPtg1YxHgznioveX62yWZpKjJgU=; 
	b=BcwFcyYfuUYo/n64XUXOdYV0bYthNjHHaXOUMlMQcDOJLPoFL5/pPdKndVSIxU4ivftHyykFLafzS80xmEROldJ9w2VbcTMa2rP0PQqi/y8LTO1CPrXRhzuH8Jshl8h8sWE8IZwOJpvW04/hwGgcN8gMq7Ld2lgAODowo+HFAc0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773748620;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nKgDoE543kxzdo9jEPtg1YxHgznioveX62yWZpKjJgU=;
	b=bUt93yP037KUNTo3eTDepteqOq00yiAzdGEiQ+0kZzEAOwhasx2e1sGGy1K3vA8W
	WR1zVKe7dVERl7LCnOV3brzkzYOEM8t7ZYaaoI9oiVG2/AxQugyQIml8+BRVEsgGRVP
	aO8OmGrTQT/4MYSXxAHnOFCnnGVsjbAz6bpM0cAk=
Received: by mx.zohomail.com with SMTPS id 1773748619083565.4600735946283;
	Tue, 17 Mar 2026 04:56:59 -0700 (PDT)
Message-ID: <030c38aa-353e-4387-a006-42e641b3ac6a@collabora.com>
Date: Tue, 17 Mar 2026 14:56:53 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Antheas Kapenekakis <lkml@antheas.dev>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
 jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
 richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org,
 systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
 <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/16/26 22:52, Antheas Kapenekakis wrote:
>> So in accordance with the above, /sys/power/standby is not a very
>> fortunate choice of the name of this interface and I'm totally
>> unconvinced that it belongs to sys/power because its role is not
>> really power management (and it is ACPI-only for the time being).
> Hm, most of the changes / implementation resides in the pm subsystem
> and it is related to the s2idle suspend flow.
> 
> I assume that when it stops being ACPI only provided we reach a design
> that allows for that, the related callbacks would also nest in pm ops.
> 
> Where could a more appropriate directory in sysfs be? I would still
> tend towards /sys/power

Question is whether anyone outside of ACPI will ever need the generic
interface. Making it generic based on guesswork could be a wasted effort
that Rafael and others will have to maintain. The mode file could go
under /sys/firmware/acpi if interface is made ACPI-specific.

Will be good if you could demonstrate a need in making interface
generic, if there are any devices on your mind that could make use of it
right away. Old interface can be deprecated if a better new appears.

Either way is okay to me, but Rafael is the PM expert and I'd do as he
wants it to be.

-- 
Best regards,
Dmitry
