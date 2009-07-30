From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: Dynamic configure max_cstate
Date: Thu, 30 Jul 2009 14:28:00 +0800
Message-ID: <1248935280.2560.733.camel@ymzhang>
References: <20090727073338.GA12669@rhlx01.hs-esslingen.de>
	 <1248748935.2560.669.camel@ymzhang>
	 <4e5e476b0907280020x242d9ef7gfa05c3d7b66f941f@mail.gmail.com>
	 <1248771635.2560.682.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752164AbZG3G14@vger.kernel.org>
In-Reply-To: <1248771635.2560.682.camel@ymzhang>
Sender: linux-kernel-owner@vger.kernel.org
To: Corrado Zoccolo <czoccolo@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2009-07-28 at 17:00 +0800, Zhang, Yanmin wrote:
> On Tue, 2009-07-28 at 09:20 +0200, Corrado Zoccolo wrote:
> > Hi,
> > On Tue, Jul 28, 2009 at 4:42 AM, Zhang,
> > Yanmin<yanmin_zhang@linux.intel.com> wrote:
> > > On Mon, 2009-07-27 at 09:33 +0200, Andreas Mohr wrote:
> > >> Hi,
> > >>
> > >> > When running a fio workload, I found sometimes cpu C state has
> > >> > big impact on the result. Mostly, fio is a disk I/O workload
> > >> > which doesn't spend much time with cpu, so cpu switch to C2/C3
> > >> > freqently and the latency is big.
> > >>
> > >> Rather than inventing ways to limit ACPI Cx state usefulness, we=
 should
> > >> perhaps be thinking of what's wrong here.
> > > Andreas,
> > >
> > > Thanks for your kind comments.
> > >
> > >>
> > >> And your complaint might just fit into a thought I had recently:
> > >> are we actually taking ACPI Cx exit latency into account, for ti=
mers???
> > > I tried both tickless kernel and non-tickless kernels. The result=
 is similiar.
> > >
> > > Originally, I also thought it's related to timer. As you know, I/=
O block layer
> > > has many timers. Such timers don't expire normally. For example, =
an I/O request
> > > is submitted to driver and driver delievers it to disk and hardwa=
re triggers
> > > an interrupt after finishing I/O. Mostly, the I/O submit and inte=
rrupt, not
> > > the timer, drive the I/O.
> > >
> > >>
> > >> If we program a timer to fire at some point, then it is quite im=
aginable
> > >> that any ACPI Cx exit latency due to the CPU being idle at that =
moment
> > >> could add to actual timer trigger time significantly.
> > >>
> > >> To combat this, one would need to tweak the timer expiration tim=
e
> > >> to include the exit latency. But of course once the CPU is runni=
ng
> > >> again, one would need to re-add the latency amount (read: reprog=
ram the
> > >> timer hardware, ugh...) to prevent the timer from firing too ear=
ly.
> > >>
> > >> Given that one would need to reprogram timer hardware quite ofte=
n,
> > >> I don't know whether taking Cx exit latency into account is feas=
ible.
> > >> OTOH analysis of the single next timer value and actual hardware=
 reprogramming
