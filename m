From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC PATCH 1/2] ACPI / button: Send "open" state after
 boot/resume
Date: Wed, 18 May 2016 14:57:14 +0200
Message-ID: <1463576234.3440.25.camel@hadess.net>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2016-05-17 at 16:27 +0800, Lv Zheng wrote:
> (This patch hasn't been tested, it's sent for comments)
>=20
> Linux userspace (systemd-logind) keeps on rechecking lid state when t=
he
> lid state is closed. If it failed to update the lid state to open aft=
er
> boot/resume, it could suspend the system. But as:
> 1. Traditional ACPI platform may not generate the lid open event afte=
r
> =C2=A0=C2=A0=C2=A0resuming as the open event is actually handled by t=
he BIOS and the system
> =C2=A0=C2=A0=C2=A0is then resumed from a FACS vector.
> 2. The _LID control method's initial returning value is not reliable.=
 The
> =C2=A0=C2=A0=C2=A0_LID control method is described to return the "cur=
rent" lid state,
> =C2=A0=C2=A0=C2=A0however the word of "current" has ambiguity, many B=
IOSen return lid
> =C2=A0=C2=A0=C2=A0state upon last lid notification while the develope=
rs may think the
> =C2=A0=C2=A0=C2=A0BIOSen should always return the lid state upon last=
 _LID evaluation.
> =C2=A0=C2=A0=C2=A0There won't be difference when we evaluate _LID dur=
ing the runtime, the
> =C2=A0=C2=A0=C2=A0problem is the initial returning value of this func=
tion. When the BIOSen
> =C2=A0=C2=A0=C2=A0implement this control method with cached value, th=
e initial returning
> =C2=A0=C2=A0=C2=A0value is likely not reliable.
> Thus there is no mean for the ACPI lid driver to provide such an even=
t
> conveying correct current lid state. When there is no such an event o=
r the
> event conveys wrong result, false suspending can be examined.
>=20
> The root cause of the issue is systemd itself, it could handle the AC=
PI
> control method lid device by implementing a special option like
> LidSwitchLevelTriggered=3DFalse when it detected the ACPI lid device.=
 However
> there is no explicit documentation clarified the ambiguity, we need t=
o
> work it around in the kernel before systemd changing its mind.
>=20
> Link 1: https://lkml.org/2016/3/7/460
> Link 2: https://github.com/systemd/systemd/issues/2087
> Link 3: https://bugzilla.kernel.org/show_bug.cgi?id=3D89211
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://bugzilla.kern=
el.org/show_bug.cgi?id=3D106151
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://bugzilla.kern=
el.org/show_bug.cgi?id=3D106941
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Bastien Nocera: <hadess@hadess.net>

As mentioned previously, I'd be much happier if either:
- a new system was put in place that matched the ACPI specs and the way
they are used by Windows
- an additional tag/property was added to show that the API offered by
the LID switch is different from the one that existing since ACPI
support was added to Linux.

And I'd really appreciate it if you stopped saying that it's systemd's
fault.

The kernel has offered an API to user-space that included the state of
the LID switch. And the state of the LID switch has been correct for
the majority of systems and devices for the past decade or so. The fact
that this device means that the LID state isn't reliable anymore means
that the kernel needs to communicate that to user-space.

I'm volunteering to modify systemd and UPower to respect the fact that
the LID switch state isn't available on those devices. If you want to
find something to blame, blame the kernel for implementing an API that
doesn't reflect what the hardware makes available. Though you can only
say that with the benefit of hindsight.

So, NAK from me.
