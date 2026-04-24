Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6C19C556;
	Fri, 24 Apr 2026 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994588; cv=pass; b=LIMuuo4X/U8AtzQ8rgBDYdbaqL+x/WEbt1qiMQQPJrN/9LTv9M382nCBoy7M0Ex6JENR7pkOL3JYSylUakT3eO/ub/J6TbkZBT1WNt7dWhfEBI9k+SPADHxUqr2h2jzyfTm51EyTslOYkH5sbL+dWstDw9+oXtCwhcdrp5SN2sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994588; c=relaxed/simple;
	bh=yewkOtv/mPldLWafC6ivgex4FGMJnKcUZzsGc+pJyl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3ximTtEh5K+VNxkANj9fgJbj2hd50RlgGZPNy2k7pbhP1cHxtVsMG309Zpfvzcf3iDgRrs4k4rVoroB83aUZr79l7ioDQy3kr3WI1iod99AqpyMNGia28e/Z4SbLh83vGcFY2jKKL5l6ygxc7t9HVHfiWi17JhGJkQRwW85Qcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=CJjEIwBX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="CJjEIwBX"
ARC-Seal: i=1; a=rsa-sha256; t=1776994548; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Bpef/vqybSCIlgtPLbd1cMhsy6pUlV/WNVETG3TuYmjNZf02kjDTXRsuMN9CiXbMs4g7oOoCWH7k2Ph0LVI2wIMoVPRUb8TC+r0E9bG78A/7MVhspPSbWSI03KJy7uEDg46tpamLvKz4CuMRNqFNRCw9Z2MJ0Bm36Of9Xjctb1Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776994548; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L3r+BTJruI3zay93E2FtcBIJ9AIf3NzYohX0ZG/HPho=; 
	b=lopOXd2X6RBT7iQGbjscVTZd/PJUOokTXBAymIAixb6H83Brq/maZwK9JC3OAf3KjNFk+eLT44UJvoFlQuCtGEbW1AecmAzg3rFQlKXZF7Ua4XhbKOJVkkS82l8rBjd+YdTgRRQsn6tDIHpDSzXQWYCpcn15OA/MyAm1IFHmt0U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776994548;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=L3r+BTJruI3zay93E2FtcBIJ9AIf3NzYohX0ZG/HPho=;
	b=CJjEIwBXRk9aGgM6nPn048OcmEoxhi2HSHvIX15xLwiVc6XivmQed5nzeiwrxwoo
	yGia2jZEuYH2q3jQtfbPOiQOhvk8cofRje60YQgWN8uKOzQsiDQdsQrG6cF24MjvLkM
	FA9fIga03miusqhXlYEd9UGIAuxdG2hZnQzT+By4=
Received: by mx.zohomail.com with SMTPS id 1776994545400281.7205380017285;
	Thu, 23 Apr 2026 18:35:45 -0700 (PDT)
Message-ID: <00d8b84f-1cbc-4540-948f-40ee21049c8b@collabora.com>
Date: Fri, 24 Apr 2026 04:35:39 +0300
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
 <5202766b-0bc2-4d0a-90af-977dcb81e66f@collabora.com>
 <CAGwozwGc0YsU_aW4Yk7g3B8LCGvXPoXg=NVkJPXxfPekxq7p1A@mail.gmail.com>
 <CAGwozwE2F53Kz71-1Sub9RuDc=df9KPAo-i63hZ6sO4=C0tDpg@mail.gmail.com>
 <9603d545-9def-498d-bf05-c15b855b3d3b@collabora.com>
 <d3598ba5-2de7-42f7-963f-a500597c8a88@collabora.com>
 <CAGwozwFHza2ddpPQsXOJO1KyHLGHLhMpM+CxDfLS3X2xARS0fg@mail.gmail.com>
 <CAGwozwFrCMQE3SDa1eSdQpU0jzNNW69VSBO-dPub21zKNq5P3w@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAGwozwFrCMQE3SDa1eSdQpU0jzNNW69VSBO-dPub21zKNq5P3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/22/26 11:58, Antheas Kapenekakis wrote:
