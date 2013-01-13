From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: fix new C-states not functional after AC disconnect
Date: Sun, 13 Jan 2013 15:41:34 +0100
Message-ID: <50F2C79E.5000302@linaro.org>
References: <2099093.cPXO6Nhn9v@netbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:50818 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab3AMOlh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jan 2013 09:41:37 -0500
Received: by mail-ea0-f179.google.com with SMTP id i12so1319201eaa.38
        for <linux-acpi@vger.kernel.org>; Sun, 13 Jan 2013 06:41:36 -0800 (PST)
In-Reply-To: <2099093.cPXO6Nhn9v@netbook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, =?UTF-8?B?QW5kcmVhcyBNw7xs?= =?UTF-8?B?bGVy?= <goo@stapelspeicher.org>, Julius Werner <jwerner@chromium.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/13/2013 01:34 PM, Thomas Schlichter wrote:
> Hi,
>=20
> there is a long-standing regression about new C-states not working af=
ter=20
> disconnecting AC power from a laptop if the cpuidle driver "acpi-idle=
" is=20
> used. It was reported here:
>=20
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D42870  (March 5th 2=
012)
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D43349  (June 7th 20=
12)
> [3] https://lkml.org/lkml/2012/10/16/518   (October 19th 2012)
>=20
> In [1] Andreas proposed a patch that initialized the missing power_us=
age=20
> values from within acpi_idle in the same way as cpuidle does.
> In [2] I proposed a patch to use the power values provided by ACPI to=
=20
> initialize the power_usage variables.
> In [3] Julius proposed a patch to call the initialization function=20
> set_power_states()  not only once, but always when the C-states chang=
e.
>=20
> Currently, Daniel Lezcano seems to be working on an intrusive change =
of not=20
> using the power_usage value at all for choosing a C-state:
>=20
> [4] https://lkml.org/lkml/2012/12/14/155
>=20
> As I could not find any of these patches in any git trees to be merge=
d for=20
> 3.8, I propose an other, least intrusive patch for the time being. It=
 is=20
> attached an initializes _all_ power_usage values in the first place.
>=20
> As this is a real power consumption regression since 3.2, I really as=
k you to=20
> apply anything and push it to stable, too!

Rafael, is possible to apply the patch [1/2] I previously sent ?

https://patchwork.kernel.org/patch/1878691/

So we get this bug fixed.

I will resend the patch [2/2] as soon as possible.

  -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
