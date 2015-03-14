From: Nikolaus Rath <Nikolaus@rath.org>
Subject: Help with debugging intermittent crash on resume from hibernation
Date: Fri, 13 Mar 2015 20:02:45 -0700
Message-ID: <8761a3s1vq.fsf@vostro.rath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,

In about one out of 10 resumes from hibernation, my system resets after
the hibernation image has been loaded. I am hibernating using

# echo platform > /sys/power/disk
# echo disk > /sys/power/state

When testing hibernation using

# echo core > /sys/power/pm_test
# echo platform > /sys/power/disk
# echo disk > /sys/power/state

I was not able to produce the same failure.

I then tried attaching a serial console and booted with
console=3DttyS0,115200n8 no_console_suspend. For the failed attempt, th=
e
last messages before the reset are:

[   25.192978] Disabling non-boot CPUs ...
[   25.234496] intel_pstate CPU 1 exiting
[   25.270548] NOHZ: local_softirq_pending 10
[   25.274657] NOHZ: local_softirq_pending 10
[   25.279892] smpboot: CPU 1 is now offline
[   25.318618] intel_pstate CPU 2 exiting
[   25.454816] smpboot: CPU 2 is now offline
[   25.494879] intel_pstate CPU 3 exiting
[   25.647097] smpboot: CPU 3 is now offline
[   25.687158] intel_pstate CPU 4 exiting
[   25.819349] smpboot: CPU 4 is now offline
[   25.859411] intel_pstate CPU 5 exiting
[   25.995610] smpboot: CPU 5 is now offline
[   26.015640] intel_pstate CPU 6 exiting
[   26.155843] smpboot: CPU 6 is now offline
[   26.175874] intel_pstate CPU 7 exiting
[   26.201040] smpboot: CPU 7 is now offline

=46or the successful attempt, the last messages before the jump in the
time (which I assume indicate that resume was complete) are:

[   25.428213] Disabling non-boot CPUs ...^M
[   25.549875] intel_pstate CPU 1 exiting^M
[   25.694081] smpboot: CPU 1 is now offline^M
[   27.092141] intel_pstate CPU 2 exiting^M
[   27.232341] smpboot: CPU 2 is now offline^M
[   27.364542] intel_pstate CPU 3 exiting^M
[   27.404597] NOHZ: local_softirq_pending 10^M
[   27.408704] NOHZ: local_softirq_pending 10^M
[   27.413942] smpboot: CPU 3 is now offline^M
[   27.556820] intel_pstate CPU 4 exiting^M
[   27.582000] smpboot: CPU 4 is now offline^M
[   27.600891] intel_pstate CPU 5 exiting^M
[   27.745093] smpboot: CPU 5 is now offline^M
[   27.849247] intel_pstate CPU 6 exiting^M
[   28.538259] smpboot: CPU 6 is now offline^M
[   28.558292] intel_pstate CPU 7 exiting^M
[   28.583457] smpboot: CPU 7 is now offline^M
[23880.929604] Enabling non-boot CPUs ...^M
[23880.933432] x86: Booting SMP configuration:^M

(I uploaded the complete logs to https://dl.dropboxusercontent.com/u/11=
545826/logfiles.tar.xz).

At least to me, this unfortunately gives absolutely no indication of
what might be going wrong.

Other than trying again with the -rc3 (which I'll do next), is there
anything else I can do to debug this further?


Thanks,
-Nikolaus

--=20
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
=46ingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=
=C2=AB
