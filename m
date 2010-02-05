From: Jeff Garrett <jeff@jgarrett.org>
Subject: Re: acpi_idle: Very idle Core i7 machine never enters C3
Date: Fri, 5 Feb 2010 10:22:23 -0600
Message-ID: <20100205162223.GB2736@jgarrett.org>
References: <20100126084740.GA5265@jgarrett.org> <1264509660.29891.7.camel@huang-laptop> <20100126145951.GA4987@jgarrett.org> <1264598837.32649.9.camel@huang-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from jgarrett.org ([64.5.53.252]:45920 "EHLO jgarrett.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933361Ab0BEQWZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Feb 2010 11:22:25 -0500
Content-Disposition: inline
In-Reply-To: <1264598837.32649.9.camel@huang-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: peng huang <huangpeng.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Wed, Jan 27, 2010 at 10:27:17PM +0900, peng huang wrote:
> 2010-01-26 (=E7=81=AB) =E3=81=AE 08:59 -0600 =E3=81=AB Jeff Garrett =E3=
=81=95=E3=82=93=E3=81=AF=E6=9B=B8=E3=81=8D=E3=81=BE=E3=81=97=E3=81=9F:
> > On Tue, Jan 26, 2010 at 09:41:00PM +0900, peng huang wrote:
> > > Hi,
> > > can you show me the file /proc/acpi/processor/CPU*/power.
> > > and are you sure your cpu usage is 0 or nearly zero.
> >=20
> > Yea, I'm pretty sure my cpu usage is nearly zero.  powertop shows f=
ewer
> > than 20 wakeups per second, shows 99% C2 residency, top shows 100% =
idle,
> > perf top shows acpi_idle_enter_simple as the most common function
> > (~50%).  Very little is running on the box, and I've compiled out t=
he
> > heavier parts of the kernel (such as USB)...
> >=20
> > (It still has ordinary userspace running, e.g. udev & hal, and stil=
l has
> > sshd and network traffic, as examples.)
> >=20
> > This is all consistent with a very idle machine, I think.
>=20
> yes,you processor is always in c2,it does means your system is nearly
> ilde.
>=20
> > > this is the info of my laptop(using core 2 processors):
> > > powertop's output:
> > > Cn                Avg residency       P-states (frequencies)
> > > C0 (cpu running)        (10.6%)         2.00 Ghz     1.9%
> > > C0                0.0ms ( 0.0%)         1.67 Ghz     0.1%
> > > C1 mwait          0.0ms ( 0.0%)         1333 Mhz     0.0%
> > > C2 mwait          0.0ms ( 0.0%)         1000 Mhz    98.0%
> > > C3 mwait          1.1ms (89.4%)
> >=20
> > Yea, my laptop also (also core 2) has 700-1000 wakeups/sec and spen=
ds
> > greater than 80% of its time in C3...  That's partly why I'm curiou=
s
> > about what my core i7 desktop is doing.
>=20
> So I think it is a core i7 thing.I have heard that some intel cpu hav=
e a
> problem when in c2-state,maybe that is why you cpu cant enter c3-stat=
e.
> I think there is some configuration about deep c-state in the bios,ma=
y
> be you can try it(it cannot solve this problem...).

My BIOS has very few options.  Almost nothing with regard to
power management.  They do let me choose whether to enable
Intel SpeedStep.  They also let me choose which state to use
for ACPI suspend (set to S3) but that appears to be it.

> And in some bios there is a enhanced idle state configuration ,but i
> dont known if it is the reason why the cpu cannot enter c3-state.You =
can
> try it anyway.

I would if I could.  :)

> With disable the deep c-state you BIOS will not give c3-info to the
> OS,then you would see there is no c3-state in the OS.

I also found a thread (I think LKML) which said the max c-state is
limited when HT is disabled.  I had HT disabled in the BIOS.

Re-enabling HT in the BIOS (with CONFIG_X86_HT=3Dy) doesn't
appear to make any difference.

Thanks,
Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
