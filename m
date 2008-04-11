From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Thu, 10 Apr 2008 20:46:47 -0700
Message-ID: <200804102046.48082.david-b@pacbell.net>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com> <200804090313.34805.david-b@pacbell.net> <1207911866.9448.34.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:38468 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756704AbYDKDqu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2008 23:46:50 -0400
In-Reply-To: <1207911866.9448.34.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Friday 11 April 2008, Zhao Yakui wrote:
> But The following is reasonable. IMO.
> =A0For October: 0x0A will be written into the RTC region
> (MONTH_ALARM). But in fact 0x10 should be written.
> =A0 =A0 =A0 =A0/* Writing 0xff means "don't care" or "match all". =A0=
*/
> =A0
> - =A0 =A0 =A0 mon =3D t->time.tm_mon;
> - =A0 =A0 =A0 mon =3D (mon < 12) ? BIN2BCD(mon) : 0xff;
> - =A0 =A0 =A0 mon++;
> + =A0 =A0 =A0 mon =3D t->time.tm_mon + 1;
> + =A0 =A0 =A0 mon =3D (mon <=3D 12) ? BIN2BCD(mon) : 0xff;
>=20
> Is there an opportunity to merge it?

Sure.  Submit that as a patch by itself.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
