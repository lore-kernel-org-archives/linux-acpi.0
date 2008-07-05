From: garkein@mailueberfall.de
Subject: Thinkpad T61 consuming more power on AC
Date: Sat, 05 Jul 2008 23:38:03 +0200
Message-ID: <1215293883.5545.19.camel@thinkpad>
Reply-To: garkein@mailueberfall.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:32862 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753032AbYGEVih (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jul 2008 17:38:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

=EF=BB=BFHello,
may I please again ask for your help regarding this issue:
I notice, with 2.6.25, that my T61 runs rather quiet on battery while i=
n
AC mode the fan runs far often, if not all the time.

With recent powertop I could find out the most likely reason:

(Kernel 2.6.25)

AC:
Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6=20
Your BIOS reports the following C-states : C1 C2 C3

Battery:
Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6=20
Your BIOS reports the following C-states : C1 C2 C6

Powertop then shows me it's actually using the processor states as
listed as reported from BIOS.
So obviously it doesn't use the low power state C6 when on AC while it
does on battery.
I already tried all reasonable as well as non reasonable BIOS settings
to see if that changes something, but no, I can only get it worse in
battery mode, but not any better in AC mode.

Is it possible, maybe with some slight tweaks (setpci...), to convice
the kernel (or BIOS?) to also use that C6 state when in AC mode?

I would love to!

Thanks,
Daniel



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
