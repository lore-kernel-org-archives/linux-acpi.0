From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Linux doesn't shutdown (turn off) the computer
Date: Tue, 27 Apr 2010 17:50:05 -0600
Message-ID: <4BD7782D.4080608@gmail.com>
References: <phlm97-dol.ln1@tux.abusar.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33093 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0D0XuI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Apr 2010 19:50:08 -0400
Received: by pvb32 with SMTP id 32so124375pvb.19
        for <linux-acpi@vger.kernel.org>; Tue, 27 Apr 2010 16:50:07 -0700 (PDT)
In-Reply-To: <phlm97-dol.ln1@tux.abusar.org.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 04/16/2010 12:06 PM, D=E2niel Fraga wrote:
> 	I've been using Linux since 1997 and started with Slackware
> 3.1 with an AT case.
>
> 	Then some time after, I upgraded the system to a ATX case and
> ATX power supply of course. Unfortunately Linux never turn the comput=
er
> off after shutdown. It *always* stay at the "System halted" screen an=
d
> I have to press for 4 seconds the power button for the computer to
> turn off.
>
> 	With Windows everything works perfectly...
>
> 	I tested this Linux system with 3 different motherboards and
> the problem remains.
>
> 	So, is it a ACPI issue, configuration? What logs or information
> do you need to properly debug this?
>
> 	Now I'm using Linux 2.6.33.
>
> 	Thanks.
>
> 	Ps: my question is: what happens after the "System halted"
> message? The kernel sends a signal to the motherboard, BIOS, whatever
> to shutdown the computer? Maybe something is blocking it? Thanks.

dmesg output from bootup would be useful. Is it actually using ACPI, or=
=20
is it an APM system? I think you should see an "acpi_power_off called"=20
message if the kernel is actually trying to use ACPI to power off the=20
machine.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
