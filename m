From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 100% C0 with 2.6.25-rc
Date: Thu, 21 Feb 2008 17:33:53 +0100
Message-ID: <200802211733.54759.rjw@sisk.pl>
References: <47BD600F.9090502@willies.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37323 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759695AbYBUQfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 11:35:17 -0500
In-Reply-To: <47BD600F.9090502@willies.info>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Willies <jan@willies.info>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Venki Pallipadi <venkatesh.pallipadi@intel.com>

On Thursday, 21 of February 2008, Jan Willies wrote:
> Hi,
>=20
> Since 2.6.25-rc1 I have a lot of wakeups/s (=E2=89=88134191,4) and sp=
end 100% in C0.
> It worked fine with 2.6.24 and commandline nolapic. Without nolapic I=
 had 80k
> wakeups/s after some time, but not right from the start like now. =20

We have a regression from 2.6.24, apparently interrupts-related.

> What useful information can I provide?

Let's see what the experts say.

Thanks,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
