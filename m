From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: Oopses and ACPI problems (Linus 2.6.29-rc4)
Date: Tue, 10 Feb 2009 09:06:00 +0800
Message-ID: <1234227960.3706.67.camel@localhost.localdomain>
References: <gemini.ket9w800w44dc0hvg.linux@youmustbejoking.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18354 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbZBJAyQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Feb 2009 19:54:16 -0500
In-Reply-To: <gemini.ket9w800w44dc0hvg.linux@youmustbejoking.demon.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Salt <linux@youmustbejoking.demon.co.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-02-10 at 02:26 +0800, Darren Salt wrote:
> I'm seeing various oopses with -rc4, where -rc3 is fine; config, dmes=
g
> (captured via netconsole) and decoded oops data attached =C2=B9. The =
last few
> oopses were followed by a scrambled display and a hard lockup.
>=20
> All oopses follow an otherwise successful suspend-to-RAM.
>=20
> Also, I see that Fn-Fx don't seem to be reported via /proc/acpi/event=
s any
> more, or at least I'm seeing no evidence of them via acpi_listen (and=
, not
> coincidentally, I can't adjust the volume etc. via eeepc-acpi-scripts=
).
>=20
> The only other (significant) change is that I've installed X from Deb=
ian
> experimental, though -rc3 and 2.6.28.* seem fine with this. (Oh, and =
I can
> get UXA to cause OOM quite trivially... several Iceweasel tabs is eno=
ugh.)
>=20
>From the description it seems that this is a regression.=20
Will you please use git-bisect to identify which commit causes the
regression?
   Thanks.
>=20
> =C2=B9 Yes, I decided not to include symbol names in the running kern=
el...
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
