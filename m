From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Fri, 20 Mar 2009 08:33:24 +0100
Message-ID: <200903200833.25274.matze@welwarsky.de>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320004043.GF19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:17786
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbZCTH62 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Mar 2009 03:58:28 -0400
In-Reply-To: <20090320011837.GA23183@gamma.logic.tuwien.ac.at>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, sony-vaio-z-series@lists.launchpad.net, malattia@linux.it, linux-acpi@vger.kernel.org

On Friday 20 March 2009 02:18:37 Norbert Preining wrote:
> Hi all,
>
> On Fr, 20 M=C3=A4r 2009, Norbert Preining wrote:
> > > As far as we can tell, the handling of the handover is consistent
> > > across all dual-GPU nvidia laptops[1]. The right place for suppor=
t to
> > > end up is in the kernel component of the nouveau drivers.
> >
> > Whatever the nouveau drivers are? You mean those based on the kerne=
l
> > mode swching? Unfortunately that is far from prime time, and we nee=
d
> > power saving now.
> >
> > I will take a look over the weekend maybe I can add a patch ontop o=
f
> > yours that only does that, taken from the code in the special vaio-=
Z
> > sony-laptop module.
> >
> > Now it would be nice to merge over *only* the stuff concerning
> > speed/stamina into the in-kernel driver added with the patch for rf=
kill
> > support.
>
> Ok, here is the code.
>
> For those interested I Cc the  sony-vaio-z-series@lists.launchpad.net
> group where I first found that modules.
>
> You need:
> 	kernel 2.6.29-rc8	(maybe it works with all from .28 on)
> 	the patch Matthew sent
> 	the attached patch
>
> Together you get full rfkill support for bluetooth/wwan/wifi, plus af=
ais
> stamina-speed mode setting.
>
> Maybe Matthias the creator of the sony-laptop for vaio-zseries module=
s
> can take a look at the patch and see if I missed something.

Too much of honour ;) I only took the in-kernel module as a base for my=
=20
experiments. But I'll have a look this weekend.

> Matthias: sony_led_off and sony_dgpu_sta is never used, is that
> intentional? And also the #define SONY_WMMX_GUID I couldn't find bein=
g
> used anywhere.

sony_led_off is an experiment vehicle only, and sony_dgpu_sta can be us=
ed to=20
query the power state of the nvidia adapter. It's in there for demonstr=
ation=20
purposes.

> Maybe Matthew can take a look and fix the compile warnings in functio=
n
> =E2=80=98sony_ovga_dsm=E2=80=99 (there are some!).

I'm aware of that. Most are in debug code, though, which can be removed=
 safely=20
without changing the functionality.

> My intention is that we do not digress too far from the kernel code o=
f
> sony-laptop making eventual merging possible.
>
> Best wishes
>
> Norbert
>
> ---------------------------------------------------------------------=
------
>---- Dr. Norbert Preining <preining@logic.at>        Vienna University=
 of
> Technology Debian Developer <preining@debian.org>                    =
   =20
> Debian TeX Group gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD7=
6=20
> A9C0 D2BF 4AA3 09C5 B094
> ---------------------------------------------------------------------=
------
>---- OSBASTON (n.)
> A point made for the seventh time to somebody who insists that they
> know exactly what you mean but clearly hasn't got the faintest idea.
> 			--- Douglas Adams, The Meaning of Liff

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
