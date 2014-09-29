From: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH 1/1 linux-next] ACPI / SBS: fix sparse warning
Date: Mon, 29 Sep 2014 18:30:13 +0200 (CEST)
Message-ID: <1643816105.31300.1412008213769.open-xchange@webmail.nmp.skynet.be>
References: <1411929887-2440-1-git-send-email-fabf@skynet.be> <20140929054004.GA4144@sudip-PC>
Reply-To: Fabian Frederick <fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140929054004.GA4144@sudip-PC>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



> On 29 September 2014 at 07:40 Sudip Mukherjee <sudipm.mukherjee@gmail=
=2Ecom>
> wrote:
>
>
> On Sun, Sep 28, 2014 at 08:44:47PM +0200, Fabian Frederick wrote:
> > Adding parentheses around expression to avoid:
> > drivers/acpi/sbs.c:444:28: warning: dubious: !x & y
> >
> > Signed-off-by: Fabian Frederick <fabf@skynet.be>
> > ---
> >=C2=A0 drivers/acpi/sbs.c | 2 +-
> >=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> > index 32aecea..a7a3edd 100644
> > --- a/drivers/acpi/sbs.c
> > +++ b/drivers/acpi/sbs.c
> > @@ -441,7 +441,7 @@ static int acpi_ac_get_present(struct acpi_sbs =
*sbs)
> >=C2=A0 =C2=A0 =C2=A0 * The spec requires that bit 4 always be 1. If =
it's not set, assume
> >=C2=A0 =C2=A0 =C2=A0 * that the implementation doesn't support an SB=
S charger
> >=C2=A0 =C2=A0 =C2=A0 */
> > -=C2=A0 =C2=A0if (!(status >> 4) & 0x1)
> > +=C2=A0 =C2=A0if (!((status >> 4) & 0x1))
>
> i think the logic changed over here.
> it was !x & y , but now it has become !(x & y)
> ! is having higher priority than & so !x & y will mean ((!x) & y)
>
> thanks
> sudip
Hello Sudip,

You're right, logic has changed but IMHO expression was wrong.

Let's take value 100, decimal.
Binary: 0110>0<100

Spec states that bit 4 must be 1 so value is wrong.

We don't go in
if (!(status>>4) & 0x1)

but

if (!((status>>4) & 0x1))
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;

is triggered.

Regards,
=46abian
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;
> >=C2=A0
> >=C2=A0 =C2=A0 =C2=A0sbs->charger_present =3D (status >> 15) & 0x1;
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.=
html
> > Please read the FAQ at=C2=A0 http://www.tux.org/lkml/
