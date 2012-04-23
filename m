From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: Warning: pnp 00:0b: can't evaluate _CRS: 12311
Date: Mon, 23 Apr 2012 14:03:01 +0200
Message-ID: <CA+icZUUGFaz0c-tHa9EGUxZaxPj_M=zrE+kE0dv5UMoA6GyN3w@mail.gmail.com>
References: <CA+icZUWVwUr19xL0Dn5mHnZjQaVjj6VYD3BMMktEWO0vgoZEXw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+icZUWVwUr19xL0Dn5mHnZjQaVjj6VYD3BMMktEWO0vgoZEXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Adam Belay <abelay@mit.edu>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 23, 2012 at 11:48 AM, Sedat Dilek
<sedat.dilek@googlemail.com> wrote:
> [ Please CC me I am not subscribed to this ML ]
>
> Hi,
>
> with a self-compiled linux-3.4-rc4 I am seeing this bugs/failures/war=
nings:
>
> [ =C2=A0 =C2=A00.241572] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query=
 ignored
>
> [ =C2=A0 =C2=A00.279385] =C2=A0pci0000:00: ACPI _OSC request failed (=
AE_ERROR),
> returned control mask: 0x1d
>
> [ =C2=A0 =C2=A00.293699] system 00:0a: Plug and Play ACPI device, IDs=
 PNP0c02 (active)
> [ =C2=A0 =C2=A00.294032] ACPI Error: Invalid/unsupported resource des=
criptor:
> Type 0x00 (20120320/utresrc-650)
> [ =C2=A0 =C2=A00.294037] pnp 00:0b: can't evaluate _CRS: 12311
>
> The same outputs I have seen also with an unsupported drm-intel-next
> kernel from Ubuntu/PPA archives [1].
>
> What does ist mean? Is it harmless? Buggy firmware/bios?
>
> Do you need more background infos (dmesg, kernel-config, etc.)?
>
> Regards,
> - Sedat -
>
> [1] http://kernel.ubuntu.com/~kernel-ppa/mainline/drm-intel-next/curr=
ent/

I have upgraded this Samsung series-5 notebook from BIOS version 05XK
to 06XK, but the pnp/_CRS warning still remains.

- Sedat -
