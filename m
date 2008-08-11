From: "Wickey Pro" <wickey@gmx.at>
Subject: Re: Unsupportet Asus Laptop /proc/acpi/dsdt 2.6.26
Date: Mon, 11 Aug 2008 20:19:52 +0200
Message-ID: <20080811181952.203090@gmx.net>
References: <20080810144723.90840@gmx.net>  <200808101831.50668.rjw@sisk.pl>
 <1218420034.6671.61.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753647AbYHKSTy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 14:19:54 -0400
In-Reply-To: <1218420034.6671.61.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>, rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org

Hi!

I am so sorry, I'm only a "normal" Linux user and not a developer and m=
y english is very ugly :)

I don't know how to use a other ACPI driver, i follow the message to se=
nd the dsdt to the developers. I send a Bugrepot also to Debian, see ht=
tp://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D494573 and cc to acpi-=
bugzilla@lists.sourceforge.net  to support this asus acpi.
I have no problem to use Linux with this Laptop, no error is evident on=
ly the message to send the dsdt to the developers, alone this animated =
me to send this "Bugreport".
Wlan killswitch is only a "problem", i use echo 1 > /proc/acpi/asus/wle=
d and wlan is ok.
I thank you for your efforts, Linux developers make a good job because =
as far as I can judge.

wickey



-------- Original-Nachricht --------
> Datum: Mon, 11 Aug 2008 10:00:34 +0800
> Von: Zhao Yakui <yakui.zhao@intel.com>
> An: "Rafael J. Wysocki" <rjw@sisk.pl>, wickey@gmx.at
> CC: wickey@gmx.at, ACPI Devel Maling List <linux-acpi@vger.kernel.org=
>
> Betreff: Re: Unsupportet Asus Laptop /proc/acpi/dsdt 2.6.26

> On Sun, 2008-08-10 at 18:31 +0200, Rafael J. Wysocki wrote:
> > On Sunday, 10 of August 2008, you wrote:
> > > Hi!
> >=20
> > Hi,
> >=20
> > > dmesg:
> > > [   10.084802] Asus Laptop ACPI Extras version 0.30
> > > [   10.088918]   unsupported model X55SV, trying default values
> > > [   10.088918]   send /proc/acpi/dsdt to the developers
> > >=20
> > > My Laptop is a Asus X55SV-AP166C running with Debian testing with
> Kernel 2.6.26-1-686 from the Debian unstable repository.
> > >=20
> > > OK, there is a=20
> > > cat /proc/acpi/dsdt > dsdt
> > > in the attachment
> > >=20
> > > I hope it helps you to support this.
> > > If you need somthing else, please send a mail to me.
> >=20
> > You should have posted this message to linux-acpi.
> Hi, Wickey
>    There are two platform drivers for Asus laptop. One is in
> driver/acpi/asus-acpi and the other is driver/misc/asus-laptop.=20
>    As your laptop is a new model, you should try to use the asus-lapt=
op
> driver instead of asus-acpi and see whether the problem still exists.
>    Thanks.
> >=20
> > Thanks,
> > Rafael
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
GMX Kostenlose Spiele: Einfach online spielen und Spa=DF haben mit Past=
ry Passion!
http://games.entertainment.gmx.net/de/entertainment/games/free/puzzle/6=
169196
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
