From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/radeon: add new AMD ACPI header and update relevant code
Date: Thu, 26 Jul 2012 15:58:04 -0400
Message-ID: <CADnq5_MRn49Kf3amZ=tqYJQv++jWw7UhypGspJuNXyhokEyVVQ@mail.gmail.com>
References: <1343237889-5220-1-git-send-email-alexdeucher@gmail.com>
	<20120726125838.GA28853@growl>
	<CADnq5_Nr8S+kzdKVq9=VL9BVK+4eFeX0egs-rkiv882MAm3bow@mail.gmail.com>
	<20120726193346.GA11288@growl>
	<CADnq5_NY8hX3g7-gvahHvDM__2xk_s5ZU7zgLhyY0QQvJon6cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55576 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab2GZT6G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jul 2012 15:58:06 -0400
Received: by weyx8 with SMTP id x8so1598310wey.19
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2012 12:58:05 -0700 (PDT)
In-Reply-To: <CADnq5_NY8hX3g7-gvahHvDM__2xk_s5ZU7zgLhyY0QQvJon6cA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Thu, Jul 26, 2012 at 3:42 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Thu, Jul 26, 2012 at 3:33 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>> On Thu, Jul 26, 2012 at 11:35:25AM -0400, Alex Deucher wrote:
>>> On Thu, Jul 26, 2012 at 8:58 AM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>>> > The other missing bit is how to actually change the brightness... Alex,
>>> > do you know what registers to poke?
>>>
>>> You need to check if the GPU controls the backlight or the system
>>> does.  I think the attached patches should point you in the right
>>> direction.
>>
>> Yep :)
>>
>> 0050:  ATOM_FIRMWARE_CAPABILITY_ACCESS usFirmwareCapability :
>>   0050:  (union) ATOM_FIRMWARE_CAPABILITY sbfAccess          :
>>     USHORT GPUControlsBL:1                              = 0x0001     (1)
>>
>> The panel is using the INTERNAL_UNIPHY encoder, and I see the
>> UNIPHYTransmitterControl command table.
>>
>> Interaction with video.ko is still a bit messy...
>>
>> Do you already have code for handling the notifications? I'll work on it
>> in the weekend otherwise ;)
>
> I don't have patches for that.  Please feel free to work on it :)

One thing worth checking, the sbios may write the requested backlight
level to the bios scratch reg, in which case the driver only has to
execute the BL_BRIGHTNESS action rather than writing the requested
level to the register first.

Alex

>
> Thanks,
>
> Alex
