Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5C3E3D95
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962068; cv=none; b=kv9FtZDcMj30tply5ECJso7dvWekwcAH3jaxCVxUGoJDkNH4kCXjlS4pQ4nqHAGvji2rbV0cGafe02cjFLsdkALKRdYNJ60w2A09Fkjl5DSwmjHe+tDhLEzWVviyqTpeuMItFgGHT3Ecl3KcmvLGKy11lcdXNthc8cSxOUUEdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962068; c=relaxed/simple;
	bh=rj7TSSe4JZgfLW3ywawInDrdzpkKfbFOPsbqOpk/VNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEUrCf/5yCsVhlZZK2i64YeS0FuR3CCy7aNFCwHaCqgLv3IuWBydCvpMrqa5+x5AzOqJzv5zJ0+neiYo/kKMTzgnwd/jKSu42XLFp+J5MRHE8aGfELoPcz2nQRxLJlLUZ4EIt+VPA10UDk3FTwzdRInZjqCJFQuCvejVkHtsRDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9GiqBzg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9GiqBzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF8EC2BCB2
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774962067;
	bh=rj7TSSe4JZgfLW3ywawInDrdzpkKfbFOPsbqOpk/VNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g9GiqBzgvM+8xGuEVSD5t8pe2xojog862uq+v2gD5DpH3uMwp4yNz81RBzhZE6F1g
	 VFjzrSiRsB+I0xsnmLc9zFTIfMb5MiFj5n7CLhFW3ANFGep6mblFhQlXMfhYrQB21Z
	 v4cV++kPmI30PDTvcjGqUfAR4xEoumQYJY/y6VLOA1myI3+Y47SCTbO60FIukJbw4b
	 5dcXH/Oc+0cldEqh1Ua9Sz2lkQbkxZJKIZfhDCsRcUAQgpmwQvdtTQ0Pw4wI2HjMhq
	 Wr8FzlH2HXyJpsGcaKHBLCwiu0aNR9TZxHzEPfd9DsCV0i0F092RheAE5XZTkOhGtH
	 NSQW0Lt1U/haQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4094b31a037so4038786fac.1
        for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 06:01:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJPt98dqROL9eCkHtvoJW6XkHAHgvYYXbvKCpH5o8hYTcSpyl7xmttUK2B2g/IQP+Mty+91Ua61LVN@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3OQe8CnTf64p7GYNvS6orHL4CRb2acTYGtvtyv6bEOzU4ryF
	bNCyMT9k0j7VOnp51l/o+29x39WXwMs3ROwCqEQSGdQGxrJcCBZch8IxiWJSwd2Fx37KFtgd54c
	uaCeg7GmzD9p7iXyKrP7o0CCAZS8uqL0=
X-Received: by 2002:a05:6870:21f5:b0:3ec:3d37:87da with SMTP id
 586e51a60fabf-41cec0e3156mr9926801fac.3.1774962066610; Tue, 31 Mar 2026
 06:01:06 -0700 (PDT)
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
 <CAJZ5v0gJcG2-TioBmc6DQf=fUQz+Aihb=_B9gmad_G54mVMvNA@mail.gmail.com>
 <CAJZ5v0gL=5r+drro7xQvPa2E4NCpWoWmAcTaAP_d49c4aMsg2A@mail.gmail.com> <7ee19eab-60e0-456d-a513-b8837b757777@huawei.com>
In-Reply-To: <7ee19eab-60e0-456d-a513-b8837b757777@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Mar 2026 15:00:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLgrQNuXppnVq37oD9WX+Rhhoj9rp6yHH5Tta723UhBQ@mail.gmail.com>
X-Gm-Features: AQROBzCtW6xCzwD_omGc5sEd_KcZoRojPLjGe7QMzBBEsSlIRi7A37ElKP0ZDOE
Message-ID: <CAJZ5v0iLgrQNuXppnVq37oD9WX+Rhhoj9rp6yHH5Tta723UhBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 2:48=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> On 3/31/2026 8:10 PM, Rafael J. Wysocki wrote:
> > On Tue, Mar 31, 2026 at 2:05=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >> Hi,
> >>
> >> On Tue, Mar 31, 2026 at 2:01=E2=80=AFPM lihuisong (C) <lihuisong@huawe=
i.com> wrote:
> >>>
> >>> On 3/28/2026 12:06 PM, lihuisong (C) wrote:
> >>>> On 3/27/2026 7:33 PM, Rafael J. Wysocki wrote:
> >>>>> On Fri, Mar 27, 2026 at 7:23=E2=80=AFAM lihuisong (C) <lihuisong@hu=
awei.com>
> >>>>> wrote:
> >>>>>> On 3/26/2026 9:39 PM, Rafael J. Wysocki wrote:
> >>>>>>> On Thu, Mar 26, 2026 at 1:17=E2=80=AFPM lihuisong (C)
> >>>>>>> <lihuisong@huawei.com> wrote:
> >>>>>>>> Hi Rafael,
> >>>>>>>>
> >>>>>>>> On 1/30/2026 9:59 AM, lihuisong (C) wrote:
> >>>>>>>>> Hi Rafael,
> >>>>>>>>>
> >>>>>>>>> On 1/15/2026 8:18 PM, lihuisong (C) wrote:
> >>>>>>>>>> On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
> >>>>>>>>>>> On Tue, Nov 25, 2025 at 8:29=E2=80=AFAM Huisong Li <lihuisong=
@huawei.com>
> >>>>>>>>>>> wrote:
> >>>>>>>>>>>> The global switch of cpuidle can be turned back on in some c=
ase.
> >>>>>>>>>>>> So add enable_cpuidle().
> >>>>>>>>>>> No, this is not going to work.  The "off" switch only affects
> >>>>>>>>>>> initialization AFAICS.
> >>>>>>>>>> I think it would be work.
> >>>>>>>>>> The cpuidle_not_available() also see the "off" on do_idle().
> >>>>>>>>>> And cpuidle_idle_call() check this function first and then sel=
ect
> >>>>>>>>>> idle state.
> >>>>>>>>>> Cpuidle doesn't select and enter idle state if this fuction
> >>>>>>>>>> return true.
> >>>>>>>>> I verified that disable_cpuidle() effectively prevents all CPUs=
 from
