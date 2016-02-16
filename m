From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 1/2] ACPI: introduce a function to find the first physical device
Date: Tue, 16 Feb 2016 02:21:59 +0100
Message-ID: <2019010.CjT5f3j553@vostro.rjw.lan>
References: <1453300171-25473-1-git-send-email-aleksey.makarov@linaro.org> <1453300171-25473-2-git-send-email-aleksey.makarov@linaro.org> <CAHp75VcdtU6izThE+Z2ODnYoXk-uhweXzUtFwSze_jJHw3+38g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46486 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751761AbcBPBUj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2016 20:20:39 -0500
In-Reply-To: <CAHp75VcdtU6izThE+Z2ODnYoXk-uhweXzUtFwSze_jJHw3+38g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shannon Zhao <shannon.zhao@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>

On Wednesday, January 20, 2016 05:12:18 PM Andy Shevchenko wrote:
> On Wed, Jan 20, 2016 at 4:29 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
> > Factor out the code that finds the first physical device
> > of a given ACPI device.  It is used in several places.
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>=20
> Hmm=E2=80=A6 Sorry, didn't notice one style issue and there is one is=
 matter
> of taste below.
>=20
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -43,7 +43,6 @@ static const struct acpi_device_id forbidden_id_l=
ist[] =3D {
>=20
> > +       pdevinfo.parent =3D adev->parent ?
> > +               acpi_get_first_physical_node(adev->parent) : NULL;
>=20
> Matter of taste, but I believe if-else looks better here even when
> consumes +2 LOC.

I disagree.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
