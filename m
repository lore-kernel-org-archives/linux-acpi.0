From: "Renato S. Yamane" <yamane@diamondcut.com.br>
Subject: Re: Toshiba - Documentation for Linux Developers
Date: Wed, 18 Jun 2008 09:24:37 -0300
Message-ID: <4858FE85.2030000@diamondcut.com.br>
References: <4855971D.90004@diamondcut.com.br> <200806181311.34849.damnshock@gmail.com> <4858EFF7.5000107@diamondcut.com.br> <200806181338.50723.damnshock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-03.mandic.com.br ([200.225.81.143]:37972 "EHLO
	smtp-03.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbYFRMY7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2008 08:24:59 -0400
In-Reply-To: <200806181338.50723.damnshock@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Marc_Deop_i_Argem=ED?= <damnshock@gmail.com>
Cc: linux-acpi@vger.kernel.org, greg@kroah.com, mjg59@srcf.ucam.org, lenb@kernel.org

Marc Deop i Argem=ED escreveu:
> On Wednesday 18 June 2008 13:22:31 Renato S. Yamane wrote:
>> # cat /proc/acpi/event
>> cat: /proc/acpi/event: Device or resource is busy
>=20
> Sorry: I forgot to mention that you have to turn off the acpi daemon.

If I stop acpid, when I run "cat /proc/acpi/event" nothing happens (whe=
n
I press Fn+Fx couple keys or multimedia keys) and I can't get out of ca=
t
command (if I use VIM, I can't close it too).

Regards,
Renato S. Yamane
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
