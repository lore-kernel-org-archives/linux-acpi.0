From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Thu, 13 Mar 2008 08:33:24 +0100
Message-ID: <20080313073324.GB27873@ics.muni.cz>
References: <20080225230035.GA14503@khazad-dum.debian.net> <20080312193637.GA27873@ics.muni.cz> <20080312211306.GD30864@khazad-dum.debian.net> <200803130830.47709.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:39029 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830AbYCMHds (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2008 03:33:48 -0400
Content-Disposition: inline
In-Reply-To: <200803130830.47709.arekm@maven.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jens Axboe <jens.axboe@oracle.com>, Alexey Starikovskiy <aystarik@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, Mar 13, 2008 at 08:30:47AM +0100, Arkadiusz Miskiewicz wrote:
> Mar 13 08:27:48 tarm acpid: received event "ibm/hotkey HKEY 00000080 =
00001018"
> Mar 13 08:27:48 tarm acpid: notifying client 4071[126:126]
> Mar 13 08:27:48 tarm acpid: notifying client 4096[0:0]
> Mar 13 08:27:48 tarm acpid: notifying client 4230[0:0]
> Mar 13 08:27:48 tarm acpid: completed event "ibm/hotkey HKEY 00000080=
=20
> 00001018"
> (this log was done while X was running + some kde apps).

I got this event under 2.6.25-rc3-git1.

However, I wonder why some keys are reported as key press through input=
 device
and some only for acpid. I thing, all the key should be reported in the=
 same
way...

--=20
Luk=E1=B9 Hejtm=E1nek
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
