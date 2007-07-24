From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: 2.6.23rc1 git: EIP is at acpi_processor_throttling_seq_show+0x8b/0xdd [processor]
Date: Tue, 24 Jul 2007 17:50:03 +0200
Message-ID: <200707241750.03588.arekm@maven.pl>
References: <200707231740.38263.arekm@maven.pl> <200707231226.35183.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.carme.maven.pl ([193.239.45.138]:35696 "EHLO
	main.carme.maven.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbXGXPuM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jul 2007 11:50:12 -0400
In-Reply-To: <200707231226.35183.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday 23 of July 2007, Len Brown wrote:
> On Monday 23 July 2007 11:40, Arkadiusz Miskiewicz wrote:
> > After booting fresh 2.6.23rc1 taken from git I noticed oops in dmes=
g:
> >
> > [   46.274038] BUG: unable to handle kernel NULL pointer dereferenc=
e at
> > virtual address 00000000 [   46.274042]  printing eip:
> > [   46.274044] f8b5b2dc
> > [   46.274045] *pde =3D 00000000
> > [   46.274048] Oops: 0000 [#1]
[...]
>
> Please try the patch below -- seems that I somehow neglected to inclu=
de it
> in my rc1 batch.

No oops with patch applied. Thanks!

>
> thanks,
> -Len
>
> Subject: fix oops due to typo in new throttling code
> From: Luming Yu <luming.yu@gmail.com>
>
>
> Signed-off-by: Luming Yu <luming.yu@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Len Brown <len.brown@intel.com>
>
> ---
>
>  drivers/acpi/processor_throttling.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> Index: linus/drivers/acpi/processor_throttling.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linus.orig/drivers/acpi/processor_throttling.c
> +++ linus/drivers/acpi/processor_throttling.c
> @@ -658,18 +658,20 @@ static int acpi_processor_throttling_seq
>  		   pr->throttling.state_count - 1);
>
>  	seq_puts(seq, "states:\n");
> -	if (acpi_processor_get_throttling =3D=3D acpi_processor_get_throttl=
ing_fadt)
> +	if (pr->throttling.acpi_processor_get_throttling =3D=3D
> +			acpi_processor_get_throttling_fadt) {
>  		for (i =3D 0; i < pr->throttling.state_count; i++)
>  			seq_printf(seq, "   %cT%d:                  %02d%%\n",
>  				   (i =3D=3D pr->throttling.state ? '*' : ' '), i,
>  				   (pr->throttling.states[i].performance ? pr->
>  				    throttling.states[i].performance / 10 : 0));
> -	else
> +	} else {
>  		for (i =3D 0; i < pr->throttling.state_count; i++)
>  			seq_printf(seq, "   %cT%d:                  %02d%%\n",
>  				   (i =3D=3D pr->throttling.state ? '*' : ' '), i,
>  				   (int)pr->throttling.states_tss[i].
>  				   freqpercentage);
> +	}
>
>        end:
>  	return 0;



--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
