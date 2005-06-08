From: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: tg3 ethernet not coming back properly after S3 suspend on Dell M70
Date: Wed, 8 Jun 2005 14:26:57 -0700
Message-ID: <9540d01050608142633b0e15c@mail.gmail.com>
Reply-To: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I've been trying to get S3 suspend working on my Dell Precision M70
without much success for the past few weeks.  This is all now with
2.6.12-rc6, with Jens Axboe's patch for SATA suspend (as the machine
has a SATA interface and uses ata_piix).

I tried Shaohua's S3 "test tool" and gave it a shot -- with it I'm
able to go through a suspend/resume cycle with no problems.  Without
it, the machine locks up after unsuspend (after we're back in kernel
code) with the nvidia driver loaded, and is otherwise unstable without
the nvidia driver loaded.  In particular, the ethernet device is
completely screwed after coming out of unsuspend.  lspci shows (after
unsuspend):

02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751
Gigabit Ethernet PCI Express (rev ff) (prog-if ff)
        !!! Unknown header type 7f

and lspci -x reports the entire config space coming back as 0xff.

This does not happen with the fake-S3 test patch.  The device tree, as
reported by lspci -t for this device looks like:

-[0000:00]-+-1c.0-[0000:02]----00.0

00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 03)

The other device that's not coming up right is the video hardware, and
it's on the "PCI Express Root Port".  All the PCI (not PCI Express)
devices going through a PCI bridge seem to come back through fine, as
do USB and other bits.  Just the two devices on the PCI Express bus
seem screwed up post-resume, though lspci is able to read the nvidia
device's config space post-resume.

Any ideas where to start looking for a cause?  I figure fixing the tg3
issue should help track down the overall problem.

Thanks,
    - Vlad


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
