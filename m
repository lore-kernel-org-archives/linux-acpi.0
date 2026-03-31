Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195603DCDAA
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958765; cv=none; b=oJRXjYh61Y2C8YdE8Wq/gbegpN133hnAQ3In18qRQS5AOGlEd+WKTd+SZXXHo8E9ueZy9j002PfpK4IXFQN0XP4GgT9EeK8zwqy718gRsJZj8M8EdhzsmcQZLz2MueQbUnKl/WqD02nUUWbLBc5H3WldF+VGMXnxkc1SpIL6suA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958765; c=relaxed/simple;
	bh=NMX7s3A84PXHn6YWZom+4ULFbwYJT2fQW87GJWOinJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sltzh2FtCwcYFVMzFlpdVXJknunw95HCYPdGrEZXmtqz9V+1o9dPj6jNV/PNGd7r032o0Wb4u0pl/JiV2O8Z28X+BVDZOu6XmGLYLfN7AvZL5Laya9DIJbvj2e1Wk+CZCej0RHMw3kZUrV+Hk3Rhoq/X/8wst0xVGQok49KN3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuCY5Zz3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuCY5Zz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF31C2BCB9
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774958764;
	bh=NMX7s3A84PXHn6YWZom+4ULFbwYJT2fQW87GJWOinJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FuCY5Zz37WJZwAVo9eUoq6nUbI4h7ivOONih5Kb5ChazvMhiympmQGPRmOhQI0Uye
	 yhAOO9ajIS5mSxUDQS487NVelOzNZjQitPcbA0FpuQ/OD33AqLAzOmshXKFsKQt3LM
	 KPzYNWlXql5LHy6bPkCG0WjeaSRs586QdQn7TniRCnp78MSYeikJKC+jt6UTCywooR
	 dh5oVk0VLJeupHFv1K0ofQyrz2IiohOAlBsU2hvTBpIeFHlQMSUKCmDXxWR8gfBDn8
	 rgPH6dcj+ywL3qmQO7zJW6fAxra/ar1CzVJZKXXL9+h2CClo9YtdGwOQIykdAXkdk4
	 jzvJs/VkpAdDA==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-467161c4b7aso2098513b6e.1
        for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 05:06:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWs3E8oKc4hbEeGbcT42orckqFtGlH5bhepTl9r+BqhV035rRk9nSQNjMO9U+nqlZnyR1rsTF1ZSUFM@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkzJyIfn1t5gsBcH/9u8oPVv9xPtYOgsIUyWc9pC/oXKIj/XS
	An0ZxR7nwVyWU7Oupxr19l09pKbqKVh8tPSVIBZqJXQM7aq5VSXfkvz3AJym4QYtIK+Q82HJv4p
	zn9t2JsMMxKYjui3YjhpqhZhILhK3CNs=
X-Received: by 2002:a05:6808:1906:b0:467:2584:870d with SMTP id
 5614622812f47-46a8a6434afmr7597483b6e.48.1774958763783; Tue, 31 Mar 2026
 05:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125072933.3706006-1-lihuisong@huawei.com>
 <20251125072933.3706006-2-lihuisong@huawei.com> <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
 <11f9d333-4d18-463a-817f-d3f450d1624e@huawei.com> <2d2d2d40-c73a-4988-90fe-fad75e35c75b@huawei.com>
 <f2be1178-28f4-4412-adb7-1530944a76ed@huawei.com> <CAJZ5v0heJsOWA5z7CwrON4zvaebj8-C_HBe5ymYa+FAbfJgy1A@mail.gmail.com>
 <3948b6fe-2aa6-4e38-9d58-c0e25e48fe93@huawei.com> <CAJZ5v0jPhW_spgjhfeig96G9pMEYb27_EKEYz17eZngrDLY7iA@mail.gmail.com>
 <47d38645-235b-43af-ac0b-300af338db31@huawei.com> <525c4cce-288e-447d-a890-d2d0b262984f@huawei.com>
