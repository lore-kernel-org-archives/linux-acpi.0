Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DB2DF6EA;
	Sat, 21 Mar 2026 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118633; cv=none; b=DJXC9wy0wYTn4QjFC6TYtZpGtgurkgwL65l0rPWDArBULVDVmjAQWVlW3uGqOLTlzd6vYLnyG8VRIAi7BMZMgBwRiOh6Xu0Xa9mO/VgAjbwjLjI88g7RZJteYPNnvD1fNR4T0xFywU8iiuocf6T2Q+VW379JRZT9ccqOIym9/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118633; c=relaxed/simple;
	bh=LsVaam24w+vSaTKn4eTiwu69LSDyQx4VWxA0AD/Rq50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UormlK/X3UDO6ouiukKZVardR5KCMt4n7ZfjXZYZGwP6CgAxvp1lePnf9RYqV1oQym/7DcpUUhMWhofYYq9m9vRVJ8Rwxn3WVcGnRrjUH78n9iy3/7Xr+jcE5wjbGE9/7WPLYCL2slI6ajZVys8KOMKp8Zx8dx/3lKKfzqJouko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIHD0zc0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIHD0zc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79FFC2BC87;
	Sat, 21 Mar 2026 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774118633;
	bh=LsVaam24w+vSaTKn4eTiwu69LSDyQx4VWxA0AD/Rq50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DIHD0zc0b3AozYy5nz46TKQVK/26R2/eclCk6xLBcM1ZcC9uC30ZpI42aI4iOYmZF
	 WnqBFHeNsOhEzCfOKoARxKVU4AQXIOrqRwsnLKIF+6q/9XydzfFvIrJgqaUFjScSZP
	 kXnH2OyO2viViZyWV7z2PpfgqikxfuBp46iI814brOPtXKShnerYSj/Hj238n5zXZe
	 +t53KgVijSKAP7FY2ZoOiEcvF7vCMrucdirS4O5OMKYlKLhZ0JXvwfN+ZO7rmBaDvg
	 DGtupOH1C6aE4/FCDVwrI66vCtOswBWA0PYw0hgGWagJXcgdR9RXPeW2EJbsh1diGq
	 +e5plQ17YrW+w==
