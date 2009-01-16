From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Fan running continuously after kernel switch
Date: Fri, 16 Jan 2009 23:04:31 +0100
Message-ID: <1232143471.15602.24.camel@pancake>
References: <1232008941.24218.6.camel@pancake>
	 <1232011776.3989.25.camel@yakui_zhao.sh.intel.com>
	 <1232011930.24218.13.camel@pancake>
	 <1232088736.4001.6.camel@yakui_zhao.sh.intel.com>
	 <20090116212326.GE5719@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:59424
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761567AbZAPWEe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 17:04:34 -0500
In-Reply-To: <20090116212326.GE5719@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhao Yakui <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> The thinkpad-acpi driver exports an interface that can be used to con=
trol
> the fan, but you do it on your own risk, and you have to EXPLICLTY op=
t-in by
> giving it the fan_control=3D1 parameter.
Yes, I read about that option, but I'd rather like to avoid it..

> What can help is for you to tell us the temperatures that thinkpad-ac=
pi
> report.  If any of them is above 43C, the fan will be left on continu=
ously
> by the EC.
Here's the temperatures:

cat /proc/acpi/ibm/thermal=20
temperatures:	43 37 35 45 50 -128 29 -128 37 46 43 -128 -128 -128 -128
-128

However, there's obviously a bit more to this.

a) when I load the coretemp module and try to read the temperature via
lm-sensors, I get two values around 60 =C2=B0C, while thinkpad-acpi sho=
ws the
above. Same applies to the standard ACPI thermal interface. I have a
total of 13 different thermal measurements.. :-)

b) the really weird part: when I remove the power supply and let the
laptop run on battery, the fan immediately stops! Some minutes later, i=
t
starts again, but I'm pretty sure that the temperatures are not the onl=
y
factor here. When I plug the power cord back in after some minutes, the
fan stops again..

Yours, Florian
--=20
0666 - Filemode of the Beast

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
