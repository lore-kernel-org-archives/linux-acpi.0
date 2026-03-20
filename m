Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86B25CC74;
	Fri, 20 Mar 2026 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039298; cv=none; b=hrnh7J2fClCcOwzFY13+Or55FkiMee3FbKcWnbc6BbHt68x3ahWNTFN+IehIZYYWIAt1wC2zHne4aABA69Js72BdlToCImevU2ysOmiGxxXL2VaCOlHv81lMxvOhYgkWrTxjUg36ph9Jj8MIJpHEB1oGIcsRZ4nkCMjt88X3wQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039298; c=relaxed/simple;
	bh=tck/fTXmMD3fkP1Vjyts2UGAsELa4A0wt2KH6DYgBu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsyobpxUZqtTIMK9cTJ/kUOzWtDh+tbf31X1XbC31wk1olNKNk7oLPFczgP8AjGDyvE4Hti0wJAq628dVC6nRTnGs68YSG1t67KJmNVLEPbDYt7DZ7j6FT1s66W47FEUkIvJlob3aqHHcWAF5bcQCr+vMaX7pcq8I88ikjGPFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=javi1rXg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="javi1rXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF51C4CEF7;
	Fri, 20 Mar 2026 20:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774039298;
	bh=tck/fTXmMD3fkP1Vjyts2UGAsELa4A0wt2KH6DYgBu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=javi1rXgLpWC2lPBZfSDIou7hnvcMr4yfDFHT4pY/auWxlAcsJVQDU9MfYs4q8Wxd
	 OX/WzL/GitGmOQEU2PHQZfX4k1ySzCMJR1S4nQKs0MHdaFQrs2OHN+uDMd38fWBsRJ
	 +vVI4CSk9CSfCSC99AlaSqOia0OIjHneUO8F9uzjypRnJQqWWOfJfc3iGH5uNMr9oN
	 j07g27QlRJf8AfdCQzVFQMqXonezU7oKNMaQ6Ei56F7EZE4kLSvvokn+EqfysTQgMQ
	 cvXZBsI5nEbMuUPmyfNRJiVKbdeAvvaZYNtzOknOuSW8joxi9EG57ok6S0gLyB3GAS
	 01whjf5LjKghQ==
Message-ID: <4526e323-0c33-4e38-a46a-78ccd9548fa2@kernel.org>
Date: Fri, 20 Mar 2026 15:41:35 -0500
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
 sebastian.reichel@collabora.com, superm1@kernel.org,
 systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
 <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com>
 <030c38aa-353e-4387-a006-42e641b3ac6a@collabora.com>
 <CAJZ5v0jbDqs=adBX-o-MDyNX+=Q6UAkw1=gh2y_9cAMMi+gi_g@mail.gmail.com>
 <35f773ff-6514-413c-988b-765bf2d0d293@amd.com>
 <CAGwozwGpzzBC6Zh9NTskqZ1V1Sth3fHKVr3LALpRkrpaWcorjg@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAGwozwGpzzBC6Zh9NTskqZ1V1Sth3fHKVr3LALpRkrpaWcorjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/19/2026 7:35 AM, Antheas Kapenekakis wrote:
> On Tue, 17 Mar 2026 at 16:13, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 3/17/26 07:09, Rafael J. Wysocki wrote:
>>> On Tue, Mar 17, 2026 at 12:57 PM Dmitry Osipenko
>>> <dmitry.osipenko@collabora.com> wrote:
>>>>
>>>> On 3/16/26 22:52, Antheas Kapenekakis wrote:
>>>>>> So in accordance with the above, /sys/power/standby is not a very
>>>>>> fortunate choice of the name of this interface and I'm totally
>>>>>> unconvinced that it belongs to sys/power because its role is not
>>>>>> really power management (and it is ACPI-only for the time being).
>>>>> Hm, most of the changes / implementation resides in the pm subsystem
>>>>> and it is related to the s2idle suspend flow.
>>>>>
>>>>> I assume that when it stops being ACPI only provided we reach a design
>>>>> that allows for that, the related callbacks would also nest in pm ops.
>>>>>
>>>>> Where could a more appropriate directory in sysfs be? I would still
>>>>> tend towards /sys/power
>>>>
>>>> Question is whether anyone outside of ACPI will ever need the generic
>>>> interface. Making it generic based on guesswork could be a wasted effort
>>>> that Rafael and others will have to maintain. The mode file could go
>>>> under /sys/firmware/acpi if interface is made ACPI-specific.
>>>
>>> Well, experience shows that it may end up the other way around.
>>>
>>> People once thought that the platform profile interface would be
>>> ACPI-specific and we ended up having to extend it via
>>> platform_profile_class.
>>>
>>> I'm thinking that something similar may take place in this case.
>>> Platforms that don't use ACPI may also want to define platform
>>> triggers to somehow adjust platform settings and those may be
>>> different from "inactive" or "snooze".
>>>
>>
>> At which point you would almost wonder if this should be super general
>> like "foreground_workload_type".
>>
>> Then this could be expanded for other uses later such as full screen
>> video playback or full screen gaming.
> 
> Mmm. This reminds me of AMD drm pp_power_profile_mode {BOOTUP_DEFAULT,
> 3D_FULL_SCREEN, POWER_SAVING, VIDEO, VR, COMPUTE, CUSTOM, WINDOW_3D,
> CAPPED, UNCAPPED}. I'm not sure anyone used it. I'd rather avoid the
> complexity.

There are certainly people using it, but it's more common in embedded 
applications than traditional desktop distros.

It is not a perfect match to this concept, but definitely some parallels 
can be drawn.

There are general things that might make sense if you know what the 
foreground workload is or the display is off.

> 
>> There could be hooks for scheduler too in the future from this hint too
>> then.
> 
> Wouldn't it be better to defer to userspace? I'm not sure this would
> have a meaningful difference in any case.

I don't know one way or the other.  It would need to be prototyped to 
see what it actually looked like.  In the line of thinking Rafael 
mentioned that platform profile was ACPI and grew to a class I would 
generally just keep the design from pigeon holing too much on display 
off.  That's why I thought maybe foreground workload could potentially 
work well.

