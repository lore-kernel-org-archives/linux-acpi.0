From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: tg3 ethernet not coming back properly after S3 suspend on Dell M70
Date: Thu, 9 Jun 2005 19:10:38 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575023E30BC@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>> >
>> >I've been trying to get S3 suspend working on my Dell Precision M70
>> >without much success for the past few weeks.  This is all now with
>> >2.6.12-rc6, with Jens Axboe's patch for SATA suspend (as the machine
>> >has a SATA interface and uses ata_piix).
>> > [ ... ]
>> >Any ideas where to start looking for a cause?  I figure fixing the
tg3
>> >issue should help track down the overall problem.
>> >
>> Is the PCI express bridge's config space ok? Particularly, the bus
>> number registers. And can you track down if the tg3 resume routine
>> returns ok?
>
>Hmm.. the config space doesn't look ok to me at all; I've attached the
>before and after suspend lspci -vv output for diffing, because I could
>easily be drawing the wrong conclusions here.  Some things I noticed:
>
>Before suspend:
>
>00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
>Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>ParErr- Stepping- SERR- FastB2B-
>        Bus: primary=3D00, secondary=3D02, subordinate=3D02, =
sec-latency=3D0
>        Memory behind bridge: dcf00000-dcffffff
>
>After resume, we lose the BusMaster flag (not just on this device, but
>on a few others), and the bus numbers and memory ranges change:
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
>ParErr- Stepping- SERR- FastB2B- (lost BusMaster flag?)
>        Bus: primary=3D00, secondary=3D00, subordinate=3D00, =
sec-latency=3D0
>        I/O behind bridge: 00000000-00000fff
>        Memory behind bridge: 00000000-000fffff
>        Prefetchable memory behind bridge: 0000000000000000-
>0000000000000000
>
>The root PCIE port on which the nvidia sits goes through similar
>lossage... no memory range behind the bridge is reported after resume,
>and MSI's are reported as disabled where they were enabled before.
>
>I haven't been able to track down if the tg3 resume function completes
>as of yet; it's hit and miss whether the display gets restored after a
>resume (dpms/vbetool sometimes help, sometimes they don't), and with
>the tg3 module loaded I can only send commands through in bursts...
>will give it another few tries.
Not required testing tg3 driver now. If the bridge is broken, all
devices under it will be broken. Did you enable the PCIE port driver? I
suspect it's the cause, since default PCI resume routine can restore PCI
bridge's config space.

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
