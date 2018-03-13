From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: linux-next on thinkpad x60: full battery is indicated as battery
 error in mate
Date: Tue, 13 Mar 2018 10:14:43 +0100
Message-ID: <CAJZ5v0i6sEcDQ8fCgPSdt6MpLm5BCKY4Aam6zxQi-s0WY9Qq_A@mail.gmail.com>
References: <20180312194715.GA3992@amd> <20180312194944.GA3979@amd>
 <CAJZ5v0gWd7OCy+P41CFWJ1E9Tzw++Ok=YmjQwLk+iSZutBzphA@mail.gmail.com>
 <20180312223521.vzccevf6z7ik5ysf@thinkpad> <20180312230407.GA7612@amd>
 <CAJZ5v0irEfMxURr2c8VZ=SZhsW+MWxRd4OwDH5bS6P=R3a0REw@mail.gmail.com>
 <20180312231847.GB7612@amd> <20180313005103.brhhrxlatxfkdw7p@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313005103.brhhrxlatxfkdw7p@thinkpad>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 13, 2018 at 1:51 AM, Ognjen Gali=C4=87 <smclt30p@gmail.com> wro=
te:
> On Tue, Mar 13, 2018 at 12:18:47AM +0100, Pavel Machek wrote:
>> Hi!
>>
>> > >> > >> Fully charged
>> > >> > >> battery shows as empty battery with red "x" in Mate desktop. A=
fter
>> > >> > >> reboot to recent mainline problem goes away. Tooltip says "bat=
tery
>> > >> > >> waiting to charge".
>> > >> > >>
>> > >>
>> > >> For the MATE bug see:
>> > >> https://github.com/mate-desktop/mate-power-manager/pull/251
>> > >>
>> > >> The problem is in the new composite battery system in UPower, it
>> > >> "merges" two external batteries into a single one for reporting. Th=
at
>> > >> battery does not understand "Not Charging" inside the MATE Power
>> > >> Manager. The above patch fixes that in MATE.
>> > >
>> > > Ok, so problem is 91eea70e5e5ce12eb1c7cd922e561fab43e201bd.
>> > >
>> > > And now, I see that MATE should be improved.
>> > >
>> > > But what I also see is that kernel is changing its interface in a wa=
y
>> > > that (while making sense) breaks existing application. And we don't
>> > > break existing applications.
>> > >
>> > > [Now... maybe if the fix for the application is available for long
>> > > long time and noone is really looking and everyone already has new
>> > > application version, maybe ... But pull request for MATE is 9 days
>> > > old, and not even merged. So there is no way this is suitable for
>> > > 4.17.]
>> >
>> > Right.
>> >
>> > This basically means that we will have to defer the battery changes
>> > until user space is ready and not just upstream, but also in distro
>> > packages.
>>
>> Yes please.
>>
>> Note that only 91eea70e5e5ce12eb1c7cd922e561fab43e201bd should break
>> anything, the others should be safe AFAICT?
>>
>>                                                               Pavel
>>
>
> Actually there is a bug in UPower itself, and that reflects the status
> icon being broken in almost all desktop environments. I will work on
> fixing UPower in the following days. Disregard my previous comment.

I have reverted commit 91eea70e5e5ce12e for the time being.

Of course, it can be applied again after all of the bus triggered by
it have been fixed and the fixes have gone to users.
