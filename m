From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Mon, 07 Feb 2005 15:36:45 +0100
Message-ID: <42077CFD.7030607@gmx.net>
References: <e796392205020221387d4d8562@mail.gmail.com>  <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>  <20050203225410.GB1110@elf.ucw.cz>  <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>  <1107485504.5727.35.camel@desktop.cunninghams>  <9e4733910502032318460f2c0c@mail.gmail.com>  <20050204074454.GB1086@elf.ucw.cz>  <9e473391050204093837bc50d3@mail.gmail.com>  <20050205093550.GC1158@elf.ucw.cz> <1107695583.14847.167.camel@localhost.localdomain> <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu> <42077AC4.5030103@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <42077AC4.5030103-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paulo Marques <pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>
Cc: Adam Sulmicki <adam-VEv2qz67h9X2fBVCVOL8/A@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li-Ta Lo <ollie-YOWKrPYUwWM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Paulo Marques schrieb:
> Adam Sulmicki wrote:
> 
>>
>> hi all,
>>     I would like point to work done by Li-Ta Lo.
>>
>>     It allows you to completely initalize the VGA BIOS w/out using
>>     PC BIOS at all.
>>
>>    
>> http://www.clustermatic.org/pipermail/linuxbios/2005-January/010236.html
>>     unforunatelly the information the web is somewhat sparse, but
>>     you can get more info by following the archive of the
>>     thread (which head I listed above) and perhaps by posting to
>>     linuxbios mailing list (Ollie, is somewhat buy those days with his
>>     new baby).
> 
> 
> I did some work on reducing the core x86 emulation code (and have my
> name mentioned in that thread for it). The code size went from 59kB to
> 38kB. This does not include emulation of BIOS functions or hardware
> (like the standard PC timer).
> 
> It seems to me that x86 emulation in the kernel is the way to go because:
> 
> [...]
> 
> 3 - it's always there and can be executed at *any* time: booting,
> returning from suspend, etc. Also it would allow the VESA framebuffer
> driver to change graphics mode at any time (for instance).

OK, and what would force you to do the above in the kernel? If the code
lives in initramfs, it can be called very early, too.


And how many competing implementations of video helpers/emulation code
do we have now?

- scitechsoft emu
- linuxbios emu
- etc. (I surely forgot some)


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
