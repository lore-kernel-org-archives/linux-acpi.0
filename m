From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: Ideapad S10-3 rfkill issues with fix
Date: Wed, 29 Jun 2011 11:00:11 -0600
Message-ID: <BANLkTimk2ZL6Su1_MR6VmjnWxYUu9Ee4mg@mail.gmail.com>
References: <BANLkTi=HABawWJL2znCDRAM4MqEHPt9xEQ@mail.gmail.com>
 <4E0B52E9.4050804@canonical.com> <BANLkTimm+PZNE5mBP251dPkrzeYg04suuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <BANLkTimm+PZNE5mBP251dPkrzeYg04suuQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
Cc: Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, b43-dev <b43-dev@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

2011/6/29 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>:
> 2011/6/29 Ike Panhc <ike.pan@canonical.com>:
>> On 06/26/2011 06:53 AM, Andrew Lutomirski wrote:
>>> [linux-acpi cc'd because I don't know how to write to an ACPI field=
,
>>> and the fix to this bug probably needs that ability.]
>>>
>>> Hi platform people-
>>>
>>> My nephew's Ideapad S10-3 decided that it didn't want to support
>>> wireless anymore. =C2=A0I think it happened when he fiddled with hi=
s rfkill
>>> switch, but I haven't been able to reproduce the problem yet. =C2=A0=
This
>>> seems to be a common bug, and the only known fixes (so far) are to
>>> boot into Windows and fiddle with the settings or to remove the CMO=
S
>>> battery.
>>>
>>> This seems to be related to:
>>> http://ubuntuforums.org/showthread.php?t=3D1744402
>>> https://bugs.meego.com/show_bug.cgi?id=3D4086
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/730972
>>>
>>> Of course, he doesn't have Windows installed, and I didn't want to
>>> take apart his laptop. =C2=A0So I figured out the problem.
>>>
>>> The relevant ACPI fields and functions are (as far as I can tell):
>>>
>>> \FL07: The non-volatile copy of the RF enabled flag
>>> \_SB.PCI0.LPCB.EC0.WRFS: RF enabled flag
>>> \GO26: The GPIO line that controls the PHY (not really tested at al=
l)
>>> \GO28: The RF light, inverted. =C2=A0This doesn't work without manu=
al
>>> override on my S10-3 because I don't have bluetooth or 3G, AFAICT.
>>>
>>> \_SB.PCI0.LPCB.EC0.DSLD: Load WRFS from FL07 (on startup)
>>> \_SB.PCI0.LPCB.EC0.DSSV: Save WRFS to FL07, called from some hotkey
>>> handler or other
>>> \_SB.PCI0.LPCB.EC0.DSGO: Commit WRFS to hardware (i.e. \GO26).
>>>
>>> Oddly enough, nothing in the DSDT seems to write WRFS or FL07 excep=
t
>>> to copy FL07 to WRFS. =C2=A0So triggering the problem might involve
>>> toggling the switch from inside BIOS or something similar.
>>>
>>> The fix would be (I think) to change ideapad_sync_rfk_state to do t=
his
>>> (in pseudocode):
>>> if (!hw_blocked !=3D WRFS) {
>>> =C2=A0 WRFS =3D !hw_blocked;
>>> =C2=A0 DSSV()
>>> =C2=A0 DSGO()
>>> }
>>>
>>> I don't plan to send a patch for two reasons:
>>>
>>> 1. I don't know how to write to an ACPI field. =C2=A0acpi_ns_evalua=
te can
>>> read fields, but it can't write them AFAICT. =C2=A0The ability to w=
rite to
>>> a field would be really nice. =C2=A0I did it by frobbing the ports =
by hand.
>>>
>>> 2. My nephew's taking his laptop home tomorrow, so I won't be able =
to
>>> test a patch.
>>>
>>> In the mean time, if you are affected by this problem and you reall=
y
>>> don't care how badly you damage your laptop, you could run the
>>> attached program, passing 1 as a parameter. =C2=A0Then you should p=
robably
>>> reboot. =C2=A0Before you even consider trying that, you should chec=
k
>>> whether the magic hardcoded numbers match your DSDT. =C2=A0If you d=
on't
>>> know how to do that, then you probably shouldn't run the program.
>>>
>>> --Andy
>>>
>>> P.S. =C2=A0Some people with this bug find that their system freezes=
 hard
>>> when they try and fail to fix it. =C2=A0I think this is a bug in br=
cm80211
>>> in 2.6.38 that's been fixed in brcmsmac in 2.6.39. =C2=A0But I don'=
t really
>>> feel like testing that carefully, given that I've already fixed the
>>> root cause.
>>
>> Thanks for your report. I have a S10-3 but barely touch the wifi swi=
tch.
>>
>> I know there are two drivers for Broadcom wifi chips. One is b43 whi=
ch
>> is fully open and in linux kernel tree. The other is wl comes from
>> Broadcom with other license agreement and its source code is not ful=
ly
>> open.

I don't have access to the laptop anymore, but from memory:

I tried wl, brcm80211 (from 2.6.38) and brcmsmac (from 2.6.39).  I
don't think b43 supported that hardware.

wl and brcmsmac both showed ideapad-laptop soft and hard unblocked and
the wireless driver's rfkill soft unblocked but hard blocked.

brcm80211 froze the system hard.  I think it can't deal with rfkill.

>> In your mail you did not mention the output of 'rfkill list'. In my
>> view point this is necessary info that tells us who block the wifi.
>> I guess the your wifi problem is because one of the wlan rfkill show=
s
>> blocked.

Yes.

>> What I know is that the fix you suggest is hardly to be accepted
>> because those ACPI objects is not under VPC2004 and not always avail=
able
>> on ideapads. I have 8 ideapad DSDT but only two with those objects.
>>
>> I will test the wifi switch on my ideapads again after I back to hom=
e
>> which will be next week and see if I can reproduce the same issue.
>
> I've got one similar report on IRC #bcm-users from Ideapad user. When
> he booted with rfkill on, Broadcom was not visible in lspci at all.
> Switching rfkill during working system didn't change anything. He had
> to power down, switch rfkill off and boot.

I tried that and it didn't help.  I even tried turning the switch on
and leaving the battery out for awhile.

--Andy