> >>>>>>>>> entering any idle states and the cpuidle function is correctly
> >>>>>>>>> restored after calling enable_cpuidle().
> >>>>>>>>> What do you think?
> >>>>>>>> Could you pleasetake a look atmy reply?
> >>>>>>>> If not ok, I will drop this from my upstream list.
> >>>>>>> Sorry, can you please remind me what problem you wanted to addres=
s
> >>>>>>> with the help of this?
> >>>>>> Regarding the discussion in the link[1], if driver fail to get pow=
er
> >>>>>> info in power notify,
> >>>>>> the old idle states may no longer be reliable. Therefore, patch 2/=
3
> >>>>>> disables ACPI idle
> >>>>>> via the new interface introduced in patch 1/3.
> >>>>>>
> >>>>>> However, our discussion on whether this new interface can disable =
ACPI
> >>>>>> idle has not yet reached a conclusion.
> >>>>>> Could you please revisit this thread? It's quite brief, and I'd
> >>>>>> appreciate your further input.
> >>>>>>
> >>>>>> [1]
> >>>>>> https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@hua=
wei.com
> >>>>>>
> >>>>> The "off" variable has been intended for disabling cpuidle via kern=
el
> >>>>> command line (note that the corresponding module param is read-only=
).
> >>>>>
> >>>>> disable_cpuidle() is only used by Xen now and only at the setup/ini=
t
> >>>>> stage.
> >>>>>
> >>>>> I don't think that using it on idle state list change notifications=
 is
> >>>>> a good idea.
> >>>> Understand.
> >>>>
> >>>>> Something like cpuidle_pause_and_lock() would be a better match I
> >>>>> think.  acpi_processor_hotplug() uses it already for a similar
> >>>>> purpose.
> >>>> Interfaces like cpuidle_pause_and_lock() and cpuidle_pause() disable
> >>>> cpuidle by clearing the global "initialized" flag,
> >>>> which requires "enabled_devices" to be non-zero.
> >>>> IIUC, cpuidle_disable_device() isn't called when a CPU goes offline;
> >>>> instead, it's handled in acpi_processor_hotplug() during online.
> >>>> This means "enabled_devices" stays above zero even if some CPUs are
> >>>> offline.
> >>>> In this case, the driver can still successfully set initialized to
> >>>> zero when get power information failed in power notify.
> >>>> So we can disable APCI idle on all CPUs.
> >>>> But we need to ensure that other threads wouldn't resume the
> >>>> "initialized" flag by interfaces like cpuidle_resume().
> >>>>
> >>>> I have found a scenario for that where acpi_processor_hotplug enable=
s
> >>>> the cpuidle_device and restores the "initialized" value.
> >>>> In this case, special processing may be required.
> >>>> For example, the cpuidle state of the cpuidle driver also need
> >>>> reinitialize or the disable cpuilde state is still maintained.
> >>>>
> >>> Hi Rafel,
> >>>
> >>> I have thought about this issue for a long time. I feel that it is a =
bit
> >>> tricky to handle.
> >>>
> >>> First, if the power information fails to be obtained from the power
> >>> notify, we want to disable the ACPI idle of all CPUs by calling
> >>> cpuidle_pause(). However, in the CPU hotplug scenario, when the idle
> >>> state may be unavailable, the idle state needs to be set up again.
> >>>
> >>> Second, I found that the current driver only calls
> >>> acpi_processor_setup_cpuidle_states() to update the idle states in
> >>> acpi_idle_driver.
> >>> Other variables in acpi_idle_driver also need to be initialized again=
.
> >>> For example, target_residency_ns and exit_latency_ns need to be updat=
ed.
> >>> For details, see the implementation of __cpuidle_register_driver().
> >>> These variables are used when selecting the state to enter (please se=
e
> >>> cpuidle_enter_state()).
> >>> Therefore, when the idle states information changes, the idle states =
we
> >>> actually use are still the old values.
> >>> This is also a problem.
> >>>
> >>> I am not sure whether we need to remove all cpuidle_device, remove
> >>> acpi_idle_driver, and then re-initialize and register acpi_idle_drive=
r
> >>> and register all cpuidle_device in power notify.
> >>> I think it is very likely that we need to do so.
> >> Well, yes, we do, but only if the list of available states has
> >> actually changed (that is, the number of states has changed or the
> >> latency values have changed).
> > What actually needs to be done there is to unregister the cpuidle
> > driver and register it again because the list of idle states is a
> > property of the driver.
>
> We also need to unregister and register cpuidle device again.
> Because the state count of ACPI idle driver may be changed, some
> releated sysfs need to be recreated.

Ah, right.  So all cpuidle needs to be torn down and re-created from
scratch then.

I'm starting to wonder if that's really worth it.
