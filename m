From: Tiago Marques <tiagomnm@gmail.com>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery lifetime on Windows
Date: Sun, 3 Oct 2010 16:06:42 +0100
Message-ID: <AANLkTinUJqU__oxnnO2LO9xHJMNyaSLjtJtrUvJu299K@mail.gmail.com>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
 <201009061035.03727.trenn@suse.de> <AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
 <201009071347.13509.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <201009071347.13509.trenn@suse.de>
Sender: cpufreq-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: cpufreq@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,

On Tue, Sep 7, 2010 at 12:47 PM, Thomas Renninger <trenn@suse.de> wrote=
:
>
> On Monday 06 September 2010 23:47:58 Tiago Marques wrote:
> > On Mon, Sep 6, 2010 at 9:35 AM, Thomas Renninger <trenn@suse.de> wr=
ote:
> ..
> > C states seem ok...ish. I get C0, C1 and C4, though not anything in
> > between. Don't know how to check in windows and usually it shouldn'=
t
> > in leaps, right? That might be a problem. I'm getting around 75% in
> > C4, the rest almost exclusively in C0. Perhaps the transitions are =
the
> > problem? I think I previously saw normal rates of closer to 98% so
> > I'll have to check what's going now. Too many wakeups from i915, us=
b
> > and wlan.
> > Powertop shows that the BIOS reports C1 and C4 support, hence only
> > these C-stats.
> Yep, I'd concentrate on this first. If idle, the system should be in =
deepest
> C-state (nearly) all of the time. Perfect tool for this is powertop.
> You could also boot into runlevel S. If the system is much more idle
> there you could load drivers one by one to find out whether there is =
a bad
> one keeping your cpu busy/awake.
>

The guilty party was the broadcom binary driver, it was waking the CPU
up 30k times per second. I've tried with an USB wlan card and it
hovers around 70-20 wakeups per second. Does that look normal?

>
> C-states also should "rule-out" P-states. If you are in C4 it shouldn=
't matter
> whether your freq is up or down, the core's freq and voltage should b=
e
> ramped down to a minimum on latest processors (I've never measured th=
at,
> but this is what I've heard from Intel guys themselves...).
>

I'm still due to actually measure times again but from casual
observation the CPU fan is still on considerably more time than in
Windows. It seems to me that the lower voltage in idle that Windows
can use does impact temperatures a bit, after all the CPU does have to
wake from time to time.
I'll be measuring this directly from the CPU voltage regulator when I
find the time, as to leave out any doubts on what's really going on.

Best regards,
Tiago

> Good luck,
>
> =C2=A0 =C2=A0Thomas
