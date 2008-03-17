From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: acer-wmi: can we bind wireless button when loading module?
Date: Mon, 17 Mar 2008 18:56:43 +0000
Message-ID: <200803171856.44274.carlos@strangeworlds.co.uk>
References: <b170af450802251329m20fb2e8eu5ffdc5aea889f0b5@mail.gmail.com> <b170af450803050954o2f57df64t3449f7485edc94e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:33115 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbYCQS4r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Mar 2008 14:56:47 -0400
In-Reply-To: <b170af450803050954o2f57df64t3449f7485edc94e9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?Rafa=C5=82?= =?utf-8?q?_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 05 March 2008 17:54:46 Rafa=C5=82 Mi=C5=82ecki wrote:
> Bump for my question. Anyone, please?

Generally, if you CC me on acer-wmi questions, I'll answer such e-mails=
 much=20
more quickly; I do miss some e-mails on the ACPI list as I am rather bu=
sy=20
these days.

> 2008/2/25, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>:
>>  I have small question about handling wireless on/off button in Acer
>>  notebooks. Is it possible to detect this button's events and changi=
ng
>>  wireless status then?

In theory, yes - supposedly rfkill & rfkill-input can do this.

In practice - I've been unable to get rfkill-input to work properly on =
my=20
laptop (rfkill-input doesn't get registered properly, if I play around =
with=20
it as a module, the button pressing works for a few times, then ends up=
 in a=20
nasty on/ off switching loop, unless I start unloading modules).

Whilst I have asked for help on this some time ago in the input mailing=
 list,=20
I've heard nothing back yet on that issue.

Until I can resolve that, I'm not pushing any rfkill support into acer-=
wmi.

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
