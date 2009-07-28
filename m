From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: Dynamic configure max_cstate
Date: Tue, 28 Jul 2009 17:00:35 +0800
Message-ID: <1248771635.2560.682.camel@ymzhang>
References: <20090727073338.GA12669@rhlx01.hs-esslingen.de>
	 <1248748935.2560.669.camel@ymzhang>
	 <4e5e476b0907280020x242d9ef7gfa05c3d7b66f941f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6315 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbZG1JA1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Jul 2009 05:00:27 -0400
In-Reply-To: <4e5e476b0907280020x242d9ef7gfa05c3d7b66f941f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corrado Zoccolo <czoccolo@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Tue, 2009-07-28 at 09:20 +0200, Corrado Zoccolo wrote:
> Hi,
> On Tue, Jul 28, 2009 at 4:42 AM, Zhang,
> Yanmin<yanmin_zhang@linux.intel.com> wrote:
> > On Mon, 2009-07-27 at 09:33 +0200, Andreas Mohr wrote:
> >> Hi,
> >>
> >> > When running a fio workload, I found sometimes cpu C state has
> >> > big impact on the result. Mostly, fio is a disk I/O workload
> >> > which doesn't spend much time with cpu, so cpu switch to C2/C3
> >> > freqently and the latency is big.
> >>
> >> Rather than inventing ways to limit ACPI Cx state usefulness, we s=
hould
> >> perhaps be thinking of what's wrong here.
> > Andreas,
> >
> > Thanks for your kind comments.
> >
> >>
> >> And your complaint might just fit into a thought I had recently:
> >> are we actually taking ACPI Cx exit latency into account, for time=
rs???
> > I tried both tickless kernel and non-tickless kernels. The result i=
s similiar.
> >
> > Originally, I also thought it's related to timer. As you know, I/O =
block layer
> > has many timers. Such timers don't expire normally. For example, an=
 I/O request
> > is submitted to driver and driver delievers it to disk and hardware=
 triggers
> > an interrupt after finishing I/O. Mostly, the I/O submit and interr=
upt, not
> > the timer, drive the I/O.
> >
> >>
> >> If we program a timer to fire at some point, then it is quite imag=
inable
> >> that any ACPI Cx exit latency due to the CPU being idle at that mo=
ment
> >> could add to actual timer trigger time significantly.
> >>
> >> To combat this, one would need to tweak the timer expiration time
> >> to include the exit latency. But of course once the CPU is running
> >> again, one would need to re-add the latency amount (read: reprogra=
m the
> >> timer hardware, ugh...) to prevent the timer from firing too early=
=2E
> >>
> >> Given that one would need to reprogram timer hardware quite often,
> >> I don't know whether taking Cx exit latency into account is feasib=
le.
> >> OTOH analysis of the single next timer value and actual hardware r=
eprogramming
> >> would have to be done only once (in ACPI sleep and wake paths each=
),
> >> thus it might just turn out to be very beneficial after all
> >> (minus prolonging ACPI Cx path activity and thus aggravating CPU p=
ower
> >> savings, of course).
> >>
> >> Arjan mentioned examples of maybe 10us for C2 and 185us for C3/C4 =
in an
> >> article.
> >>
> >> OTOH even 185us is only 0.185ms, which, when compared to disk seek
> >> latency (around 7ms still, except for SSD), doesn't seem to be all=
 that much.
> >> Or what kind of ballpark figure do you have for percentage of I/O
> >> deterioration?
> > I have lots of FIO sub test cases which test I/O on single disk and=
 JBOD (a disk
> > bos which mostly has 12~13 disks) on nahelam machines. Your analysi=
s on disk seek
> > is reasonable. I found sequential buffered read has the worst regre=
ssion while rand
> > read is far better. For example, I start 12 processes per disk and =
every disk has 24
> > 1-G files. There are 12 disks. The sequential read fio result is ab=
out 593MB/second
> > with idle=3Dpoll, and about 375MB/s without idle=3Dpoll. Read block=
 size is 4KB.
> >
> > Another exmaple is single fio direct seqential read (block size is =
4K) on a single
> > SATA disk. The result is about 28MB/s without idle=3Dpoll and about=
 32.5MB with
> > idle=3Dpoll.
> >
> > How did I find C state has impact on disk I/O result? Frankly, I fo=
und a regression
> > between kernel 2.6.27 and 2.6.28. Bisect located a nonstop tsc patc=
h, but the patch
> > is quite good. I found the patch changes the default clocksource fr=
om hpet to
> > tsc. Then, I tried all clocksources and got the best result with ac=
pi_pm clocksource.
> > But oprofile data shows acpi_pm has more cpu utilization. clocksour=
ce jiffies has
> > worst result but least cpu utilization. As you know, fio calls gett=
imeofday frequently.
> > Then, I tried boot parameter processor.max_cstate and idle=3Dpoll.
> > I get the similar result with =EF=BB=BFprocessor.max_cstate=3D1 lik=
e the one with idle=3Dpoll.
> >
>=20
> Is it possible that the different bandwidths figures are due to
> incorrect timing, instead of C-state latencies?
I'm not sure.

> Entering a deep C state can cause strange things to timers: some of
> them, especially tsc, become unreliable.
> Maybe the patch you found that re-enables tsc is actually wrong for
> your machine, for which tsc is unreliable in deep C states.
I'm using a SDV machine, not an official product. But it's rare that cp=
uid
reports non-stop tsc feature while it doesn't support it.

I tried different clocksources. For exmaple, I could get a better (30%)=
 result with
hpet. With hpet, cpu utilization is about 5~8%. Function hpet_read uses=
 too much cpu
time. With tsc, cpu utilization is about 2~3%. I think more cpu utiliza=
tion causes fewer
C state transitions.

With idle=3Dpoll, the result is about 10% better than the one of hpet. =
If using idle=3Dpoll,
I didn't find result difference among different clocksources.

>=20
> > I also run the testing on 2 stoakley machines and don't find such i=
ssues.
> > /proc/acpi/processor/CPUXXX/power shows stoakley cpu only has C1.
> >
> >> I'm wondering whether we might have an even bigger problem with di=
sk I/O
> >> related to this than just the raw ACPI exit latency value itself.
> > We might have. I'm still doing more testing. With Venki's tool (wri=
te/read MSR registers),
> > I collected some C state switch stat.
> >
> You can see the latencies (expressed in us) on your machine with:
> [root@localhost corrado]# cat
> /sys/devices/system/cpu/cpu0/cpuidle/state*/latency
> 0
> 0
> 1
> 133
>=20
> Can you post your numbers, to see if they are unusually high?
[ymzhang@lkp-ne02 ~]$ cat /proc/acpi/processor/CPU0/power=20
active state:            C0
max_cstate:              C8
maximum allowed latency: 2000000000 usec
states:
    C1:                  type[C1] promotion[--] demotion[--] latency[00=
3] usage[00001661] duration[00000000000000000000]
    C2:                  type[C3] promotion[--] demotion[--] latency[20=
5] usage[00000687] duration[00000000000000732028]
    C3:                  type[C3] promotion[--] demotion[--] latency[24=
5] usage[00011509] duration[00000000000115186065]

[ymzhang@lkp-ne02 ~]$ cat /sys/devices/system/cpu/cpu0/cpuidle/state*/l=
atency
0
3
205
245

>=20
> > Current cpuidle has a good consideration on cpu utilization, but do=
esn't have
> > consideration on devices. So with I/O delivery and interrupt drive =
model
> > with little cpu utilization, performance might be hurt if C state e=
xit has a long
> > latency.


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
