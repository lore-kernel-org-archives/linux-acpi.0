Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F03D75B3
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959034; cv=none; b=rgCw5YmSaHCJ0AB6wcqMjvtRXtsUrgFmal5OqXPLGLxxt+US3hllhLX2dw6enKwXHI7rmAXln+vTqOqqIrY2XvCBs0+X34O0eXm0fAtOxBgZDEdAcnIYEa4ulDS9SIyhPKVDSiExu4LRwlc03R2GZ8C7kUbCohH5IpX+3nmR/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959034; c=relaxed/simple;
	bh=IHnxTbHnKh1VXk9O/nv2YSReV0edJnxIRryPH5qBIIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3FyVrg9o6orZgXELrJwENb9i2OscCzvq1LxV4YzzeWaC4wY1CWew0KVuVRuqtJVBjnjf0+gkeWPaOd3peozqtJ7sT9CKubAqTqS1O4XSHB4mMk0BCAxPr6DYUIQ+mf2LJUO2uU3WWNopgDXZpuC4W7f3an9fxuX4TQVT9gssHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sR+4xtIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sR+4xtIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230FAC2BCB7
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774959034;
	bh=IHnxTbHnKh1VXk9O/nv2YSReV0edJnxIRryPH5qBIIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sR+4xtIcSKrGpj5Z+6Hn6u2Gt/sCfbNsS0o00W83W6VDnk85lQ5NXEJoh7Sa3mH6k
	 ogXWbWXpwY4XqHeoALhB877nkKhaY8FAYHldN5e3E5SKdplFKgCa7/PZP75bVXBALP
	 84dqfqWjZYa6z7naRzCbeyHJcNROb9Gc0k7MhOykxqmb+jBxRXjvH6gconogKavepj
	 8JjQfylJUB4JecvrLssXMbQBXd9WDecuR2aTAsI1Nx/7gEds4XcCpwmAsaM9ZjRe1k
	 QpgRmJIofVM/PFTQ1BIzOFGXYB61U/ytNEnEF6YZ0ShEkbTMYBi7lM8V8rLvMsXS2v
	 8EmQxpXJ4p6HQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4042905015cso3378278fac.0
        for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 05:10:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YzT6qr7ttNXUfm9+Prl0JaVZe/dBkHnX4z2EAM1xRNcgbWd4beX
	xkZxMcGuws3DOuqZNl/4RFyONRG0tuTkSq8Xws2smhHj9nLZFAwOotQs1VsbOQrqHVrPoCTbCj4
	fnKXAJdfYknDyh1jn7ViMBH4wmU4IyJ4=
