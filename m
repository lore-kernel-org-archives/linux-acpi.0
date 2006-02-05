From: Pavel Troller <patrol@sinus.cz>
Subject: Re: Question about AthlonXP on nforce 2 : C2-C3 states
Date: Sun, 5 Feb 2006 16:42:45 +0100
Message-ID: <20060205154245.GA31112@tangens.sinus.cz>
References: <20060205152120.1688bd7b.arthur.huillet@agoctrl.org> <20060205143742.GA20815@tangens.sinus.cz> <20060205160750.4a1c1b3e.arthur.huillet@agoctrl.org>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:6599 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1750964AbWBEPmt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2006 10:42:49 -0500
Content-Disposition: inline
In-Reply-To: <20060205160750.4a1c1b3e.arthur.huillet@agoctrl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arthur Huillet <arthur.huillet@agoctrl.org>
Cc: Pavel Troller <patrol@sinus.cz>, linux-acpi@vger.kernel.org

> Hi,
> 
> > If you will see more than 100 in the first line and more than 1000 in the second one, your
> > Cx states are blocked by BIOS.
> 
> I'm getting 101 and 1001 indeed : 
> P_LVL2_LAT:       101
> P_LVL3_LAT:       1001
> 
> Is there no way to tell my BIOS to unblock those states ? I mean, are they blocked for stability
> purposes (in what case I assume this is a workaround for a bug in the chipset/CPU/whatever), or are
> they just not enabled for an obscure reason ?
  Wellcome to the large family of owners of boards/computers with broken ACPI
BIOSes (or hardware bugs ???)...
  I didn't find any way how to unblock them. Nobody but BIOS authors know, why
they are blocked, but it seems to be a common practice of current ACPI BIOS
writers :-(. 
  I have the same problem with ALL of my machines, including my notebook
(Clevo D610SU). None of them supports native Linux ACPI because of this.
On Athlon boards, I'm successfully using athcool
( http://members.jcom.home.ne.jp/jacobi/linux/files/athcool-0.3.11.tar.gz ),
it substantially decreases CPU temperature even with C1 due to enabling
"HALT Command detection" bit on the NB. On some systems, I've patched kernel
to use C2 and C3, which, together with athcool, seems to have even better
effect:
root@co:/home/tv/il2sturmovikfb# cat /proc/acpi/processor/CPU1/power
active state:            C2
max_cstate:              C8
bus master activity:     000007ff
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[000] usage[17803710] duration[00000000000000000000]
   *C2:                  type[C2] promotion[--] demotion[C1] latency[101] usage[116616196] duration[00000000277739332216]
You can see 101 in latency field, which is normally prohibited :-)
C3 is not used because of lack of bus mastering capability
(it's on another of my boards, MSI KT6 Delta).
HOWEVER, as many ACPI people already said several times, IT MAY BE RISKY AND
you CAN severely DAMAGE YOUR DATA when experimenting with this. So it's just
on you, how do you decide.
  With regards, Pavel Troller
