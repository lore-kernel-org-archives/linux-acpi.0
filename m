From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Mon, 7 Feb 2005 17:01:05 +0100
Message-ID: <20050207160105.GF8040@elf.ucw.cz>
References: <4202DF7B.2000506@gmx.net> <1107485504.5727.35.camel@desktop.cunninghams> <9e4733910502032318460f2c0c@mail.gmail.com> <20050204074454.GB1086@elf.ucw.cz> <9e473391050204093837bc50d3@mail.gmail.com> <20050205093550.GC1158@elf.ucw.cz> <1107695583.14847.167.camel@localhost.localdomain> <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu> <42077AC4.5030103@grupopie.com> <42077CFD.7030607@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42077CFD.7030607-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Paulo Marques <pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>, Adam Sulmicki <adam-VEv2qz67h9X2fBVCVOL8/A@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li-Ta Lo <ollie-YOWKrPYUwWM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > 3 - it's always there and can be executed at *any* time: booting,
> > returning from suspend, etc. Also it would allow the VESA framebuffer
> > driver to change graphics mode at any time (for instance).
> 
> OK, and what would force you to do the above in the kernel? If the code
> lives in initramfs, it can be called very early, too.

It will be easier to debug in kernel than in initramfs, for
one. Kernel code is bad enough, but initramfs running while kernel is
not even initialized is going to be even more "fun".
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
