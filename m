From: Thomas Renninger <trenn@suse.de>
Subject: Re: Acer Aspire 9813WKMI fan runs all the time after suspend to ram
Date: Tue, 06 May 2008 16:51:59 +0200
Message-ID: <1210085519.4802.48.camel@linux-2bdv.site>
References: <28220299.1210016955623.JavaMail.apache@eni-cpps13.sth.basefarm.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50865 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755201AbYEFMwK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 May 2008 08:52:10 -0400
In-Reply-To: <28220299.1210016955623.JavaMail.apache@eni-cpps13.sth.basefarm.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: v-j-m@suomi24.fi
Cc: linux-acpi@vger.kernel.org


On Mon, 2008-05-05 at 21:49 +0200, JM wrote:
> >
> > Notebook fan runs all the time after suspend to ram.
> >
>=20
> Workaround:
>=20
> Original DSDT > http://aceracpi.googlecode.com/svn/trunk/dsdt/acer/as=
pire/9810.dsl
>=20
> Normalize behavior of fan on cold boot and wakeup:
> Store (0x46, SMIF)
> Store (0x00, TRP0)
> But in _WAK is:
> If (LAnd (DTSE, MPEN))
> and that is not true.
>=20
> --- a/dsdt.dsl
> +++ b/dsdt.dsl
> @@ -462,11 +462,11 @@
>          Store (0x00, PO80)
>          If (LEqual (Arg0, 0x03))
>          {
> -            If (LAnd (DTSE, MPEN))
> -            {
> +            // If (LAnd (DTSE, MPEN))
> +            // {
>                  Store (0x46, SMIF)
>                  Store (0x00, TRP0)
> -            }
> +            // }
>          }
Could you find out whether some osi set variable is involved.
(The ones that get set when BIOS (in DSDT) calls e.g.
osi("Windows 2006"))
Something like:
if (osi("Windows 2006"))
    Store(1, DTSE)
Maybe you find out what the DTSE or MPEN variable is good for, is set b=
y
some _INI function of a specific device or whatever?

Best you create a bug for that at bugzilla.kernel.org (and add me to CC
or post the bug no).
=46ull (or none) fan is a real blocker bug that should generally be
resolved.

Does this BIOS expose an ACPI fan device correctly? If yes is:
echo 1 >/proc/acpi/fan/*/state
or:
=EF=BB=BFecho 0 >/proc/acpi/fan/*/state
=EF=BB=BFecho 1 >/proc/acpi/fan/*/state
=EF=BB=BFecho 0 >/proc/acpi/fan/*/state
or whatever also a workaround?

Thanks,

   Thomas

>=20
>          If (LOr (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
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
