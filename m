From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] ACPI / button: Avoid using broken _LID on Surface tablet
Date: Mon, 07 Mar 2016 17:19:28 +0100
Message-ID: <1457367568.2648.72.camel@hadess.net>
References: <1454497460-16803-1-git-send-email-yu.c.chen@intel.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB4B97D@SHSMSX101.ccr.corp.intel.com>
	 <36DF59CE26D8EE47B0655C516E9CE640286C4774@shsmsx102.ccr.corp.intel.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB4DA8A@SHSMSX101.ccr.corp.intel.com>
	 <1456150475.23430.16.camel@hadess.net>
	 <1AE640813FDE7649BE1B193DEA596E883BB60425@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:44761 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbcCGQWZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Mar 2016 11:22:25 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB60425@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "cwhuang@android-x86.org" <cwhuang@android-x86.org>

On Fri, 2016-03-04 at 03:37 +0000, Zheng, Lv wrote:
<snip>
>=20
> > I'm not happy about the "fix" for this problem either, but blaming
> > user-space for this is harsh, given the API exported by the kernel
> > and
> > how pretty much every laptop worked.
> >=20
> [Lv Zheng]=C2=A0
> It worked for so many years on top of traditional x86 laptops where
> the LID open event is handled by the BIOS to trigger a wake GPE.
> Now we are talking about runtime idle systems where resuming from the
> s2idle invokes no BIOS code.
> The new case is still working on Windows.
> Which forces us to re-consider the kernel API of the ACPI LID.

The current kernel API works on 99% of machines up until now, user-
space could not have been expected to know that the Lid status might be
incorrect on some machines, it had no way to know that, there was no
documentation saying "don't use the Lid status outside of Lid status
change events".

We either need to extend the current API to export the fact that we
should ignore the LID status outside of events, or we need a new API.

(We could fix this without any kernel changes, but we really need the
kernel to document that fact, and export it to user-space)

This is something you should have said at the start of the mail,
instead of repeatedly saying that user-space was broken. User-space
behaviour hasn't changed there for more than 10 years, and I'm fairly
certain it's worked the same way as APM (on x86) and PMU (on Mac PPC
machines) did.

Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
