From: Ivo van Doorn <ivdoorn@gmail.com>
Subject: Re: [RESEND] [PATCH -next 2/2] acpi,rfkill,backlight: comapl-laptop update - use rfkill switch subsystem
Date: Wed, 9 Jul 2008 23:57:27 +0200
Message-ID: <200807092357.28013.IvDoorn@gmail.com>
References: <20080709231059.778d16f4@debian> <200807092333.01355.IvDoorn@gmail.com> <20080709234419.12d6eabc@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:47232 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbYGIVsk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jul 2008 17:48:40 -0400
Received: by nf-out-0910.google.com with SMTP id d3so966802nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jul 2008 14:48:39 -0700 (PDT)
In-Reply-To: <20080709234419.12d6eabc@debian>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

On Wednesday 09 July 2008, Cezary Jackiewicz wrote:
> Dnia 2008-07-09, o godz. 23:33:01
> Ivo van Doorn <ivdoorn@gmail.com> napisa=B3(a):
>=20
> > On Wednesday 09 July 2008, Cezary Jackiewicz wrote:
> > > From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
> > >=20
> > > Remove unnecessary attributes, use rfkill switch subsystem.
> >=20
> > I'm missing a call to rfkill_force_state() to inform the rfkill sub=
system that
> > the key has been toggled. This function should be called when the h=
ardware
> > has raised the interrupt about the pressed event, or when the funct=
ion
> > which polls the register notices the state change.
> >=20
> > As the patch works now, it means that the driver will only listen t=
o
> > events coming from rfkill and it doen't provide any updates itself.
> >=20
> > Ivo
>=20
> Does calling rfkill_force_state () is mandatory? This driver implemen=
t=20
> get_state() hook, @state is always up-to-date.

It is not mandatory if you are writing rfkill support for a driver that=
 does not
come with a rfkill switch. Such drivers can make use of the rfkill even=
ts produced
by the hardware which does have such a switch.

When the hardware does have the rfkill switch, then yes rfkill_force_st=
ate() is mandatory.
The get_state() callback function is optional, and allows rfkill to dif=
ferentiate
between soft and hardblock.

Ivo
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
