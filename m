From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: [RFC] Reliable video POSTing on resume
Date: Fri, 11 Feb 2005 02:47:27 +0100
Message-ID: <420C0EAF.4000606@gmx.net>
References: <4202DF7B.2000506@gmx.net>	 <1107485504.5727.35.camel@desktop.cunninghams>	 <9e4733910502032318460f2c0c@mail.gmail.com>	 <20050204074454.GB1086@elf.ucw.cz>	 <9e473391050204093837bc50d3@mail.gmail.com>	 <20050205093550.GC1158@elf.ucw.cz>	 <1107695583.14847.167.camel@localhost.localdomain>	 <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu>	 <42077AC4.5030103@grupopie.com> <42077CFD.7030607@gmx.net>	 <20050207160105.GF8040@elf.ucw.cz> <1107793204.2930.18.camel@logarithm.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1107793204.2930.18.camel-fiEEBCSFsUl2jBC2uHMcnu1ftBKYq+Ku@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li-Ta Lo <ollie-YOWKrPYUwWM@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Paulo Marques <pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>, Adam Sulmicki <adam-VEv2qz67h9X2fBVCVOL8/A@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kendall Bennett <kendallb-uto6oM0aG36m1FQbPH9wZw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Li-Ta Lo schrieb:
> On Mon, 2005-02-07 at 09:01, Pavel Machek wrote:
> 
>>>>3 - it's always there and can be executed at *any* time: booting,
>>>>returning from suspend, etc. Also it would allow the VESA framebuffer
>>>>driver to change graphics mode at any time (for instance).
>>>
>>>OK, and what would force you to do the above in the kernel? If the code
>>>lives in initramfs, it can be called very early, too.
>>
>>It will be easier to debug in kernel than in initramfs, for
>>one. Kernel code is bad enough, but initramfs running while kernel is
>>not even initialized is going to be even more "fun".
> 
> One good thing about the emulator is it is very portable. There is
> virtually no stdlib dependency. We can freely move it between user
> and kernel space. When integrating the emulator into LinuxBIOS,
> we first tried to use it as an user space program and then "port" it
> into "kernel" space. The porting was done in a few days and the most
> of the time was spent fixing LinuxBIOS itself than doing any "porting".
> Actually, the same emulator source were used in both user and kernel
> space as a kind of regression test.

Do you have a kernel patch against a recent kernel? I'd like to try
the in-kernel emulator. A userspace variant would also be fine, provided
it solves the "VGA BIOS calls normal BIOS" type of problem I'm seeing
on my machine (Samsung P35 laptop with ATI Radeon Mobility 9700).


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
