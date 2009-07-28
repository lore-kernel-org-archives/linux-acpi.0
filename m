From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: Dynamic configure max_cstate
Date: Tue, 28 Jul 2009 10:42:15 +0800
Message-ID: <1248748935.2560.669.camel@ymzhang>
References: <20090727073338.GA12669@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:22484 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751795AbZG1CmH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2009 22:42:07 -0400
In-Reply-To: <20090727073338.GA12669@rhlx01.hs-esslingen.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Mon, 2009-07-27 at 09:33 +0200, Andreas Mohr wrote:
> Hi,
>=20
> > When running a fio workload, I found sometimes cpu C state has
> > big impact on the result. Mostly, fio is a disk I/O workload
> > which doesn't spend much time with cpu, so cpu switch to C2/C3
> > freqently and the latency is big.
>=20
> Rather than inventing ways to limit ACPI Cx state usefulness, we shou=
ld
> perhaps be thinking of what's wrong here.
Andreas,

Thanks for your kind comments.

>=20
> And your complaint might just fit into a thought I had recently:
> are we actually taking ACPI Cx exit latency into account, for timers?=
??
I tried both tickless kernel and non-tickless kernels. The result is si=
miliar.

Originally, I also thought it's related to timer. As you know, I/O bloc=
k layer
has many timers. Such timers don't expire normally. For example, an I/O=
 request
is submitted to driver and driver delievers it to disk and hardware tri=
ggers
an interrupt after finishing I/O. Mostly, the I/O submit and interrupt,=
 not
the timer, drive the I/O.

>=20
> If we program a timer to fire at some point, then it is quite imagina=
ble
> that any ACPI Cx exit latency due to the CPU being idle at that momen=
t
> could add to actual timer trigger time significantly.
>=20
> To combat this, one would need to tweak the timer expiration time
> to include the exit latency. But of course once the CPU is running
> again, one would need to re-add the latency amount (read: reprogram t=
he
> timer hardware, ugh...) to prevent the timer from firing too early.
>=20
> Given that one would need to reprogram timer hardware quite often,
> I don't know whether taking Cx exit latency into account is feasible.
> OTOH analysis of the single next timer value and actual hardware repr=
ogramming
> would have to be done only once (in ACPI sleep and wake paths each),
> thus it might just turn out to be very beneficial after all
> (minus prolonging ACPI Cx path activity and thus aggravating CPU powe=
r
> savings, of course).
>=20
> Arjan mentioned examples of maybe 10us for C2 and 185us for C3/C4 in =
an
> article.
>=20
> OTOH even 185us is only 0.185ms, which, when compared to disk seek
> latency (around 7ms still, except for SSD), doesn't seem to be all th=
at much.
> Or what kind of ballpark figure do you have for percentage of I/O
> deterioration?
I have lots of FIO sub test cases which test I/O on single disk and JBO=
D (a disk
bos which mostly has 12~13 disks) on nahelam machines. Your analysis on=
 disk seek
is reasonable. I found sequential buffered read has the worst regressio=
n while rand
read is far better. For example, I start 12 processes per disk and ever=
y disk has 24
1-G files. There are 12 disks. The sequential read fio result is about =
593MB/second
with idle=3Dpoll, and about 375MB/s without idle=3Dpoll. Read block siz=
e is 4KB.

Another exmaple is single fio direct seqential read (block size is 4K) =
on a single
SATA disk. The result is about 28MB/s without idle=3Dpoll and about 32.=
5MB with
idle=3Dpoll.

How did I find C state has impact on disk I/O result? Frankly, I found =
a regression
between kernel 2.6.27 and 2.6.28. Bisect located a nonstop tsc patch, b=
ut the patch
is quite good. I found the patch changes the default clocksource from h=
pet to
tsc. Then, I tried all clocksources and got the best result with acpi_p=
m clocksource.
But oprofile data shows acpi_pm has more cpu utilization. clocksource j=
iffies has
worst result but least cpu utilization. As you know, fio calls gettimeo=
fday frequently.
Then, I tried boot parameter processor.max_cstate and idle=3Dpoll.
I get the similar result with =EF=BB=BFprocessor.max_cstate=3D1 like th=
e one with idle=3Dpoll.

I also run the testing on 2 stoakley machines and don't find such issue=
s.
/proc/acpi/processor/CPUXXX/power shows stoakley cpu only has C1.

> I'm wondering whether we might have an even bigger problem with disk =
I/O
> related to this than just the raw ACPI exit latency value itself.
We might have. I'm still doing more testing. With Venki's tool (write/r=
ead MSR registers),
I collected some C state switch stat.

Current cpuidle has a good consideration on cpu utilization, but doesn'=
t have
consideration on devices. So with I/O delivery and interrupt drive mode=
l
with little cpu utilization, performance might be hurt if C state exit =
has a long
latency.

Yanmin


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