X-Received: by 2002:a05:6870:1799:b0:417:5a8c:feba with SMTP id
 586e51a60fabf-41cec0e2a15mr8030069fac.12.1774959033203; Tue, 31 Mar 2026
 05:10:33 -0700 (PDT)
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
In-Reply-To: <CAJZ5v0gJcG2-TioBmc6DQf=fUQz+Aihb=_B9gmad_G54mVMvNA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Mar 2026 14:10:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gL=5r+drro7xQvPa2E4NCpWoWmAcTaAP_d49c4aMsg2A@mail.gmail.com>
X-Gm-Features: AQROBzCfQ50gHtf7lvPrNQFKKcdNe1cC0M-J1GVbdkErcR9-MRHR-v-otF3FQKQ
Message-ID: <CAJZ5v0gL=5r+drro7xQvPa2E4NCpWoWmAcTaAP_d49c4aMsg2A@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sudeep.Holla@arm.com, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 2:05=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi,
>
> On Tue, Mar 31, 2026 at 2:01=E2=80=AFPM lihuisong (C) <lihuisong@huawei.c=
om> wrote:
> >
> >
> > On 3/28/2026 12:06 PM, lihuisong (C) wrote:
> > >
> > > On 3/27/2026 7:33 PM, Rafael J. Wysocki wrote:
> > >> On Fri, Mar 27, 2026 at 7:23=E2=80=AFAM lihuisong (C) <lihuisong@hua=
wei.com>
> > >> wrote:
> > >>>
> > >>> On 3/26/2026 9:39 PM, Rafael J. Wysocki wrote:
> > >>>> On Thu, Mar 26, 2026 at 1:17=E2=80=AFPM lihuisong (C)
> > >>>> <lihuisong@huawei.com> wrote:
> > >>>>> Hi Rafael,
> > >>>>>
> > >>>>> On 1/30/2026 9:59 AM, lihuisong (C) wrote:
> > >>>>>> Hi Rafael,
> > >>>>>>
> > >>>>>> On 1/15/2026 8:18 PM, lihuisong (C) wrote:
> > >>>>>>> On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
> > >>>>>>>> On Tue, Nov 25, 2025 at 8:29=E2=80=AFAM Huisong Li <lihuisong@=
huawei.com>
> > >>>>>>>> wrote:
> > >>>>>>>>> The global switch of cpuidle can be turned back on in some ca=
se.
> > >>>>>>>>> So add enable_cpuidle().
> > >>>>>>>> No, this is not going to work.  The "off" switch only affects
> > >>>>>>>> initialization AFAICS.
> > >>>>>>> I think it would be work.
> > >>>>>>> The cpuidle_not_available() also see the "off" on do_idle().
> > >>>>>>> And cpuidle_idle_call() check this function first and then sele=
ct
> > >>>>>>> idle state.
> > >>>>>>> Cpuidle doesn't select and enter idle state if this fuction
> > >>>>>>> return true.
> > >>>>>> I verified that disable_cpuidle() effectively prevents all CPUs =
from
> > >>>>>> entering any idle states and the cpuidle function is correctly
> > >>>>>> restored after calling enable_cpuidle().
> > >>>>>> What do you think?
> > >>>>> Could you pleasetake a look atmy reply?
> > >>>>> If not ok, I will drop this from my upstream list.
> > >>>> Sorry, can you please remind me what problem you wanted to address
> > >>>> with the help of this?
> > >>> Regarding the discussion in the link[1], if driver fail to get powe=
r
> > >>> info in power notify,
> > >>> the old idle states may no longer be reliable. Therefore, patch 2/3
> > >>> disables ACPI idle
> > >>> via the new interface introduced in patch 1/3.
> > >>>
> > >>> However, our discussion on whether this new interface can disable A=
CPI
> > >>> idle has not yet reached a conclusion.
> > >>> Could you please revisit this thread? It's quite brief, and I'd
> > >>> appreciate your further input.
> > >>>
> > >>> [1]
> > >>> https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@huaw=
ei.com
> > >>>
> > >> The "off" variable has been intended for disabling cpuidle via kerne=
l
> > >> command line (note that the corresponding module param is read-only)=
.
> > >>
> > >> disable_cpuidle() is only used by Xen now and only at the setup/init
> > >> stage.
> > >>
> > >> I don't think that using it on idle state list change notifications =
is
> > >> a good idea.
> > >
> > > Understand.
> > >
> > >>
> > >> Something like cpuidle_pause_and_lock() would be a better match I
> > >> think.  acpi_processor_hotplug() uses it already for a similar
> > >> purpose.
> > >
> > > Interfaces like cpuidle_pause_and_lock() and cpuidle_pause() disable
> > > cpuidle by clearing the global "initialized" flag,
> > > which requires "enabled_devices" to be non-zero.
> > > IIUC, cpuidle_disable_device() isn't called when a CPU goes offline;
> > > instead, it's handled in acpi_processor_hotplug() during online.
> > > This means "enabled_devices" stays above zero even if some CPUs are
> > > offline.
> > > In this case, the driver can still successfully set initialized to
> > > zero when get power information failed in power notify.
> > > So we can disable APCI idle on all CPUs.
> > > But we need to ensure that other threads wouldn't resume the
> > > "initialized" flag by interfaces like cpuidle_resume().
> > >
> > > I have found a scenario for that where acpi_processor_hotplug enables
> > > the cpuidle_device and restores the "initialized" value.
> > > In this case, special processing may be required.
> > > For example, the cpuidle state of the cpuidle driver also need
> > > reinitialize or the disable cpuilde state is still maintained.
> > >
> > Hi Rafel,
> >
> > I have thought about this issue for a long time. I feel that it is a bi=
t
> > tricky to handle.
> >
> > First, if the power information fails to be obtained from the power
> > notify, we want to disable the ACPI idle of all CPUs by calling
> > cpuidle_pause(). However, in the CPU hotplug scenario, when the idle
> > state may be unavailable, the idle state needs to be set up again.
> >
> > Second, I found that the current driver only calls
> > acpi_processor_setup_cpuidle_states() to update the idle states in
> > acpi_idle_driver.
> > Other variables in acpi_idle_driver also need to be initialized again.
> > For example, target_residency_ns and exit_latency_ns need to be updated=
.
> > For details, see the implementation of __cpuidle_register_driver().
> > These variables are used when selecting the state to enter (please see
> > cpuidle_enter_state()).
> > Therefore, when the idle states information changes, the idle states we
> > actually use are still the old values.
> > This is also a problem.
> >
> > I am not sure whether we need to remove all cpuidle_device, remove
> > acpi_idle_driver, and then re-initialize and register acpi_idle_driver
> > and register all cpuidle_device in power notify.
> > I think it is very likely that we need to do so.
>
> Well, yes, we do, but only if the list of available states has
> actually changed (that is, the number of states has changed or the
> latency values have changed).

What actually needs to be done there is to unregister the cpuidle
driver and register it again because the list of idle states is a
property of the driver.
