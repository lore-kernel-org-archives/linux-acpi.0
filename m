From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [PATCH 1/2] merge 32 and 64 realmode wakeup code
Date: Sun, 3 Jul 2011 22:52:12 +0200
Message-ID: <20110703225212.77311f51@mat-laptop>
References: <1309628621-23107-1-git-send-email-castet.matthieu@free.fr>
	<4E0F9C3F.8020907@zytor.com>
	<201107030850.32457.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:52759 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037Ab1GCUwX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jul 2011 16:52:23 -0400
In-Reply-To: <201107030850.32457.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, x86@kernel.org

Hi,

Le Sun, 3 Jul 2011 08:50:32 +0200,
"Rafael J. Wysocki" <rjw@sisk.pl> a =E9crit :

> On Sunday, July 03, 2011, H. Peter Anvin wrote:
> > On 07/02/2011 10:43 AM, Matthieu CASTET wrote:
> > > - this mean less ifdef in code
> > > - we could remove now unused field in wakeup_header (pmode_*)
> > >=20
> > > Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> > > ---
> > >  arch/x86/kernel/acpi/realmode/wakeup.S |   26
> > > -------------------------- arch/x86/kernel/acpi/sleep.c
> > > |   27 ++++++++++-----------------
> > > arch/x86/kernel/trampoline_32.S        |    4 ---- 3 files
> > > changed, 10 insertions(+), 47 deletions(-)
> > >=20
> >=20
> > Looks great to me.  Rafael?
>=20
> I don't have any immediate complaints.  Please feel free to add my AC=
K
> to the patches.
>=20
Thanks,

Should I repost the patches with our ack somewhere ?


Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
