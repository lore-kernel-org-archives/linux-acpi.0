From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Subject: Re: [RESEND] [PATCH -next 2/2] acpi,rfkill,backlight: comapl-laptop
 update - use rfkill switch subsystem
Date: Wed, 9 Jul 2008 23:44:19 +0200
Message-ID: <20080709234419.12d6eabc@debian>
References: <20080709231059.778d16f4@debian>
	<200807092333.01355.IvDoorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14989 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbYGIVoZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jul 2008 17:44:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1251743fgg.17
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jul 2008 14:44:23 -0700 (PDT)
In-Reply-To: <200807092333.01355.IvDoorn@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Dnia 2008-07-09, o godz. 23:33:01
Ivo van Doorn <ivdoorn@gmail.com> napisa=B3(a):

> On Wednesday 09 July 2008, Cezary Jackiewicz wrote:
> > From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
> >=20
> > Remove unnecessary attributes, use rfkill switch subsystem.
>=20
> I'm missing a call to rfkill_force_state() to inform the rfkill subsy=
stem that
> the key has been toggled. This function should be called when the har=
dware
> has raised the interrupt about the pressed event, or when the functio=
n
> which polls the register notices the state change.
>=20
> As the patch works now, it means that the driver will only listen to
> events coming from rfkill and it doen't provide any updates itself.
>=20
> Ivo

Does calling rfkill_force_state () is mandatory? This driver implement=20
get_state() hook, @state is always up-to-date.

--=20
 Cezary


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
