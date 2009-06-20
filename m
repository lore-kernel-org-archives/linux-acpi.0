From: Mahmood Naderan <mahmood.nt@gmail.com>
Subject: Re: BIOS and CPU C_states are strange
Date: Sat, 20 Jun 2009 11:24:51 +0430
Message-ID: <1acba2fa0906192354i3cb0f2dbp2c8abed6704db3f@mail.gmail.com>
References: <1acba2fa0906191006i3cd5a035pf18e096fdb92e27e@mail.gmail.com>
	 <1acba2fa0906191007l4b8d5c17id068d868e6178fb8@mail.gmail.com>
	 <ff05f3d00906191956m48655da5wc28a5553220ffdd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:35818 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbZFTGyu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jun 2009 02:54:50 -0400
Received: by bwz9 with SMTP id 9so2137734bwz.37
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2009 23:54:51 -0700 (PDT)
In-Reply-To: <ff05f3d00906191956m48655da5wc28a5553220ffdd0@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
> Only simple check value of edx.
> Well, unless CPU uses CPUID.5.EDX[31:20], the reserved area.

You mean that powertop is not correctly reading the states? Do you
mean that the BIOS reports better that the CPU ?

--------------------------
*Mahmood Naderan*



On Sat, Jun 20, 2009 at 7:26 AM, Edward Shao <laface.tw@gmail.com> wrot=
e:
>
> Hi Mahmood,
>
> So far as I know, if your CPU is Intel, powertop maybe cause a mislea=
ding.
> Powertop uses CPUID.5.EDX to check CPU supported C states.
> According Intel's spec (Intel Processor Identification and the CPUID
> Instruction (Application Note 485), a CPU only has
>
> C0, C1, C2, C3, C4 (prior Core i7)
> C0, C1, C2, C6, C7 (Core i7 and subsequent)
>
> Check with source code of powertop
> while (edx) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (edx&7)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("C%i ", i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0edx =3D edx >> 4;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i++;
> =A0 =A0 =A0 =A0}
> Only simple check value of edx.
> Well, unless CPU uses CPUID.5.EDX[31:20], the reserved area.
>
> Ps: I does not check AMD's spec.
>
> Best Regards,
> Edward
>
>
> On Sat, Jun 20, 2009 at 1:07 AM, Mahmood Naderan<mahmood.nt@gmail.com=
> wrote:
> > Hi,
> > I have run powertop with root permission with both AC and batter po=
wers. The
> > reported C_States are the same and strange:
> >
> > mahmood@magma:~$ sudo powertop
> > PowerTOP 1.11 =A0 (C) 2007, 2008 Intel Corporation
> >
> > Collecting data for 5 seconds
> >
> > Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6
> > Your BIOS reports the following C-states : C1 C2 C6
> >
> > Where are C4 and C5?
> >
> > --------------------------
> > *Mahmood Naderan*
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
>
>
>
> --
> Best Regards,
> Edward
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
