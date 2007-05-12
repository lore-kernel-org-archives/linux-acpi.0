From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Sat, 12 May 2007 21:36:18 +0200
Message-ID: <1178998578.4004.1.camel@chaos>
References: <20070430102837.748238000@linutronix.de>
	 <20070511132846.5ebf4437.akpm@linux-foundation.org>
	 <200705112302.47726.rjw@sisk.pl> <200705112309.15996.rjw@sisk.pl>
	 <20070511235607.83ad0eb5.akpm@linux-foundation.org>
	 <1178959563.22481.126.camel@localhost.localdomain>
	 <20070512020056.a24cf472.akpm@linux-foundation.org>
	 <1178961489.22481.133.camel@localhost.localdomain>
	 <20070512030754.90488f79.akpm@linux-foundation.org>
	 <1178970253.22481.143.camel@localhost.localdomain>
	 <20070512095145.0cf58a57.akpm@linux-foundation.org>
	 <1178989302.22481.185.camel@localhost.localdomain>
	 <20070512102350.04126320.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:58275 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755932AbXELTdg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2007 15:33:36 -0400
In-Reply-To: <20070512102350.04126320.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Sat, 2007-05-12 at 10:23 -0700, Andrew Morton wrote:
> On Sat, 12 May 2007 19:01:41 +0200 Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>=20
> > Can you upload a snapshot of your current queue ?
>=20
> Yeah, that's super-easy.  It just happens that it all compiles
> and runs at present ;)

Really ?

/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c: I=
n function =E2=80=98pcxhr_trigger=E2=80=99:
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:64=
0: error: expected expression before =E2=80=98<<=E2=80=99 token
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:64=
2: error: expected expression before =E2=80=98=3D=3D=E2=80=99 token
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:64=
4: warning: ISO C90 forbids mixed declarations and code
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:64=
5: error: expected expression before =E2=80=98>>=E2=80=99 token
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:65=
3: error: =E2=80=98s=E2=80=99 undeclared (first use in this function)
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:65=
3: error: (Each undeclared identifier is reported only once
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:65=
3: error: for each function it appears in.)
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:65=
3: warning: type defaults to =E2=80=98int=E2=80=99 in declaration of =E2=
=80=98type name=E2=80=99
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:65=
3: error: request for member =E2=80=98link_list=E2=80=99 in something n=
ot a structure or union
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:65=
3: warning: type defaults to =E2=80=98int=E2=80=99 in declaration of =E2=
=80=98__mptr=E2=80=99
/home/tglx/work/kernel/hrtimers/linux-2.6.21/sound/pci/pcxhr/pcxhr.c:65=
3: warning: initialization from incompatible pointer type


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
