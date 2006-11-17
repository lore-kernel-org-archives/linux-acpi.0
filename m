From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Fri, 17 Nov 2006 13:04:00 -0800
Message-ID: <200611171304.00889.david-b@pacbell.net>
References: <200611142303.47325.david-b@pacbell.net> <455C8696.80508@linux.intel.com> <200611162222.44836.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1424925AbWKQVcg@vger.kernel.org>
In-Reply-To: <200611162222.44836.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 16 November 2006 10:22 pm, David Brownell wrote:
> On Thursday 16 November 2006 7:41 am, Alexey Starikovskiy wrote:
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -467,8 +467,8 @@ static u32 acpi_ec_gpe_handler(void *dat
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0status =3D acpi_os_=
execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR=
);
> > -=A0=A0=A0=A0=A0=A0=A0return status =3D=3D AE_OK ?
> > -=A0=A0=A0=A0=A0=A0=A0 =A0 =A0ACPI_INTERRUPT_HANDLED : ACPI_INTERRU=
PT_NOT_HANDLED;
> > +=A0=A0=A0=A0=A0=A0=A0WARN_ON(ACPI_FAILURE(status));
> > +=A0=A0=A0=A0=A0=A0=A0return ACPI_INTERRUPT_HANDLED;
> > =A0}
> > =A0
>=20
> Strange ... applying this on top of the previous patch seems to work
> much better, but that WARN_ON hasn't triggered.  At least, not yet.
> Updating to RC6, with your two patches installed...

ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [Embed=
dedControl] [20060707]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [O=
pcodeName unavailable] [2006070
7]
ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._T=
MP] (Node ffff810002032d10), AE
_TIME

OK, I don't get the WARN_ON when these happen, so it's got to be one of=
 the
other EC updates.

It'd be nice if this were easily reproducible ...

- Dave
