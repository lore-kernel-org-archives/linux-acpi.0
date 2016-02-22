From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] ACPI / button: Avoid using broken _LID on Surface tablet
Date: Mon, 22 Feb 2016 15:14:35 +0100
Message-ID: <1456150475.23430.16.camel@hadess.net>
References: <1454497460-16803-1-git-send-email-yu.c.chen@intel.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB4B97D@SHSMSX101.ccr.corp.intel.com>
	 <36DF59CE26D8EE47B0655C516E9CE640286C4774@shsmsx102.ccr.corp.intel.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB4DA8A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:44193 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbcBVOOm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2016 09:14:42 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB4DA8A@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "cwhuang@android-x86.org" <cwhuang@android-x86.org>

On Mon, 2016-02-22 at 07:24 +0000, Zheng, Lv wrote:
> [Lv Zheng]=C2=A0
> According to the knowledge of various BIOS _LID implementation, Linux
> button driver doesn't seem to be working wrong.
> It in fact works correctly and is able to handle all BIOS _LID
> implementations.
>=20
> So this looks to me like a user space bug.

I don't think it is one, given the kernel API for that functionality.
If, instead of exposing the lid as an input switch, the kernel only
ever sent an event saying "the lid is now closed" then we wouldn't have
that problem, as we'd likely expect the lid to be opened when starting
the machine (if present).

> That the user space doesn't contain a proper mode to handle ACPI BIOS
> _LID implementations.
>=20
> Why should kernel work this gap around?
> The gap is:
> The user space requires lid device to act in the way it wants.

In the way that it's always worked up until now, rather.

> While the ACPI BIOS only provides lid behavior that is working for
> Windows power-saving settings.
> IMO,
> 1. Windows Only requires LID close notifications to trigger power-
> save action and only evaluates _LID after receiving a LID
> notification,
> =C2=A0=C2=A0=C2=A0 BIOSen only ensure _LID returning value is correct=
 after a
> notification.

In which case, expecting the lid to always be opened on startup would
probably be a fair assumption, no?

> 2. But Linux user space requires all LID notifications to be
> instantly/correctly reported and wants to know the exact LID states
> whenever it reads the states from the sysfs.
> It doesn't seem to be possible for the kernel to work between BIOSen
> and the user space to fill such a gap.

If you quirk the kernel lid handling to always be opened on startup,
and we waited until the first event to correct it if necessary, seems
like the easiest way to go.

But that brings me the question of how Windows (and then Linux) behave
when you've booted your laptop and closed the lid straight away, before
any driver in the OS had the chance to be around to see the
notification?

It also brings the question of how Windows will know that the lid is
still closed when coming out of suspend by pressing the power button,
which can happen depending on the hardware design (it's certainly
possible to press the power button with the lid closed on the Surface
3, and likely other Surfaces).

I'm not happy about the "fix" for this problem either, but blaming
user-space for this is harsh, given the API exported by the kernel and
how pretty much every laptop worked.

Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
