From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: BIOS and CPU C_states are strange
Date: Mon, 22 Jun 2009 09:34:37 +0800
Message-ID: <1245634477.3611.40.camel@localhost.localdomain>
References: <1acba2fa0906191006i3cd5a035pf18e096fdb92e27e@mail.gmail.com>
	 <1acba2fa0906191007l4b8d5c17id068d868e6178fb8@mail.gmail.com>
	 <a8ca10150906200826l37a7ee2fs283ecfa955697c49@mail.gmail.com>
	 <1acba2fa0906200846r751cf235q9e155e5445090d40@mail.gmail.com>
	 <a8ca10150906201504p2186b3fbg5ac7761946f48697@mail.gmail.com>
	 <1acba2fa0906210218o59a6c92fi86e30891c0816b5d@mail.gmail.com>
	 <1acba2fa0906210220p27b9e902xd640029fa0122b24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2733 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbZFVBda (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jun 2009 21:33:30 -0400
In-Reply-To: <1acba2fa0906210220p27b9e902xd640029fa0122b24@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mahmood Naderan <mahmood.nt@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2009-06-21 at 17:20 +0800, Mahmood Naderan wrote:
> I got more confused... In my first post if you see, BIOS reports C1,
> C2 and C6. Even it does not support C3 (!),  but here is the output o=
f
> "cat /proc/acpi/processor/CPU0/power":
>=20
> active state:            C0
> max_cstate:              C8
> bus master activity:     00000000
> maximum allowed latency: 2000000000 usec
> states:
>    C1:                  type[C1] promotion[--] demotion[--]
> latency[001] usage[00000063] duration[00000000000000000000]
>    C2:                  type[C2] promotion[--] demotion[--]
> latency[001] usage[00017466] duration[00000000000014422985]
>    C3:                  type[C3] promotion[--] demotion[--]
> latency[162] usage[00096196] duration[00000000000650582389]
>=20
> So I think something (BIOS or CPU or OS) is malfunctioning and does
> not report correctly.
> Now the big question is, will my system (a combination of CPU, BIOS
> and OS) enter C3 (or even deeper states)?
What is your problem?

The following info only tells us that the following CPU C-state is
supported on the CPU.
>=EF=BB=BFYour CPU supports the following C-states : C1 C2 C3 C4 C5 C6

But not all the CPU C-state is not used by the OS.
It seems that the C1/C2/C6 is used on this box.

At the same time it is noted that the cpu C-state is different with the
ACPI C-state. In fact BIOS will do the mapping between the CPU C-state
and ACPI C-state. And ACPI C-state is used by the OS.
=46or example: on your box: The CPU C6 is mapped to ACPI C3-state.

>From the info of "cat /proc/acpi/processor/CPU*/power" we know that yo=
ur
box can enter the ACPI C3, which is mapped to the CPU C6. Of course it
is the deep C-state.

Thanks.

>=20
> --------------------------
> *Mahmood Naderan*
>=20
>=20
>=20
>=20
> On Sun, Jun 21, 2009 at 2:34 AM, Ananth Narayan
> S<ananth.narayan@gmail.com> wrote:
> > You could see it that way. The OS will use the C states exported by
> > the BIOS. If C4/C5 are not exported, the OS will not even know that
> > such states exist. If you query /proc/acpi/CPU*/power, you'll proba=
bly
> > see just three C states listed (C1, C2, C3). Typically the last
> > C-state (C3) in that will map to the lowest C-state supported by th=
e
> > processor.
> >
> > -- Ananth
> >
> >
> >
> >
> > On Sat, Jun 20, 2009 at 8:46 AM, Mahmood Naderan<mahmood.nt@gmail.c=
om> wrote:
> >> Hi,
> >> So if my understanding is correct, the BIOS does not allow the CPU=
 to
> >> enter C4 and C5 states. Right?
> >>
> >> --------------------------
> >> *Mahmood Naderan*
> >>
> >>
> >>
> >>
> >> On Sat, Jun 20, 2009 at 7:56 PM, Ananth Narayan
> >> S<ananth.narayan@gmail.com> wrote:
> >>> Intel processors export a max supported c state value. But when i=
t
> >>> comes to c states, typically the one that provides max power savi=
ngs
> >>> is exported by the BIOS. The intermediate ones aren't.
> >>>
> >>> -- Ananth Narayan S.
> >>>
> >>>
> >>>
> >>>
> >>> On Fri, Jun 19, 2009 at 10:07 AM, Mahmood Naderan<mahmood.nt@gmai=
l.com> wrote:
> >>>> Hi,
> >>>> I have run powertop with root permission with both AC and batter=
 powers. The
> >>>> reported C_States are the same and strange:
> >>>>
> >>>> mahmood@magma:~$ sudo powertop
> >>>> PowerTOP 1.11   (C) 2007, 2008 Intel Corporation
> >>>>
> >>>> Collecting data for 5 seconds
> >>>>
> >>>> Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6
> >>>> Your BIOS reports the following C-states : C1 C2 C6
> >>>>
> >>>> Where are C4 and C5?
> >>>>
> >>>> --------------------------
> >>>> *Mahmood Naderan*
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe linux-=
acpi" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
> >>>>
> >>>
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
