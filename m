From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [linux-pm] [RFC] the generic thermal layer enhancement
Date: Fri, 1 Jun 2012 11:05:30 +0200
Message-ID: <CAORVsuWEs1xixjURUE_dpofv-Jy4b_e0r=xgW7MGuW3Rp90daA@mail.gmail.com>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
	<1338367860.1472.129.camel@rui.sh.intel.com>
	<20120530103006.GA3261@besouro>
	<CAK44p20bjZfX-ur0V8hmSGzLDJ0cDLCTQ4LkHKQqSvfFbqyG+w@mail.gmail.com>
	<20120531111316.GC3673@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44946 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752190Ab2FAJFc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Jun 2012 05:05:32 -0400
Received: by lahd3 with SMTP id d3so1380044lah.19
        for <linux-acpi@vger.kernel.org>; Fri, 01 Jun 2012 02:05:30 -0700 (PDT)
In-Reply-To: <20120531111316.GC3673@besouro>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: eduardo.valentin@ti.com
Cc: Amit Kachhap <amit.kachhap@linaro.org>, Jean Delvare <jdelvare@suse.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, mark gross <markgross@thegnar.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi!

On Thu, May 31, 2012 at 1:13 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> Hello,
>
> On Thu, May 31, 2012 at 01:16:37PM +0800, Amit Kachhap wrote:
>> On 30 May 2012 18:30, Eduardo Valentin <eduardo.valentin@ti.com> wro=
te:
>> > Hello Rui,
>> >
>> > Now I copied Amit, for real :-)
>> >
>> > I like your proposal, some comments as follow.
>> >
>> > On Wed, May 30, 2012 at 04:51:00PM +0800, Zhang Rui wrote:
>> >> On =E4=B8=89, 2012-05-30 at 16:49 +0800, Zhang Rui wrote:
>> >> > Hi, all,
>> >> >
>> >> > It is great to see more and more users of the generic thermal l=
ayer.
>> >> > But as we know, the original design of the generic thermal laye=
r comes
>> >> > from ACPI thermal management, and some of its implementation se=
ems to be
>> >> > too ACPI specific nowadays.
>> >
>> >
>> > Good. We have also basic OMAP support, on top of Amit's work. I se=
nt
>> > recently a very basic support. =C2=A0I will be pushing them, while=
 they evolve.
>> >
>> >> >
>> >> > Recently I'm thinking of enhance the generic thermal layer so t=
hat it
>> >> > works well for more platforms.
>> >
>> > As you said, for non-ACPI support, the "generic" layer needs some
>> > extension and refactoring to be more generic :-).
>> >
>> >> >
>> >> > Below are some thoughts of mine, after reading the patches from=
 Amit