In-Reply-To: <525c4cce-288e-447d-a890-d2d0b262984f@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Mar 2026 14:05:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gJcG2-TioBmc6DQf=fUQz+Aihb=_B9gmad_G54mVMvNA@mail.gmail.com>
X-Gm-Features: AQROBzAe9yQjHt-bjzG8f3Dd0UOVy6rLkIXInrsVPjU4jPHwU3EIxTztIYYJ-4Q
Message-ID: <CAJZ5v0gJcG2-TioBmc6DQf=fUQz+Aihb=_B9gmad_G54mVMvNA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 31, 2026 at 2:01=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> On 3/28/2026 12:06 PM, lihuisong (C) wrote:
> >
> > On 3/27/2026 7:33 PM, Rafael J. Wysocki wrote:
> >> On Fri, Mar 27, 2026 at 7:23=E2=80=AFAM lihuisong (C) <lihuisong@huawe=
i.com>
> >> wrote:
> >>>
> >>> On 3/26/2026 9:39 PM, Rafael J. Wysocki wrote:
> >>>> On Thu, Mar 26, 2026 at 1:17=E2=80=AFPM lihuisong (C)
> >>>> <lihuisong@huawei.com> wrote:
> >>>>> Hi Rafael,
> >>>>>
> >>>>> On 1/30/2026 9:59 AM, lihuisong (C) wrote:
> >>>>>> Hi Rafael,
> >>>>>>
> >>>>>> On 1/15/2026 8:18 PM, lihuisong (C) wrote:
> >>>>>>> On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
> >>>>>>>> On Tue, Nov 25, 2025 at 8:29=E2=80=AFAM Huisong Li <lihuisong@hu=
awei.com>
> >>>>>>>> wrote:
> >>>>>>>>> The global switch of cpuidle can be turned back on in some case=
.
> >>>>>>>>> So add enable_cpuidle().
> >>>>>>>> No, this is not going to work.  The "off" switch only affects
> >>>>>>>> initialization AFAICS.
> >>>>>>> I think it would be work.
> >>>>>>> The cpuidle_not_available() also see the "off" on do_idle().
> >>>>>>> And cpuidle_idle_call() check this function first and then select
> >>>>>>> idle state.
> >>>>>>> Cpuidle doesn't select and enter idle state if this fuction
> >>>>>>> return true.
> >>>>>> I verified that disable_cpuidle() effectively prevents all CPUs fr=
om
> >>>>>> entering any idle states and the cpuidle function is correctly
> >>>>>> restored after calling enable_cpuidle().
> >>>>>> What do you think?
> >>>>> Could you pleasetake a look atmy reply?
> >>>>> If not ok, I will drop this from my upstream list.
> >>>> Sorry, can you please remind me what problem you wanted to address
> >>>> with the help of this?
> >>> Regarding the discussion in the link[1], if driver fail to get power
> >>> info in power notify,
> >>> the old idle states may no longer be reliable. Therefore, patch 2/3
> >>> disables ACPI idle
> >>> via the new interface introduced in patch 1/3.
> >>>
> >>> However, our discussion on whether this new interface can disable ACP=
I
> >>> idle has not yet reached a conclusion.
> >>> Could you please revisit this thread? It's quite brief, and I'd
> >>> appreciate your further input.
> >>>
> >>> [1]
> >>> https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@huawei=
.com
> >>>
> >> The "off" variable has been intended for disabling cpuidle via kernel
> >> command line (note that the corresponding module param is read-only).
> >>
> >> disable_cpuidle() is only used by Xen now and only at the setup/init
> >> stage.
> >>
> >> I don't think that using it on idle state list change notifications is
> >> a good idea.
> >
> > Understand.
> >
> >>
> >> Something like cpuidle_pause_and_lock() would be a better match I
> >> think.  acpi_processor_hotplug() uses it already for a similar
> >> purpose.
> >
> > Interfaces like cpuidle_pause_and_lock() and cpuidle_pause() disable
> > cpuidle by clearing the global "initialized" flag,
> > which requires "enabled_devices" to be non-zero.
> > IIUC, cpuidle_disable_device() isn't called when a CPU goes offline;
> > instead, it's handled in acpi_processor_hotplug() during online.
> > This means "enabled_devices" stays above zero even if some CPUs are
> > offline.
> > In this case, the driver can still successfully set initialized to
> > zero when get power information failed in power notify.
> > So we can disable APCI idle on all CPUs.
> > But we need to ensure that other threads wouldn't resume the
> > "initialized" flag by interfaces like cpuidle_resume().
> >
> > I have found a scenario for that where acpi_processor_hotplug enables
> > the cpuidle_device and restores the "initialized" value.
> > In this case, special processing may be required.
> > For example, the cpuidle state of the cpuidle driver also need
> > reinitialize or the disable cpuilde state is still maintained.
> >
> Hi Rafel,
>
> I have thought about this issue for a long time. I feel that it is a bit
> tricky to handle.
>
> First, if the power information fails to be obtained from the power
> notify, we want to disable the ACPI idle of all CPUs by calling
> cpuidle_pause(). However, in the CPU hotplug scenario, when the idle
> state may be unavailable, the idle state needs to be set up again.
>
> Second, I found that the current driver only calls
> acpi_processor_setup_cpuidle_states() to update the idle states in
> acpi_idle_driver.
> Other variables in acpi_idle_driver also need to be initialized again.
> For example, target_residency_ns and exit_latency_ns need to be updated.
> For details, see the implementation of __cpuidle_register_driver().
> These variables are used when selecting the state to enter (please see
> cpuidle_enter_state()).
> Therefore, when the idle states information changes, the idle states we
> actually use are still the old values.
> This is also a problem.
>
> I am not sure whether we need to remove all cpuidle_device, remove
> acpi_idle_driver, and then re-initialize and register acpi_idle_driver
> and register all cpuidle_device in power notify.
> I think it is very likely that we need to do so.

Well, yes, we do, but only if the list of available states has
actually changed (that is, the number of states has changed or the
latency values have changed).
