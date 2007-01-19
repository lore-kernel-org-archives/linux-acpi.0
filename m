From: "Pieter De Wit" <Pieter.DeWit@vodacom.co.za>
Subject: RE: Fan speeds on HP nc6400 and nc8430
Date: Fri, 19 Jan 2007 13:29:51 +0200
Message-ID: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mfwj032.mfw.is.co.za ([196.35.77.38]:1491 "EHLO
	mfwj032.mfw.is.co.za" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965065AbXASLaC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2007 06:30:02 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Luming,

This module was build into the kernel. After make it a module and makin=
g
sure it's not loaded, I still see the problem. Here is a more detailed
problem:

If I leave ACPI to manage the system, thermal zone TZ4 stays around 80
C. The moment I turn on fan C318, this zone *shoots* up to 100 C and
stays there, no matter what. This fan I can't turn off again.

Here is a cat of fans, thermal_zone status and temp.

status:                  on
status:                  off
status:                  on
status:                  on
status:                  on
status:                  on
status:                  on
state:                   active[2]
state:                   ok
state:                   ok
state:                   ok
state:                   ok
temperature:             65 C
temperature:             61 C
temperature:             54 C
temperature:             30 C
temperature:             100 C

This was taken during the compile of gcc. While not doing anything, the
second zone drops to 54 C (currently at 61)

Thanks for the time,

Pieter

-----Original Message-----
=46rom: Luming Yu [mailto:luming.yu@gmail.com]=20
Sent: 2007/01/19 10:14
To: Pieter De Wit
Cc: linux-acpi@vger.kernel.org
Subject: Re: Fan speeds on HP nc6400 and nc8430

Do you have psmouse module loaded ?
(i.e. CONFIG_MOUSE_PS2=3Dm)
If yes, Please try remove it, and re-test it.

Thanks,
Luming

On 1/19/07, Pieter De Wit <Pieter.DeWit@vodacom.co.za> wrote:
> Hello List,
>
> I have noted that the fan speed on "idle" is much higher in Linux=20
> compared to XP. I have also noted that once fans are turned on, they=20
> never seem to return to the off state. I am currently using the 2.6.1=
8

> kernel from Gentoo (gentoo-sources-r6). I was wondering if there is a=
=20
> way I can lower the fan speed, or even assist the devs to get info=20
> regarding these notebooks (if any is needed).
>
> Thanks,
>
> Pieter
> "This e-mail is sent on the Terms and Conditions that can be accessed
by Clicking on this link http://www.vodacom.co.za/legal/email.jsp "
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>
=93This e-mail is sent on the Terms and Conditions that can be accessed=
 by Clicking on this link http://www.vodacom.co.za/legal/email.jsp "
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
