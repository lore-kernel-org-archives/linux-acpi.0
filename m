From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Samsung P35, S3, black screen (radeon)
Date: Thu, 03 Feb 2005 02:46:03 +0100
Message-ID: <4201825B.2090703@gmx.net>
References: <20050122134205.GA9354@wsc-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050122134205.GA9354-u75qzGzWA6cb1SvskN2V4Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nikolaus Filus <nfilus-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Nikolaus Filus schrieb:
> Hi,
> 
> after having a lot trouble to reproduce the situation described by others, 
> I was finally able to survive a S3 to get a working console. But I'm still
> unable to get the screen on and it stays dark. I tried several permutations
> off all found hints, but no success so far.
> 
> The System: 
>  linux-2.6.10 + resume-finish-split + pci-resume-2.6.9 + pci-resume-old
> 	vesa:off radeonfb:off (fbcon:on)
>  xorg-6.8.0-r3 (gentoo, radeon s3 patch included)

Please try latest 2.6.11-rc2-bkX and NO additional patches. Make sure you
don't compile in radeonfb or atyfb. Vesafb doesn't matter. Xorg version
is irrelevant.
Kernel commandline should contain
video=vesa:off
and no other video parameters.


> I tested with the appended script, with several freezes and always black

Heh. I'm surprised your machine survived that script sometimes.


> screen. MagicSysRq-Boot and PowerOff works most the time, so the kernel
> responds. Another observation was, when starting the vesa X11 for the first
> time, I can see rests of the Samsung Boot logo, which seems to stay
> in memory (maybe a hint for incorrect POST address later by the tools?!).
> 
> Like Mathias Hentges wrote, the vesa X11 crashes after resume.
> Saving VBE state after vbetool post freezes the machine.
> 
> Any hints?!

Yes. See my kernel configuration suggestion above. And use the following
suspend script:

#!/bin/bash
statedir=/root/s3/state
curcons=`fgconsole`
fuser /dev/tty$curcons 2>/dev/null|xargs ps -o comm= -p|grep -q X && chvt 2
cat /dev/vcsa >$statedir/vcsa
sync
echo 3 >/proc/acpi/sleep
sync
vm86_video_post
vbestate restore <$statedir/vbe
cat $statedir/vcsa >/dev/vcsa
rckbd restart
chvt $[curcons%6+1]
chvt $curcons


And be sure to run
vbestate save >$statedir/vbe
one time after bootup *from a text console* while X is running. This file
will never (except a graphics card upgrade) have to be generated again
and simply work.

Notes:
- You will need my patch from last year for vbestate to have a readable
  console font and get reliable resume.
- The "rckbd restart" may be SUSE specific. Simply reload your console
  fonts.
- Make sure to deactivate actions for the power button. You need to
  press it for resume, but the event will be handled again and acpid
  may try to shutdown your system.
- Matthew Garrett was working on a successor for vbestate IIRC, but I
  don't know whether he applied my patch to his new tool.
- The configuration above has survived 20 suspend/resume cycles in a
  row without any glitches. It works from X and from console.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