> On Wed, 22 Apr 2026 at 10:51, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>
>> On Wed, 22 Apr 2026 at 02:56, Dmitry Osipenko
>> <dmitry.osipenko@collabora.com> wrote:
>>>
>>> Hi, Antheas
>>>
>>> On 3/17/26 14:04, Dmitry Osipenko wrote:
>>>> On 3/16/26 22:36, Antheas Kapenekakis wrote:
>>>>> On Mon, 16 Mar 2026 at 20:33, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>>>>>
>>>>>> On Mon, 16 Mar 2026 at 20:03, Dmitry Osipenko
>>>>>> <dmitry.osipenko@collabora.com> wrote:
>>>>>>>
>>>>>>> Hi Antheas,
>>>>>>>
>>>>>>> On 1/15/26 10:49, Antheas Kapenekakis wrote:
>>>>>>>> On Thu, 15 Jan 2026 at 01:07, Dmitry Osipenko
>>>>>>>> <dmitry.osipenko@collabora.com> wrote:
>>>>>>>>>
>>>>>>>>> On 1/13/26 13:11, Antheas Kapenekakis wrote:
>>>>>>>>>> <snip>
>>>>>>>>
>>>>>>>> Hi Dmitry,
>>>>>>>> let me go inline.
>>>>>>>>
>>>>>>>>> The primary goal is to support screen-off DSM for a power-efficient
>>>>>>>>> background games downloading [1] and further resume-to-dark on Steam
>>>>>>>>> Deck and other handhelds. There is no strict timeline, usual "sooner the
>>>>>>>>> better". Downstreams will use customized WIP solution till upstream will
>>>>>>>>> get necessary generic interfaces.
>>>>>>>>>
>>>>>>>>> [1] https://store.steampowered.com/news/app/1675200/view/771930569635267984
>>>>>>>>
>>>>>>>> Ok, this makes things clearer. I had done some testing to see the
>>>>>>>> viability of such approach.
>>>>>>>>
>>>>>>>> One big problem [1] had was that the compression algorithm that Steam
>>>>>>>> used was very CPU intensive. However, it was announced that that
>>>>>>>> changed, which makes low power downloads more viable.
>>>>>>>>
>>>>>>>> However, even so, I do not think the sleep DSM is designed for
>>>>>>>> prolonged background use and certain devices might overheat.
>>>>>>>> Specifically, I think the Go S disables its fan while in that DSM.
>>>>>>>> Looking back to what Windows does, it only uses the Sleep state to do
>>>>>>>> periodic polling, and if there are updates it transitions to display
>>>>>>>> off.
>>>>>>>>
>>>>>>>> This is a fair approach for [1]. For example, device wakes up every
>>>>>>>> two hours while connected to a charger, stays on sleep state, checks
>>>>>>>> for updates, and if there are any and conditions are met, transitions
>>>>>>>> to display off and starts downloading.
>>>>>>>>
>>>>>>>> However, this means you do not get a smaller tdp limit. Given you
>>>>>>>> control the unfrozen userspace in that state though, such a limit does
>>>>>>>> not help either. The device will use what it needs to for downloads.
>>>>>>>> This makes the SD 5W low power mode puzzling, as it means downloads
>>>>>>>> will potentially take longer and I would be punished as a user for
>>>>>>>> using that mode. Instead, Steam should be optimized to use less than
>>>>>>>> 5W or perhaps 10W when downloading from gigabit in some way.
>>>>>>>>
>>>>>>>> Two more considerations in this case are that a lot of devices will
>>>>>>>> turn off their controllers when entering display off. And the rest
>>>>>>>> when entering sleep. This is good because when you are in dark resume,
>>>>>>>> the RGB of the device has turned off. But for [1] it is problematic
>>>>>>>> because it assumes the controller works and is what is used to wake
>>>>>>>> the device so the mode is broken. For Legion, Sleep is used to turn
>>>>>>>> off the controller, and for other devices Sleep Entry/Exit. New in ROG
>>>>>>>> Xbox Ally devices is that the controller no longer turns off, but it
>>>>>>>> is muted.
>>>>>>>>
>>>>>>>> The other consideration is that three additional patches are needed
>>>>>>>> for ROG Ally devices to work correctly with this series, 2 cleanup
>>>>>>>> commits and 1 small delay. But after that it should be drop in. I
>>>>>>>> cannot comment on the new hid drivers for Asus and Legion that are
>>>>>>>> currently being developed. Particularly, hid-legion-go(?) has a
>>>>>>>> reset_resume() cb where it should have used resume? Or not anything?
>>>>>>>> The legion controllers save os mode until they disconnect, which they
>>>>>>>> do with this series, so the driver would always re-initialize on
>>>>>>>> wake-up.
>>>>>>>
>>>>>>> My rough understanding that a firmware/BIOS update may be needed for
>>>>>>> some devices to leverage DSM in regards to power consumption
>>>>>>> improvement. Could be true that practically it may not improve much,
>>>>>>> will see. Even if not all current devices will benefit from the
>>>>>>> screen-off DSM, it may differ for a later generations.
>>>>>>
>>>>>> Hi Dmitry,
>>>>>> sorry, I have been busy the past few days. I read through Rafael's
>>>>>> comments, I will respond to them in the next 2-3 days.
>>>>>>
>>>>>> Your understanding is correct. You will see 0 performance difference
>>>>>> with the screen off DSM. It is not supposed to affect the thermal
>>>>>> envelope. Turning off the screens of your laptop due to inactivity is
>>>>>> not supposed to affect the thermal envelope.
>>>>>>
>>>>>> For devices that use the DSM to turn off their controller (~60%),
>>>>>> there might be a marginal <.5W improvement. The rest use the sleep
>>>>>> DSMs for that. Those do affect the thermal envelope. However, they are
>>>>>> not designed for prolonged CPU intensive tasks such as a SteamOS
>>>>>> download mode. This is the bigger concern. From my experience, I
>>>>>> expect the Go S to overheat.
>>>>>>
>>>>>> The improvement because of turning off the controllers / RGB is
>>>>>> something that is needed for download mode in any case. And as my
>>>>>> previous comment suggests, lowering the thermal limit may not be
>>>>>> required / advantageous.
>>>>>
>>>>> Here, the sleep dsms are also important, because of their broad
>>>>> effects to power light / thermal envelope. As they can be used for
>>>>> brief wake / update checks. For battery powered devices, perhaps these
>>>>> are not important (excl. hibernation checks), but for desktop consoles
>>>>> it is expected functionality.
>>>>>
>>>>>>>>> A common approach for upstreaming is to divide problem into smaller
>>>>>>>>> manageable parts. That's what I'm planning to focus on now to see if we
>>>>>>>>> can start easy with a minimal changes.
>>>>>>>>
>>>>>>>> Sure. One potential approach for this is this series, where the first
>>>>>>>> part does the plumbing and the second part the exposing. They can be
>>>>>>>> merged independently.
>>>>>>>>
>>>>>>>> I also made sure to address Rafael's comments, so the ABI of this
>>>>>>>> series is completely independent of ACPI, S0ix or whether the device
>>>>>>>> has a display. I also removed all references to Intel, AMD specific
>>>>>>>> power envelope terminology. Moreover, most of the logic now resides in
>>>>>>>> suspend.c and the hooks are in platform_ calls, so it can be
>>>>>>>> implemented for other platforms easily.
>>>>>>>>
>>>>>>>> However, the first part of this series does some refactorings which
>>>>>>>> assume a favorable outcome. If we do not want to assume that, a
>>>>>>>> simpler initial series would just move the MS/display on/off DSMs to
>>>>>>>> .begin() in s2idle.c. If you think that would be easier to merge, you
>>>>>>>> are welcome to start with that. Then this series would be refactored
>>>>>>>> on top and merged as a single unit. Keep in mind the ROG Ally conflict
>>>>>>>> would also arise in this case as well.
>>>>>>>>
>>>>>>>>> Please don't worry about the credit. You did a significant ground work
>>>>>>>>> that is well recognized by now. Thanks a lot for your efforts and help.
>>>>>>>>> Starting from scratch of course won't be a good approach with all the
>>>>>>>>> broad testing you've done.
>>>>>>>>
>>>>>>>> Great. Sounds good to me.
>>>>>>>
>>>>>>> I'm taking latest version of your patches and will update them in
>>>>>>> accordance to the review from Rafael.
>>>>>>
>>>>>> Rafael raised some good questions I need to respond to. Specifically,
>>>>>> the ABI is not yet decided, so the comments are not ready to address
>>>>>> yet.
>>>>>>
>>>>>> Nonetheless, this series is ready to test with the current ABI.
>>>>>>
>>>>>> Moreover, Rafael suggests for upstreaming to follow essentially what I
>>>>>> outlined. An initial series should move the DSMs to the beginning of
>>>>>> the suspend sequence, and the follow-up would implement the ABI.
>>>>>>
>>>>>> I was planning to work on the first sub-series as a non-RFC after
>>>>>> responding to Rafael's comments. Let me know how you plan to proceed.
>>>>
>>>> Please go on and make a v2. This version works well with my testing. Thanks!
>>>
>>> Do you have updates on v2? For now I don't have good suggestion on where
>>> to put and how to define standby knobs in sysfs in a more generic
>>> manner. Pick what feels better or keep current /sys/power variant with
>>> the rest of review comments addressed.
>>>
>>> Please let me know if help needed,
>>
>> Hi Dmitry,
>> I had some work pop up the past three weeks so I could not go ahead
>> with this. I will reprioritize and get back to you with an update by
>> end of week.
>>
>> Here is the current plan for V2. It will consist of four parts.
>>
>> i) We keep the initial rename patches.
>> ii) Then, we move all the calls to the begin() and end() functions.
>> After these, we perform a summary cleanup of asus-wmi and hid-asus to
>> undo the duplicate handling of the calls due to the prior sequence
>> causing issues on Ally devices, and add a small 500ms quirk after the
>> begin calls for these devices to resolve a timing issue present on all
>> firmwares (the Ally units have a hardcoded ~300ms delay in which they
>> fade their RGB before disconnecting the controller and saving its
>> state, causing it to reboot on resume if that does not happen; this is
>> common in all aura devices such as Asus Keyboards, but no other
>> devices cause issues due to the state loss).
>>
>> These first two parts can merge initially to ensure no issues arise.
>>
>> Then, we implement the activity API in two parts.
>>
>> iii) Introduce drivers/acpi/activity.c (match platform profile for
>> now), which has an ABI of
>> /sys/class/activity/[driver_name]/{name,hint,hint_choices} (non-ACPI
>> specific). The ABI and activity.c do not perform state transitions,
>> match the platform_profile internal API structure, and are not ACPI
>> specific (the file can be moved later).
> 
> I note here the use of [driver_name] instead of platform-profile-N,
> which should allow basic userspace apps to skip the loop and name
> check, hardcoding /sys/class/activity/s2idle/{hint,hint_choices}. In
> addition, prefixing the files with hint allows reusing the scaffolding
> to implement other ABIs in the future, which would be hard to do with
> platform-profile.
> 
> For WMI drivers, [driver-name] would include an integer suffix as per
> convention for these drivers, with the first instance using 0.
> 
>> iv) Register an activity handler in s2idle.c and push the transition
>> logic in it. This way, other users do not have to abide by it. If
>> userspace is not activity hint aware, enter the state snooze in
>> begin(), and restore the prior state in end(). If there is a timing
>> quirk (such as for the Ally), we will store the jiffies of the last
>> transition and compare them in begin(). This way, when userspace
>> becomes activity hint-aware and enters snooze prior to beginning the
>> suspend sequence, the delay is shortened. Since userspace freeze by
>> the systemd freezer group (if enabled) and then suspend.c require
>> around 100ms-300ms, this eats more than half of the delay in this case
>> for traditional resume / suspend, and eliminates it for dark screen
>> wakeups that remain in snooze.

Thanks for the update. Will see what others will say about the activity
interface.

-- 
Best regards,
Dmitry
