From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Thinkpad T61 consuming more power on AC
Date: Tue, 08 Jul 2008 09:31:39 +0800
Message-ID: <1215480699.6121.25.camel@yakui_zhao.sh.intel.com>
References: <1215293883.5545.19.camel@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59671 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753896AbYGHBUw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2008 21:20:52 -0400
In-Reply-To: <1215293883.5545.19.camel@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: garkein@mailueberfall.de
Cc: linux-acpi@vger.kernel.org

On Sat, 2008-07-05 at 23:38 +0200, garkein@mailueberfall.de wrote:
> =EF=BB=BFHello,
> may I please again ask for your help regarding this issue:
> I notice, with 2.6.25, that my T61 runs rather quiet on battery while=
 in
> AC mode the fan runs far often, if not all the time.
>=20
> With recent powertop I could find out the most likely reason:
>=20
> (Kernel 2.6.25)
>=20
> AC:
> Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6=20
> Your BIOS reports the following C-states : C1 C2 C3
>=20
> Battery:
> Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6=20
> Your BIOS reports the following C-states : C1 C2 C6
>=20
> Powertop then shows me it's actually using the processor states as
> listed as reported from BIOS.
> So obviously it doesn't use the low power state C6 when on AC while i=
t
> does on battery.
> I already tried all reasonable as well as non reasonable BIOS setting=
s
> to see if that changes something, but no, I can only get it worse in
> battery mode, but not any better in AC mode.
>=20
> Is it possible, maybe with some slight tweaks (setpci...), to convice
> the kernel (or BIOS?) to also use that C6 state when in AC mode?
Understand what you said. In fact OS won't use the CPU C3/C4/C5/C6
directly. In different cases they will be mapped to ACPI C3 state ,
which means the low power state that is used by OS. For example: On the
T61 laptop: In AC mode, CPU C3 is mapped to ACPI C3; In battery mode:
CPU C6 is mapped to ACPI C3.
    The C-state mapping between CPU C3/C4/C5/C6 and ACPI C3 is defined
in ACPI tables, which is related with the BIOS. In order to use CPU C6
state in AC mode, we must modify the C-state mapping in ACPI tables. It
is not easy. And IMO it is meaningless(CPU C6 can save more power than
CPU C3. But it is not obvious). So not recommend to do so.
   Of course if still hope to do so, please refer to the _CST object
defined in section 8 of ACPI 3.0 spec and custom DSDT should be used.

Thanks.
   Yakui
> I would love to!
>=20
> Thanks,
> Daniel
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
