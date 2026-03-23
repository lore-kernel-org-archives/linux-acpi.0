Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9723182D;
	Mon, 23 Mar 2026 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774240598; cv=none; b=AmxtHnl+92iBL36WyYII1xUJ/jH8XH0Vdux9dWQqXds2YSYQFo4M/UG6LzpFWA0qeY7t1pbOV67txrEosaXX+XpZIYuwuy3PnWzVsrBLUP8Z05QMycqH48MGeZ066TDfAjMghALaHW/stP7GKE9eu6AI0i8clkG5IxO+W1bYIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774240598; c=relaxed/simple;
	bh=3UhPcmNRjuP4e8JaEdExahz5aLHvu4DBP0q58JBibYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPtWFgv8FPcqhiMXUpJ5lTZwYpTerKli55vaYOrILsI31SZc4U57Vowwh+BRhAF749nmedd5KEhl5SGL2+pnLVm5mXpRtAsvmNimdT4vPUOPnTUQJdnmzAMiEkJLiy8au++YV1PaWj1SG8uQCB9DqZ9Xb1g6R2PdNiPQeFJGZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAZydFqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAZydFqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A7EC4CEF7;
	Mon, 23 Mar 2026 04:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774240597;
	bh=3UhPcmNRjuP4e8JaEdExahz5aLHvu4DBP0q58JBibYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lAZydFqCOkRH7Jb5xY/uOHl3BXw7o4EKmt1bzRmm/RinxGVfCoGr7GY06+2TiXrFO
	 NXRl2WopTfxOpRmZQ5HVwgZkjjqqv9dDRSNctkHaQGAroQnn+f/G2zM+RvBoj6RYSq
	 +RoTLQnGi2jdISufIfFBQqr5IaAfmzIWjlLNyaleiXT2iY3t+BBYXot7whFlHAMuOY
	 0PJTdXpFYHiKpCoUEAc+T+XzFeWWBIETynSfDdMYVj+QY8HiGLEsirjFiVoR8iwgrp
	 bOnWlYQWNjrpEiS6FkqTu8wEQRtP/pk9fHPuMKd5m83kquIixs3K0hsQVsZxUufCS/
	 TbY+jvlaLuJgg==
Message-ID: <c3ea88d3-a855-4ddb-af09-e6fd6e279ec2@kernel.org>
Date: Sun, 22 Mar 2026 23:36:34 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, bob.beckett@collabora.com,
 bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org,
 kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, mccann@jhu.edu, richard@hughsie.com,
 sebastian.reichel@collabora.com, systemd-devel@lists.freedesktop.org,
 xaver.hugl@gmail.com
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
 <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com>
 <030c38aa-353e-4387-a006-42e641b3ac6a@collabora.com>
 <CAJZ5v0jbDqs=adBX-o-MDyNX+=Q6UAkw1=gh2y_9cAMMi+gi_g@mail.gmail.com>
 <35f773ff-6514-413c-988b-765bf2d0d293@amd.com>
 <CAGwozwGpzzBC6Zh9NTskqZ1V1Sth3fHKVr3LALpRkrpaWcorjg@mail.gmail.com>
 <4526e323-0c33-4e38-a46a-78ccd9548fa2@kernel.org>
 <CAGwozwFN4wED6TgJgrKAtNFxY4TCJgnUVOcmb39Bchj8gGXvZg@mail.gmail.com>
 <CAGwozwHPizKuAvN+dxHYPt45OTKKgfCg62a9gv+Cn_EpAtgfgw@mail.gmail.com>
 <1884bb9d-2720-4cde-8a8e-35a9c0c4769c@kernel.org>
 <CAGwozwE=2zdxSA39K2qD0p3_rbhpoMiHD7YbJYBBWC93m+0GZg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwE=2zdxSA39K2qD0p3_rbhpoMiHD7YbJYBBWC93m+0GZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> I wouldn't call platform_profile ACPI either, but it just kind of
> ended up there. 

Exactly, it's not the best place for it, but now it's ABI.

> Where would be a better position for it?

I would say it depends upon how generic it ends up being.  Maybe 
/sys/kernel if it is very generic.  Maybe /sys/power if it's more narrow 
and only going to be for affecting power related things.