> > >> would have to be done only once (in ACPI sleep and wake paths ea=
ch),
> > >> thus it might just turn out to be very beneficial after all
> > >> (minus prolonging ACPI Cx path activity and thus aggravating CPU=
 power
> > >> savings, of course).
> > >>
> > >> Arjan mentioned examples of maybe 10us for C2 and 185us for C3/C=
4 in an
> > >> article.
> > >>
> > >> OTOH even 185us is only 0.185ms, which, when compared to disk se=
ek
> > >> latency (around 7ms still, except for SSD), doesn't seem to be a=
ll that much.
> > >> Or what kind of ballpark figure do you have for percentage of I/=
O
> > >> deterioration?
> > > I have lots of FIO sub test cases which test I/O on single disk a=
nd JBOD (a disk
> > > bos which mostly has 12~13 disks) on nahelam machines. Your analy=
sis on disk seek
> > > is reasonable. I found sequential buffered read has the worst reg=
ression while rand
> > > read is far better. For example, I start 12 processes per disk an=
d every disk has 24
> > > 1-G files. There are 12 disks. The sequential read fio result is =
about 593MB/second
> > > with idle=3Dpoll, and about 375MB/s without idle=3Dpoll. Read blo=
ck size is 4KB.
> > >
> > > Another exmaple is single fio direct seqential read (block size i=
s 4K) on a single
> > > SATA disk. The result is about 28MB/s without idle=3Dpoll and abo=
ut 32.5MB with
> > > idle=3Dpoll.
> > >
> > > How did I find C state has impact on disk I/O result? Frankly, I =
found a regression
> > > between kernel 2.6.27 and 2.6.28. Bisect located a nonstop tsc pa=
tch, but the patch
> > > is quite good. I found the patch changes the default clocksource =
from hpet to
> > > tsc. Then, I tried all clocksources and got the best result with =
acpi_pm clocksource.
> > > But oprofile data shows acpi_pm has more cpu utilization. clockso=
urce jiffies has
> > > worst result but least cpu utilization. As you know, fio calls ge=
ttimeofday frequently.
> > > Then, I tried boot parameter processor.max_cstate and idle=3Dpoll=
=2E
> > > I get the similar result with =EF=BB=BFprocessor.max_cstate=3D1 l=
ike the one with idle=3Dpoll.
> > >
> >=20
> > Is it possible that the different bandwidths figures are due to
> > incorrect timing, instead of C-state latencies?
> I'm not sure.
>=20
> > Entering a deep C state can cause strange things to timers: some of
> > them, especially tsc, become unreliable.
> > Maybe the patch you found that re-enables tsc is actually wrong for
> > your machine, for which tsc is unreliable in deep C states.
> I'm using a SDV machine, not an official product. But it's rare that =
cpuid
> reports non-stop tsc feature while it doesn't support it.
>=20
> I tried different clocksources. For exmaple, I could get a better (30=
%) result with
> hpet. With hpet, cpu utilization is about 5~8%. Function hpet_read us=
es too much cpu
> time. With tsc, cpu utilization is about 2~3%. I think more cpu utili=
zation causes fewer
> C state transitions.
>=20
> With idle=3Dpoll, the result is about 10% better than the one of hpet=
=2E If using idle=3Dpoll,
> I didn't find result difference among different clocksources.
>=20
> >=20
> > > I also run the testing on 2 stoakley machines and don't find such=
 issues.
> > > /proc/acpi/processor/CPUXXX/power shows stoakley cpu only has C1.
> > >
> > >> I'm wondering whether we might have an even bigger problem with =
disk I/O
> > >> related to this than just the raw ACPI exit latency value itself=
=2E
> > > We might have. I'm still doing more testing. With Venki's tool (w=
rite/read MSR registers),
> > > I collected some C state switch stat.
> > >
> > You can see the latencies (expressed in us) on your machine with:
> > [root@localhost corrado]# cat
> > /sys/devices/system/cpu/cpu0/cpuidle/state*/latency
> > 0
> > 0
> > 1
> > 133
> >=20
> > Can you post your numbers, to see if they are unusually high?
> [ymzhang@lkp-ne02 ~]$ cat /proc/acpi/processor/CPU0/power=20
> active state:            C0
> max_cstate:              C8
> maximum allowed latency: 2000000000 usec
> states:
>     C1:                  type[C1] promotion[--] demotion[--] latency[=
003] usage[00001661] duration[00000000000000000000]
>     C2:                  type[C3] promotion[--] demotion[--] latency[=
205] usage[00000687] duration[00000000000000732028]
>     C3:                  type[C3] promotion[--] demotion[--] latency[=
245] usage[00011509] duration[00000000000115186065]
>=20
> [ymzhang@lkp-ne02 ~]$ cat /sys/devices/system/cpu/cpu0/cpuidle/state*=
/latency
> 0
> 3
> 205
> 245
>=20
> >=20
> > > Current cpuidle has a good consideration on cpu utilization, but =
doesn't have
> > > consideration on devices. So with I/O delivery and interrupt driv=
e model
> > > with little cpu utilization, performance might be hurt if C state=
 exit has a long
> > > latency.
Another interesting testing with netperf has the similiar behavior. I s=
tart 1 netperf client
and bind client and server to different physical cpus to run a UDP-RR-1=
 loopback testing.
The result is about 54000 without idle=3Dpoll while the one is 88000 wi=
th idle=3Dpoll.

If I start CPU_NUM netperf clients, there is no such issue, because all=
 cpu are busy.
