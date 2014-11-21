From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] platform: x86: dell-laptop: Add support for keyboard
 backlight
Date: Fri, 21 Nov 2014 14:09:40 -0800
Message-ID: <20141121220939.GA24951@vmdeb7>
References: <1415967813-7223-1-git-send-email-pali.rohar@gmail.com>
 <201411192141.20190@pali>
 <20141121203930.GA74402@vmdeb7>
 <201411221946.25314@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43419 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaKVTbg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Nov 2014 14:31:36 -0500
Content-Disposition: inline
In-Reply-To: <201411221946.25314@pali>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, libsmbios-devel@lists.us.dell.com, Srinivas_G_Gowda@dell.com, Michael_E_Brown@dell.com, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@intel.com>

On Sat, Nov 22, 2014 at 07:46:25PM +0100, Pali Roh=E1r wrote:

> > > 0   Completed successfully
> > > -1  Completed with error
> > > -2  Function not supported
> > >=20
> > > So we can return something other too (not always -EINVAL).
> > > Do you have any idea which errno should we return for -1
> > > and -2?
> >=20
> > For -1, I should think  -EIO (I/O Error)
> > For -2, I'd expect -ENXIO (No such device or address)
> >=20
>=20
> What about -ENOSYS for -2?

No. This specific topic came up at kernel summit this year. ENOSYS is
specifically for not implemented system calls.

>=20
> > > > > +	if (convert) {
> > > > > +		/* NOTE: this switch fall down */
> > > >=20
> > > > "fall down" ? As in, it intentionally doesn't have breaks?
> > >=20
> > > This code convert "value" in "units" to new value in minutes
> > > units. So for unit =3D=3D days it is: 24*60*60... So no breaks.
> >=20
> > Right, so the language of the comment just wasn't clear, try:
> >=20
> > /* Convert value from seconds to minutes */
> >=20
>=20
> Err... to seconds :-) But OK, I will change comment.

Oops, duh.

/* Convert value from current units to seconds. */

>=20
> > > > > +		switch (unit) {
> > > > > +		case KBD_TIMEOUT_DAYS:
> > > > > +			value *=3D 24;
> > > > > +		case KBD_TIMEOUT_HOURS:
> > > > > +			value *=3D 60;
> > > > > +		case KBD_TIMEOUT_MINUTES:
> > > > > +			value *=3D 60;
> > > > > +			unit =3D KBD_TIMEOUT_SECONDS;
> > > > > +	 	}

--=20
Darren Hart
Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
