From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Flag use of ACPI and ACPI idioms for power supplies to regulator API
Date: Mon, 27 Jan 2014 13:54:48 +0100
Message-ID: <3051988.Sav3BEhI94@vostro.rjw.lan>
References: <1390782734-10131-1-git-send-email-broonie@kernel.org> <2348079.FWLATJ4QDO@vostro.rjw.lan> <20140127004434.GT11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54295 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751431AbaA0Mkd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jan 2014 07:40:33 -0500
In-Reply-To: <20140127004434.GT11727@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linaro-kernel@lists.linaro.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>

On Monday, January 27, 2014 12:44:34 AM Mark Brown wrote:
> 
> --QgvTbcZPsSS/HkXe
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Mon, Jan 27, 2014 at 01:54:49AM +0100, Rafael J. Wysocki wrote:
> > On Monday, January 27, 2014 12:32:14 AM Mark Brown wrote:
> 
> > > @@ -509,6 +510,14 @@ void __init acpi_early_init(void)
> > >  		goto error0;
> > >  	}
> > > =20
> > > +	/*
> > > +	 * If the system is using ACPI then we can be reasonably
> > > +	 * confident that any regulators are managed by the firmware
> > > +	 * so tell the regulator core it has everything it needs to
> > > +	 * know.
> > > +	 */
> > > +	regulator_has_full_constraints();
> > > +
> 
> > That's going to be called earlier than it use to be in 3.13 and before.
> 
> > No problems with that?
> 
> All that function does is to set a flag - so long as we can assign to a
> static variable it should be OK.

OK, do you want me to take it?

Rafael

