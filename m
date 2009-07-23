From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: Re: next: sfi build fails when !CONFIG_ACPI
Date: Thu, 23 Jul 2009 15:28:29 +0400
Message-ID: <a4423d670907230428g48cd2b70wf3d26d2c1378503f@mail.gmail.com>
References: <a4423d670907160148n66760052wbef60e4a2c3c7941@mail.gmail.com>
	 <alpine.LFD.2.00.0907162145140.3531@sony-vgn-z540>
	 <a4423d670907170657o2c68c479j9b4810af5adad29f@mail.gmail.com>
	 <a4423d670907230143l78f324dewefa4cb8990ef4266@mail.gmail.com>
	 <20090723181525.475692d3@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754003AbZGWL2c@vger.kernel.org>
In-Reply-To: <20090723181525.475692d3@feng-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-next <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

2009/7/23 Feng Tang <feng.tang@intel.com>:
> On Thu, 23 Jul 2009 16:43:30 +0800
> Alexander Beregalov <a.beregalov@gmail.com> wrote:
>
>> 2009/7/17 Alexander Beregalov <a.beregalov@gmail.com>:
>> > 2009/7/17 Len Brown <lenb@kernel.org>:
>> >>> drivers/sfi/sfi_core.c: In function 'sfi_init':
>> >>> drivers/sfi/sfi_core.c:346: error: 'acpi_disabled' undeclared
>> >>> (first use in this function)
>> >>> drivers/sfi/sfi_core.c:346: error: (Each undeclared identifier i=
s
>> >>> reported only once
>> >>> drivers/sfi/sfi_core.c:346: error: for each function it appears
>> >>> in.)
>> >>>
>> >>>
>> >>> $ grep ACPI .config
>> >>> # Power management and ACPI options
>> >>
>> >> It builds for me.
>> >> Please send me the complete failing .config
>> >
>> > Attached (x86_64)
>>
>> Still fails for me in the same way,
>> X86_64
>> next-20090723
>
> sorry for the late response, please try the following patch:
It obviously works. Thanks

>
> diff --git a/drivers/sfi/sfi_core.c b/drivers/sfi/sfi_core.c
> index 62e2f98..fa66824 100644
> --- a/drivers/sfi/sfi_core.c
> +++ b/drivers/sfi/sfi_core.c
> @@ -361,9 +361,6 @@ static __init int sfi_find_syst(void)
>
> =C2=A0void __init sfi_init(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 if (!acpi_disabled)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disable_sfi();
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sfi_disabled)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> Thanks,
> Feng
>
