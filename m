From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: Battery information in sysfs for userspace tools
Date: Mon, 18 May 2009 12:57:54 +0200
Message-ID: <1242644274.8339.18.camel@miria>
References: <1242374864.3992.15.camel@miria>  <4A0F2AEC.9060802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:60574 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934AbZERLDl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 May 2009 07:03:41 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id A11FA4B0129
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2009 13:03:36 +0200 (CEST)
Received: from molly.corsac.net (molly.corsac.net [81.57.48.219])
	by smtp2-g21.free.fr (Postfix) with ESMTP id B98D84B01A5
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2009 13:03:33 +0200 (CEST)
In-Reply-To: <4A0F2AEC.9060802@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, Evgeni Golov <evgeni@debian.org>

On dim, 2009-05-17 at 01:06 +0400, Alexey Starikovskiy wrote:
> Currently, sysfs interface repeats brokenness of /proc/acpi/battery=20
> interface.

Hmmh, ok, but it seems to have change recently (since powertop and
acpitools are definitely wrong when it comes to that)

[=E2=80=A6]
> The proper way to handle it is to check for 'energy_now' and if it is=
=20
> present, look for 'power_now'. It should be
> present in 2.6.30 and later kernels (remaining time=20
> energy_now/power_now). If it is not present (as in 2.6.29), then you=20
> should assume that 'current_now' has value in uW, and remaining time
> is energy_now/current_now.
> If you have 'charge_now', remaining time is charge_now/current_now=20
> without any complications.

Wow. Thanks for the info, that's definitely not really easily
guessable :) It'd be nice to have that documented somewhere until thing=
s
settle down a bit and the situation becomes unbroken.

Cheers,
--=20
Yves-Alexis

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
