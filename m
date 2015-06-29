From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [Bugfix v3] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32-bit kernel
Date: Mon, 29 Jun 2015 10:55:14 +0200
Message-ID: <559107F2.3080701@pr.hu>
References: <20150624094916.GA5696@gmail.com>
 <1435141065-28536-1-git-send-email-jiang.liu@linux.intel.com>
 <20150624101843.GA8924@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150624101843.GA8924@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
List-Id: linux-acpi@vger.kernel.org

2015-06-24 12:18 keltez=E9ssel, Ingo Molnar =EDrta:
> * Jiang Liu <jiang.liu@linux.intel.com> wrote:
>
>> A regression report from Boszormenyi Zoltan <zboszor@pr.hu>:
>> There's a Realtek RTL8111/8168/8411 (PCI ID 10ec:8168, Subsystem ID =
1565:230e)
>> network chip on the mainboard. After the r8169 driver loaded, the IR=
Qs in
>> the machine went berserk. Keyboard keypressed arrived with considera=
ble
>> latency and duplicated, so no real work was possible. The machine re=
sponded
>> to the power button but didn't actually power down. It just stuck at=
 the
>> powering down message. I had to press the power button for 4 seconds=
 to power
>> it down.
>>
>> The computer is a POS machine with a big battery inside. Because of =
this,
>> either ACPI or the Realtek chip kept the bad state and after rebooti=
ng, the
>> network chip didn't even show up in lspci. Not even the PXE ROM anno=
unced
>> itself during boot. I had to disconnect the battery to beat some sen=
se back
>> to the computer.
>>
>> The regression happens with 4.0.5, 4.1.0-rc8 and 4.1.0-final. 3.18.1=
6 was
>> good.
> So please put this into quotes, like:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Zoltan Boszormenyi reported this regression:
>
>   "There's a Realtek RTL8111/8168/8411 (PCI ID 10ec:8168, Subsystem I=
D 1565:230e)
>    network chip on the mainboard. After the r8169 driver loaded, the =
IRQs in
>    the machine went berserk. Keyboard keypressed arrived with conside=
rable
>    latency and duplicated, so no real work was possible. The machine =
responded
>    to the power button but didn't actually power down. It just stuck =
at the
>    powering down message. I had to press the power button for 4 secon=
ds to power
>    it down.
> =20
>    The computer is a POS machine with a big battery inside. Because o=
f this,
>    either ACPI or the Realtek chip kept the bad state and after reboo=
ting, the
>    network chip didn't even show up in lspci. Not even the PXE ROM an=
nounced
>    itself during boot. I had to disconnect the battery to beat some s=
ense back
>    to the computer.
> =20
>    The regression happens with 4.0.5, 4.1.0-rc8 and 4.1.0-final. 3.18=
=2E16 was
>    good."
>
> ...
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Also note the indentation, that helps readability.
>
> Thanks,
>
> 	Ingo

So, will there be a v4 with a commit message satisfactory to Ingo
that will be part of 4.0.7/4.1.1 and 4.2?

Best regards,
Zolt=E1n
