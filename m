Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14034C806;
	Mon, 16 Mar 2026 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687783; cv=pass; b=uTt0p31TDK7ZKsGunS649KPrynhvP4jNggTZnP4yT5iBAIpl7sp5oIogdQoQTn3oVfLxnOU5TTYzhL6RUPkn77Gyb/ILU6MFFplaevRBAlAP7qNTGFpWOG8sjomOOmzqXYuZRLDNzJyI5gmCD64FzWMqRQaJjBrvtaTf7zMj+o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687783; c=relaxed/simple;
	bh=pyoq/tGrcq6SzwFGwtytw3PvQVrH37dwE4+ownecAko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqBVz7sKdrc6CH+Xg3DZ2mupBOmTKsJV8NB00hIiO7VzeIUG49jhPUJe2DhOZFQwlBu22QPGZv4Hv02LywW1x4kc/70iB05hcTeu0NT2LQ9h8SQj0drdBP6z75FuA+Mq7oTnlFIzxpi5ZXagyLpV+w/zNGFfOUOluiFm0GObel8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Jiszooe+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Jiszooe+"
ARC-Seal: i=1; a=rsa-sha256; t=1773687747; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PRMlUhYX+E81aLB7wG3wkXm//tpeR7kNHpu9rUcY/wTTROR+k8nsMeiczHUfy5hflqXBbbRB02sFR6oBi4GoTr5x6C+O9h5amebhT4l8YX/Hc1eQDsLC4A9Zjbna27gtHEOAVppLhVo8Zke0A6/BcATInbPHWI/WrXWKXu0disA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773687747; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4ZUmr/Ua+y/AufKxQBXhdPgGW4J/0hBcIVszdNrL6Ds=; 
	b=dNX2YGkbSX3FR9pJ/SJbcKKd+BXZznAby8XI6gyAzhw0DT0H56OWtwyLYKgV0NcOgT+8X+hEV7VPB50KIntGLTMcVjd/9mbG3MwvfadJrvkL81Xptxa7Hv4y100AjQk9vXPSMVjuP/o6CU6e4gWGSk7/VhtQbnoBZW3boknVZ60=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773687747;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4ZUmr/Ua+y/AufKxQBXhdPgGW4J/0hBcIVszdNrL6Ds=;
	b=Jiszooe+PYatv1i4+oCNhwCt3nqRXDZeSfF7vO7uXDsqZ+LadP1/fWSBNGHxK0K2
	EyyRSMYbfnJ1vY90CkXZoVE5LJx6mj4fYuqBfcQwIFW+uA3ymmeo32miXVpR8OTXvDP
	IawGq8zfJOz5vZWHPX763nywnPOOJoex/dtHDEpo=
Received: by mx.zohomail.com with SMTPS id 1773687744906303.7514922654966;
	Mon, 16 Mar 2026 12:02:24 -0700 (PDT)
Message-ID: <5202766b-0bc2-4d0a-90af-977dcb81e66f@collabora.com>
Date: Mon, 16 Mar 2026 22:02:16 +0300
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
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
 jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
 rafael@kernel.org, richard@hughsie.com, sebastian.reichel@collabora.com,
 superm1@kernel.org, systemd-devel@lists.freedesktop.org,
 xaver.hugl@gmail.com, John Schoenick <johns@valvesoftware.com>
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAGwozwF5wsb8pYmHj5G0uTfr+3vx+HhrfOR9t-pEGPw-jjvbHg@mail.gmail.com>
 <3ca00958-13e5-4732-b500-aa9673a4c965@collabora.com>
 <CAGwozwHLkL5xAXzaKoTyLCGzNjjHUf+bNu8qo+-Tpex7NK6=GA@mail.gmail.com>
 <ab4d90d8-3212-4571-9f92-ac4facd3aa33@collabora.com>
 <CAGwozwF7aVapmRYczm+=rPfVDXH0i6UArQtg1TRgc7Vi6+XYxA@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGwozwF7aVapmRYczm+=rPfVDXH0i6UArQtg1TRgc7Vi6+XYxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Antheas,

