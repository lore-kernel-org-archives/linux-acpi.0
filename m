From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: acer-wmi: can we bind wireless button when loading module?
Date: Mon, 17 Mar 2008 21:14:30 +0000
Message-ID: <200803172114.30764.carlos@strangeworlds.co.uk>
References: <b170af450802251329m20fb2e8eu5ffdc5aea889f0b5@mail.gmail.com> <200803171856.44274.carlos@strangeworlds.co.uk> <b170af450803171403u647cfa60i2cd1166a993e0b98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:52063 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbYCQVOe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Mar 2008 17:14:34 -0400
In-Reply-To: <b170af450803171403u647cfa60i2cd1166a993e0b98@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?Rafa=C5=82?= =?utf-8?q?_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Monday 17 March 2008 21:03:22 Rafa=C5=82 Mi=C5=82ecki wrote:
> Did you notice something like this in your Acer 502x notebook?=20

Not really - the problem here was mostly with rfkill-input.

http://www.mail-archive.com/linux-input%40vger.kernel.org/msg00117.html
http://www.mail-archive.com/linux-input%40vger.kernel.org/msg00175.html

Problem 1 - rfkill-input required unloading & reloading to actually wor=
k in=20
the first place

Problem 2 - rfkill-input had bad interactions with other rfkill aware d=
rivers

Problem 3 - Both device states (wireless and bluetooth) end up being to=
ggled=20
by either button after a while

> Could I=20
> report this somewhere and give any interesting information to let som=
e
> developer fix it?

As you can see from the links above, I already reported it some time ag=
o to=20
the relevant place and people with little response.

-Carlos
--=20
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
