From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: linux-next: Tree for July 20 (acpi/apei/ghes)
Date: Thu, 21 Jul 2011 00:06:59 +0200
Message-ID: <CA+icZUWeYkmrx+UF2Vfitx_6hnzzrGJk-wHC1gdEN0jMBznKtQ@mail.gmail.com>
References: <20110720180041.5774ca335e6697c17374dca5@canb.auug.org.au>
	<20110720093633.ca9cf794.rdunlap@xenotime.net>
	<20110720093829.aae2ec63.rdunlap@xenotime.net>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110720093829.aae2ec63.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 20, 2011 at 6:38 PM, Randy Dunlap <rdunlap@xenotime.net> wr=
ote:
> On Wed, 20 Jul 2011 09:36:33 -0700 Randy Dunlap wrote:
>
>> On Wed, 20 Jul 2011 18:00:41 +1000 Stephen Rothwell wrote:
>>
>> > Hi all,
>>
>> On i386 (X86_32):
>>
>> drivers/acpi/apei/ghes.c:542: warning: integer overflow in expressio=
n
>> drivers/acpi/apei/ghes.c:619: warning: integer overflow in expressio=
n
>>
>> ghes.c:(.text+0x46289): undefined reference to `__udivdi3'
>> =C2=A0 in function ghes_estatus_cache_add().
>
> That's on:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0period =3D dur=
ation / (count + 1);
>
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your c=
ode ***
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

Same here on i386 with CONFIG_ACPI_APEI_GHES=3Dy.

  LD      .tmp_vmlinux1
drivers/built-in.o: In function `ghes_estatus_cache_add':
ghes.c:(.text+0x43d91): undefined reference to `__udivdi3'
make[4]: *** [.tmp_vmlinux1] Error 1

- Sedat -