>> >> > Daniel Kachhap, and ACPI 3.0 thermal model. Actually, I have st=
arted
>> >> > coding some RFC patches. But I do really want to get feedback f=
rom you
>> >> > before going on.
>> >
>> > OK.
>> >
>> >> >
>> >> > G1. supporting multiple cooling states for active cooling devic=
es.
>> >> >
>> >> > =C2=A0 =C2=A0 The current active cooling device supports two co=
oling states only,
>> >> > =C2=A0 =C2=A0 please refer to the code below, in driver/thermal=
/thermal_sys.c
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case TH=
ERMAL_TRIP_ACTIVE:
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ...
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (temp >=3D trip_temp)
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev->ops->set_cur_sta=
te(cdev, 1);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 else
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev->ops->set_cur_sta=
te(cdev, 0);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 break;
>> >> >
>> >> > =C2=A0 =C2=A0 This is an ACPI specific thing, as our ACPI FAN u=
sed to support
>> >> > =C2=A0 =C2=A0 ON/OFF only.
>> >> > =C2=A0 =C2=A0 I think it is reasonable to support multiple acti=
ve cooling states
>> >> > =C2=A0 =C2=A0 as they are common on many platforms, and note th=
at this is also
>> >> > =C2=A0 =C2=A0 true for ACPI 3.0 FAN device (_FPS).
>> >> >
>> >> > G2. introduce cooling states range for a certain trip point
>> >> >
>> >> > =C2=A0 =C2=A0 This problem comes with the first one.
>> >> > =C2=A0 =C2=A0 If the cooling devices support multiple cooling s=
tates, and surely
>> >> > =C2=A0 =C2=A0 we may want only several cooling states for a cer=
tain trip point,
>> >> > =C2=A0 =C2=A0 and other cooling states for other active trip po=
ints.
>> >> > =C2=A0 =C2=A0 To do this, we should be able to describe the coo=
ling device
>> >> > =C2=A0 =C2=A0 behavior for a certain trip point, rather than fo=
r the entire
>> >> > =C2=A0 =C2=A0 thermal zone.
>> >
>> > For G1+G2, I agree with your proposal. I had some discussion with =
Amit
>> > regarding this. In his series of patches we increase / decrease th=
e cooling
>> > device state linearly and steadily.
>> >
>> > But if we would have what you are saying, we could bind cooling de=
vice
>> > set of states with trip points.
>> >
>> >> >
>> >> > G3. kernel thermal passive cooling algorithm
>> >> >
>> >> > =C2=A0 =C2=A0 Currently, tc1 and tc2 are hard requirements for =
kernel passive
>> >> > =C2=A0 =C2=A0 cooling. But non-ACPI platforms do not have this =
information
>> >> > =C2=A0 =C2=A0 (please correct me if I'm wrong).
>> >> > =C2=A0 =C2=A0 Say, for the patches here
>> >> > =C2=A0 =C2=A0 http://marc.info/?l=3Dlinux-acpi&m=3D133681581305=
341&w=3D2
>> >>
>> >> Sorry, forgot to cc Amit, the author of this patch set.
>> >>
>> >> thanks,
>> >> rui
>> >> > =C2=A0 =C2=A0 They just want to slow down the processor when cu=
rrent temperature
>> >> > =C2=A0 =C2=A0 is higher than the trip point and speed up the pr=
ocessor when the
>> >> > =C2=A0 =C2=A0 temperature is lower than the trip point.
>> >> >
>> >> > =C2=A0 =C2=A0 According to Matthew, the platform drivers are re=
sponsible to
>> >> > =C2=A0 =C2=A0 provide proper tc1 and tc2 values to use kernel p=
assive cooling.
>> >> > =C2=A0 =C2=A0 But I'm just wondering if we can use something in=
stead.
>> >> > =C2=A0 =C2=A0 Say, introduce .get_trend() in thermal_zone_devic=
e_ops.
>> >> > =C2=A0 =C2=A0 And we set cur_state++ or cur_state-- based on th=
e value returned
>> >> > =C2=A0 =C2=A0 by .get_trend(), instead of using tc1 and tc2.
>> >
>> > I fully support this option and could cook up something on this.
>> > The TC1 and TC2 should go inside the .get_trend()=C2=A0callbacks f=
or ACPI.
>> > Should probably go away from the registration function that we hav=
e
>> > currently.
>> >
>> > We could have generic trending computation though. Based on timest=
amping
>> > and temperature reads, and make it available for zones that want t=
o used it.
>> >
>> >> >
>> >> > G4. Multiple passive trip points
>> >> >
>> >> > =C2=A0 =C2=A0 I get this idea also from the patches at
>> >> > =C2=A0 =C2=A0 http://marc.info/?l=3Dlinux-acpi&m=3D133681581305=
341&w=3D2
>> >> >
>> >> > =C2=A0 =C2=A0 IMO, they want to get an acceptable performance a=
t a tolerable
>> >> > =C2=A0 =C2=A0 temperature.
>> >> > =C2=A0 =C2=A0 Say, a platform with four P-states. P3 is really =
low.
>> >> > =C2=A0 =C2=A0 And I'm okay with the temperature at 60C, but 80C=
? No.
>> >> > =C2=A0 =C2=A0 With G2 resolved, we can use processor P0~P2 for =
Passive trip point
>> >> > =C2=A0 =C2=A0 0 (50C), and P3 for Passive trip point 1 (70C). A=
nd then the
>> >> > =C2=A0 =C2=A0 temperature may be jumping at around 60C or even =
65C, without
>> >> > =C2=A0 =C2=A0 entering P3.
>> >
>> > Yeah, I guess we need to solve G1+G2 first to allow this. But I al=
so agree
>> > that ideally, there should be possibility to have multiple passive=
 trip points.
>> >
>> >> >
>> >> > =C2=A0 =C2=A0 Further more, IMO, this also works for ACPI platf=
orms.
>> >> > =C2=A0 =C2=A0 Say, we can easily change p-state to cool the sys=
tem, but using
>> >> > =C2=A0 =C2=A0 t-state is definitely what we do not want to see.=
 The current
>> >> > =C2=A0 =C2=A0 implementation does not expose this difference to=
 the generic
>> >> > =C2=A0 =C2=A0 thermal layer, but if we can have two passive tri=
p points, and use
>> >> > =C2=A0 =C2=A0 p-state for the first one only... (this works if =
we start polling
>> >> > =C2=A0 =C2=A0 after entering passive cooling mode, without hard=
ware notification)
>> >> >
>> >> > G5. unify active cooling and passive cooling code
>> >> >
>> >> > =C2=A0 =C2=A0 If G4 and G5 are resolved, a new problem to me is=
 that there is no
>> >> > =C2=A0 =C2=A0 difference between passive cooling and active coo=
ling except the
>> >> > =C2=A0 =C2=A0 cooling policy.
>> >
>> > OK...
>> >
>> >> > =C2=A0 =C2=A0 Then we can share the same code for both active a=
nd passive cooling.
>> >> > =C2=A0 =C2=A0 maybe something like:
>> >> >
>> >> > =C2=A0 =C2=A0 case THERMAL_TRIP_ACTIVE:
>> >> > =C2=A0 =C2=A0 case THERMAL_TRIP_PASSIVE:
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tz->ops->get_trend();
>> >
>> > Would the get_trend take into account if we are cooling with activ=
e or passive
>> > cooling device?
>> >
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (trend =3D=3D HEATING)
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
dev->ops->set_cur_state(cdev, cur_state++);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (trend =3D=3D COOLING=
)
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
dev->ops->set_cur_state(cdev, cur_state--);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>> >
>> > I believe we should have something for temperature stabilization t=
here as well.
>> I also agree that thermal stablization is important. I have observed
>> that too much state change is happening around the trip point. But y=
es
>> =C2=A0the trend callback may take care of this and set the COOLING t=
rend
>> different from HEATING trend.
>> >
>> > Besides, if we go with this generic policy, then the zone update w=
ould be much
>> > simpler no?
>> >
>> >> >
>> >> > Here are the gaps in my point of view, I'd like to get your ide=
as about
>> >> > which are reasonable and which are not.
>> >
>> > Here are some other thoughts:
>> > G6. Another point is, would it make sense to allow for policy exte=
nsion? Meaning,
>> > the zone update would call a callback to request for update from t=
he zone
>> > device driver?
>> This may a simple work with adding notifiers like done for CRITICAL,
>> HOT trip type.
>> >
>> > G7. How do we solve cooling devices being shared between different=
 thermal zones?
>> > Should we have a better cooling device constraint management?
>> >
>> > G8. On same topic as G7, how are we currently making sure that the=
rmal constraints
>> > don't get overwritten by, let's say, userspace APIs? I guess the g=
eneric CPU cooling
>> > propose by Amit suffers of an issue. If user sets cpufreq governor=
 to userspace
>> > and sets the frequency to its maximum, say in a busy loop, the the=
rmal cooling
>> > could potentially be ruined.
>> Yes I agree that is a problem in my implementation but I guess the
>> current cpufreq framework does not have anything to stop this. May b=
e
>> with cpufreq_max pmqos patches this will be taken care.
>
> Just a clarification here. I didn't really mean that this is a proble=
m on your implementation.
> But a general problem. And needs to be dealt properly.
>
> And to be frank, assuming that just because we selected userspace at =
cpufreq level it is
> userland problem, it is a weak solution. Specially considering that t=
his may lead to
> potentially harmful situations.
>
> Not sure this needs to be solved at the generic thermal framework, bu=
t at least
> the thermal framework should be aware of who is dealing with the cons=
traint management.
>
> The pmqos patch is a good direction to go, IMO.
Agree! There is a real need to have a framework for the following:
- per-device PM QoS,
- devices throughput,
- thermal constraints and cooling devices,
- min/max performance constraint,
- ...

However for good reasons the current PM QoS framework cannot address
all those requirements at once.

=46rom the code submissions and discussions on the MLs Mark Gross came
with the very good idea of organizing a specific micro-conference
around the constraints framework at LPC [1]. The topics starting with
'lpc2012-cf-' are part of this micro-conference. Most of the topics
-if not all- are about thermal management integration.

[1] https://blueprints.launchpad.net/lpc

I have big expectations from the LPC. Meeting face to face and discuss
the proposals is a good way to make progress, which is not so
efficient on the MLs.

Regards,
Jean

>
>> >
>> > G9. Is there any possibility to have multiple sensors per thermal =
zone?
>> >
>> > G10. Do we want to represent other sensing stimuli other that temp=
erature? Say,
>> > current sensing?
>> Yes this is good field to look into.
>> >
>> > G11. Do we want to allow for cross zoning policies? Sometimes a po=
licy may use
>> > temperature from different thermal zone in order to better represe=
nt what
>> > is going on in its thermal zone.
>> >
>> >> >
>> >> > Any comments are appreciated! Thanks!
>> >
>> >
>> > Thanks to you for starting this up! The above are points that come=
 to my mind now.
>> > I will keep updating the list if something else come to my mind.
>> >
>> >> >
>> >> > -rui
>> >> >
>> >> > _______________________________________________
>> >> > linux-pm mailing list
>> >> > linux-pm@lists.linux-foundation.org
>> >> > https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
>> >>
>> >>
>> >> _______________________________________________
>> >> linux-pm mailing list
>> >> linux-pm@lists.linux-foundation.org
>> >> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
>> >
>> > All best,
>> >
>> > ---
>> > Eduardo Valentin
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