On 1/15/26 10:49, Antheas Kapenekakis wrote:
> On Thu, 15 Jan 2026 at 01:07, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> On 1/13/26 13:11, Antheas Kapenekakis wrote:
>>> <snip>
> 
> Hi Dmitry,
> let me go inline.
> 
>> The primary goal is to support screen-off DSM for a power-efficient
>> background games downloading [1] and further resume-to-dark on Steam
>> Deck and other handhelds. There is no strict timeline, usual "sooner the
>> better". Downstreams will use customized WIP solution till upstream will
>> get necessary generic interfaces.
>>
>> [1] https://store.steampowered.com/news/app/1675200/view/771930569635267984
> 
> Ok, this makes things clearer. I had done some testing to see the
> viability of such approach.
> 
> One big problem [1] had was that the compression algorithm that Steam
> used was very CPU intensive. However, it was announced that that
> changed, which makes low power downloads more viable.
> 
> However, even so, I do not think the sleep DSM is designed for
> prolonged background use and certain devices might overheat.
> Specifically, I think the Go S disables its fan while in that DSM.
> Looking back to what Windows does, it only uses the Sleep state to do
> periodic polling, and if there are updates it transitions to display
> off.
> 
> This is a fair approach for [1]. For example, device wakes up every
> two hours while connected to a charger, stays on sleep state, checks
> for updates, and if there are any and conditions are met, transitions
> to display off and starts downloading.
> 
> However, this means you do not get a smaller tdp limit. Given you
> control the unfrozen userspace in that state though, such a limit does
> not help either. The device will use what it needs to for downloads.
> This makes the SD 5W low power mode puzzling, as it means downloads
> will potentially take longer and I would be punished as a user for
> using that mode. Instead, Steam should be optimized to use less than
> 5W or perhaps 10W when downloading from gigabit in some way.
> 
> Two more considerations in this case are that a lot of devices will
> turn off their controllers when entering display off. And the rest
> when entering sleep. This is good because when you are in dark resume,
> the RGB of the device has turned off. But for [1] it is problematic
> because it assumes the controller works and is what is used to wake
> the device so the mode is broken. For Legion, Sleep is used to turn
> off the controller, and for other devices Sleep Entry/Exit. New in ROG
> Xbox Ally devices is that the controller no longer turns off, but it
> is muted.
> 
> The other consideration is that three additional patches are needed
> for ROG Ally devices to work correctly with this series, 2 cleanup
> commits and 1 small delay. But after that it should be drop in. I
> cannot comment on the new hid drivers for Asus and Legion that are
> currently being developed. Particularly, hid-legion-go(?) has a
> reset_resume() cb where it should have used resume? Or not anything?
> The legion controllers save os mode until they disconnect, which they
> do with this series, so the driver would always re-initialize on
> wake-up.

My rough understanding that a firmware/BIOS update may be needed for
some devices to leverage DSM in regards to power consumption
improvement. Could be true that practically it may not improve much,
will see. Even if not all current devices will benefit from the
screen-off DSM, it may differ for a later generations.

>> A common approach for upstreaming is to divide problem into smaller
>> manageable parts. That's what I'm planning to focus on now to see if we
>> can start easy with a minimal changes.
> 
> Sure. One potential approach for this is this series, where the first
> part does the plumbing and the second part the exposing. They can be
> merged independently.
> 
> I also made sure to address Rafael's comments, so the ABI of this
> series is completely independent of ACPI, S0ix or whether the device
> has a display. I also removed all references to Intel, AMD specific
> power envelope terminology. Moreover, most of the logic now resides in
> suspend.c and the hooks are in platform_ calls, so it can be
> implemented for other platforms easily.
> 
> However, the first part of this series does some refactorings which
> assume a favorable outcome. If we do not want to assume that, a
> simpler initial series would just move the MS/display on/off DSMs to
> .begin() in s2idle.c. If you think that would be easier to merge, you
> are welcome to start with that. Then this series would be refactored
> on top and merged as a single unit. Keep in mind the ROG Ally conflict
> would also arise in this case as well.
> 
>> Please don't worry about the credit. You did a significant ground work
>> that is well recognized by now. Thanks a lot for your efforts and help.
>> Starting from scratch of course won't be a good approach with all the
>> broad testing you've done.
> 
> Great. Sounds good to me.

I'm taking latest version of your patches and will update them in
accordance to the review from Rafael.

-- 
Best regards,
Dmitry
