From: Ike Panhc <ike.pan@canonical.com>
Subject: Re: Ideapad S10-3 rfkill issues with fix
Date: Thu, 30 Jun 2011 00:29:29 +0800
Message-ID: <4E0B52E9.4050804@canonical.com>
References: <BANLkTi=HABawWJL2znCDRAM4MqEHPt9xEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=HABawWJL2znCDRAM4MqEHPt9xEQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Thanks for your report. I have a S10-3 but barely touch the wifi switch.

I know there are two drivers for Broadcom wifi chips. One is b43 which
is fully open and in linux kernel tree. The other is wl comes from
Broadcom with other license agreement and its source code is not fully
open.

I read the wl code and looks like they do not have fully support for
hardware switch. At least I think the driver shall update hw state when
initial.

I heard from my colleague who has and uses an ideapad s12. He told me
that with b43 driver never messes up the hardware switch state but
sometimes it sees APs but can not connect until reboot. The wl driver
sometimes reports wrong hardware switch state but can connect to AP if
'rfkill list' shows fine.

In your mail you did not mention the output of 'rfkill list'. In my
view point this is necessary info that tells us who block the wifi.
I guess the your wifi problem is because one of the wlan rfkill shows
blocked.

In this case I will suggest to use b43 driver which on Ubuntu you need
to disable wl driver (from jockey) and install firmware-b43-installer
package.

What I know is that the fix you suggest is hardly to be accepted
because those ACPI objects is not under VPC2004 and not always available
on ideapads. I have 8 ideapad DSDT but only two with those objects.

I will test the wifi switch on my ideapads again after I back to home
which will be next week and see if I can reproduce the same issue.

On 06/26/2011 06:53 AM, Andrew Lutomirski wrote:
> [linux-acpi cc'd because I don't know how to write to an ACPI field,
> and the fix to this bug probably needs that ability.]
> 
> Hi platform people-
> 
> My nephew's Ideapad S10-3 decided that it didn't want to support
> wireless anymore.  I think it happened when he fiddled with his rfkill
> switch, but I haven't been able to reproduce the problem yet.  This
> seems to be a common bug, and the only known fixes (so far) are to
> boot into Windows and fiddle with the settings or to remove the CMOS
> battery.
> 
> This seems to be related to:
> http://ubuntuforums.org/showthread.php?t=1744402
> https://bugs.meego.com/show_bug.cgi?id=4086
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/730972
> 
> Of course, he doesn't have Windows installed, and I didn't want to
> take apart his laptop.  So I figured out the problem.
> 
> The relevant ACPI fields and functions are (as far as I can tell):
> 
> \FL07: The non-volatile copy of the RF enabled flag
> \_SB.PCI0.LPCB.EC0.WRFS: RF enabled flag
> \GO26: The GPIO line that controls the PHY (not really tested at all)
> \GO28: The RF light, inverted.  This doesn't work without manual
> override on my S10-3 because I don't have bluetooth or 3G, AFAICT.
> 
> \_SB.PCI0.LPCB.EC0.DSLD: Load WRFS from FL07 (on startup)
> \_SB.PCI0.LPCB.EC0.DSSV: Save WRFS to FL07, called from some hotkey
> handler or other
> \_SB.PCI0.LPCB.EC0.DSGO: Commit WRFS to hardware (i.e. \GO26).
> 
> Oddly enough, nothing in the DSDT seems to write WRFS or FL07 except
> to copy FL07 to WRFS.  So triggering the problem might involve
> toggling the switch from inside BIOS or something similar.
> 
> The fix would be (I think) to change ideapad_sync_rfk_state to do this
> (in pseudocode):
> if (!hw_blocked != WRFS) {
>   WRFS = !hw_blocked;
>   DSSV()
>   DSGO()
> }
> 
> I don't plan to send a patch for two reasons:
> 
> 1. I don't know how to write to an ACPI field.  acpi_ns_evaluate can
> read fields, but it can't write them AFAICT.  The ability to write to
> a field would be really nice.  I did it by frobbing the ports by hand.
> 
> 2. My nephew's taking his laptop home tomorrow, so I won't be able to
> test a patch.
> 
> In the mean time, if you are affected by this problem and you really
> don't care how badly you damage your laptop, you could run the
> attached program, passing 1 as a parameter.  Then you should probably
> reboot.  Before you even consider trying that, you should check
> whether the magic hardcoded numbers match your DSDT.  If you don't
> know how to do that, then you probably shouldn't run the program.
> 
> --Andy
> 
> P.S.  Some people with this bug find that their system freezes hard
> when they try and fail to fix it.  I think this is a bug in brcm80211
> in 2.6.38 that's been fixed in brcmsmac in 2.6.39.  But I don't really
> feel like testing that carefully, given that I've already fixed the
> root cause.
