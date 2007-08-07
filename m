From: Michael Sedkowski <sedmich@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 11:18:39 +0200
Message-ID: <1186478319.3705.3.camel@nx6310>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com>
	 <1186411815.4355.7.camel@nx6310>
	 <20070806150159.GC31615@khazad-dum.debian.net>
	 <200708061732.03425.rjw@sisk.pl>  <46B75459.9020204@gmail.com>
	 <1186424492.4355.1.camel@nx6310>  <46B76BBC.9010107@gmail.com>
	 <1186438698.4402.6.camel@nx6310>  <46B817AB.30105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:37941 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757770AbXHGJSo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Aug 2007 05:18:44 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2393198mue
        for <linux-acpi@vger.kernel.org>; Tue, 07 Aug 2007 02:18:43 -0700 (PDT)
In-Reply-To: <46B817AB.30105@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

Dnia 07-08-2007, Wt o godzinie 15:56 +0900, Tejun Heo napisa=C5=82(a):
> 192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age
> Always       -       388
>=20
> I think this is the one.  You can test it by forcefully powering off
> the
> machine (press power button for several secs or disconnect AC and
> battery) and see whether the count increases.
>=20
When I forcefully power off using the power button the raw value [last
one] rise by 1 point from 389 to 390. When I power off normally with
linux it remains constant.
Now could some one please explain to me what does that mean and am I in
danger of data loss?

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