Message-ID: <1884bb9d-2720-4cde-8a8e-35a9c0c4769c@kernel.org>
Date: Sat, 21 Mar 2026 13:43:51 -0500
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwHPizKuAvN+dxHYPt45OTKKgfCg62a9gv+Cn_EpAtgfgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/21/26 8:52 AM, Antheas Kapenekakis wrote:
> On Sat, 21 Mar 2026 at 14:46, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>
>> On Fri, 20 Mar 2026 at 21:41, Mario Limonciello (AMD) (kernel.org)
>> <superm1@kernel.org> wrote:
>>>
>>>
>>>
>>> On 3/19/2026 7:35 AM, Antheas Kapenekakis wrote:
>>>> On Tue, 17 Mar 2026 at 16:13, Mario Limonciello
>>>> <mario.limonciello@amd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 3/17/26 07:09, Rafael J. Wysocki wrote:
>>>>>> On Tue, Mar 17, 2026 at 12:57 PM Dmitry Osipenko
>>>>>> <dmitry.osipenko@collabora.com> wrote:
>>>>>>>
>>>>>>> On 3/16/26 22:52, Antheas Kapenekakis wrote:
>>>>>>>>> So in accordance with the above, /sys/power/standby is not a very
>>>>>>>>> fortunate choice of the name of this interface and I'm totally
>>>>>>>>> unconvinced that it belongs to sys/power because its role is not
>>>>>>>>> really power management (and it is ACPI-only for the time being).
>>>>>>>> Hm, most of the changes / implementation resides in the pm subsystem
>>>>>>>> and it is related to the s2idle suspend flow.
>>>>>>>>
>>>>>>>> I assume that when it stops being ACPI only provided we reach a design
>>>>>>>> that allows for that, the related callbacks would also nest in pm ops.
>>>>>>>>
>>>>>>>> Where could a more appropriate directory in sysfs be? I would still
>>>>>>>> tend towards /sys/power
>>>>>>>
>>>>>>> Question is whether anyone outside of ACPI will ever need the generic
>>>>>>> interface. Making it generic based on guesswork could be a wasted effort
>>>>>>> that Rafael and others will have to maintain. The mode file could go
>>>>>>> under /sys/firmware/acpi if interface is made ACPI-specific.
>>>>>>
>>>>>> Well, experience shows that it may end up the other way around.
>>>>>>
>>>>>> People once thought that the platform profile interface would be
>>>>>> ACPI-specific and we ended up having to extend it via
>>>>>> platform_profile_class.
>>>>>>
>>>>>> I'm thinking that something similar may take place in this case.
>>>>>> Platforms that don't use ACPI may also want to define platform
>>>>>> triggers to somehow adjust platform settings and those may be
>>>>>> different from "inactive" or "snooze".
>>>>>>
>>>>>
>>>>> At which point you would almost wonder if this should be super general
>>>>> like "foreground_workload_type".
>>>>>
>>>>> Then this could be expanded for other uses later such as full screen
>>>>> video playback or full screen gaming.
>>>>
>>>> Mmm. This reminds me of AMD drm pp_power_profile_mode {BOOTUP_DEFAULT,
>>>> 3D_FULL_SCREEN, POWER_SAVING, VIDEO, VR, COMPUTE, CUSTOM, WINDOW_3D,
>>>> CAPPED, UNCAPPED}. I'm not sure anyone used it. I'd rather avoid the
>>>> complexity.
>>>
>>> There are certainly people using it, but it's more common in embedded
>>> applications than traditional desktop distros.
>>>
>>> It is not a perfect match to this concept, but definitely some parallels
>>> can be drawn.
>>>
>>> There are general things that might make sense if you know what the
>>> foreground workload is or the display is off.
>>
>> Hm, yeah I guess so. I could see this ABI being also useful for
>> embedded devices to control their appearance. There's precedent with
>> e.g., charging_behaviour having dozens of device specific values,
>> where standard and longevity are the only ones used in laptops.
>>
>>>>
>>>>> There could be hooks for scheduler too in the future from this hint too
>>>>> then.
>>>>
>>>> Wouldn't it be better to defer to userspace? I'm not sure this would
>>>> have a meaningful difference in any case.
>>>
>>> I don't know one way or the other.  It would need to be prototyped to
>>> see what it actually looked like.  In the line of thinking Rafael
>>> mentioned that platform profile was ACPI and grew to a class I would
>>> generally just keep the design from pigeon holing too much on display
>>> off.  That's why I thought maybe foreground workload could potentially
>>> work well.
>>
>> To go back to Rafael's suggestion of not using transitions for the
>> ABI, it would be possible to push the transition logic down to the
>> s2idle code and introduce a generic handler for it. SInce arbitrary
>> transitions are possible under this spec, the top-level ABI
>> implementation need not consider it.
>>
>> Since it is very similar to platform_profiles, it could also be
>> potentially added there as activity_hint to the current
>> platform_profiles implementation and mirror its conventions. This
>> would avoid introducing new scaffolding.
>>
>> Then s2idle would register a platform profile handler without
>> profiles, and instead only implement activity hint. Existing x86
>> platform drivers could also trivially implement support for it as
>> well. Although for WMI, the existing hooks for s2idle for Windows
>> would handle most current drivers.
>>
>> An implementation for this would consist of two stages. First, the
>> callbacks would be moved to the beginning so they can be tested
>> independently. Then, platform_profile would be extended to support
>> activity_hint with states {snooze, resuming, inactive, active}, and
>> finally, s2idle would implement the handler with transition logic to
>> make sure the callbacks get called correctly always, including when
>> userspace ignores the file, where the full transition would occur in
>> begin() and end().
>>
>> The legacy /sys/firmware/acpi/{activity_hint, activity_hint_choices}
>> would mirror the current conventions, perhaps with a custom value as
>> well.
>>
>> How does this approach sound?
> 
> Perhaps re-using platform_profiles is not wise, after all the
> boilerplate would be small and bolting on new hooks would be around
> the same amount of code. New implementation would be better. How would
> that approach sound like.
> 
>> Antheas
> 

I really don't want our top level interface for this thing to end up in 
/sys/firmware/acpi.  The concept of system posture, or foreground 
workload, or whatever we call it isn't an ACPI concept.  It might have 
direct implications for an ACPI implementation (IE the calling of this 
_DSM) but there is no reason we can't have a non-ACPI implementation too 
with the right knobs.
