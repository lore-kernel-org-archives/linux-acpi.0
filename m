From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Samsung P35, S3, black screen (radeon)
Date: Fri, 04 Feb 2005 10:43:39 +1100
Message-ID: <1107474198.5727.9.camel@desktop.cunninghams>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>
	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	 <4202A972.1070003@gmx.net>  <20050203225410.GB1110@elf.ucw.cz>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050203225410.GB1110-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Fri, 2005-02-04 at 09:54, Pavel Machek wrote:
> Hi!
> 
> > >>Are you able to use framebuffer(radeonfb,1024x768) with this
> > >>configuration or do you need to use plain vga-console for it to work?
> > > 
> > > No.
> > > For a working framebuffer console you would have to perform the steps
> > > my script does *before* the kernel tries to access the framebuffer
> > > console after resume. Since this is not yet possible, you're out of
> > > luck. If
> > > - the vbestate utility was a kernel module or
> > 
> > OK, I managed to track this down further.
> > "vbetool post" should be equivalent to "acpi_sleep=s3_bios", but there
> > are some differences. For me, that's easy to explain: "vbetool post"
> > segfaults because it wants to access parts of the video bios which
> > are no longer available. "acpi_sleep=s3_bios" suffers from the same
> > problem, but it runs in real mode and can't recover :-(
> > 
> > To alleviate that problem, the kernel could run the video bios in
> > vm86 mode (like vbetool does by using lrmi). This would simplify
> > the asm wakeup code and make video POST more reliable.
> > 
> > Pavel, what do you think?
> 
> Well, calling BIOS using vm86 is going to be quite a lot of code. If
> it is self-contained and not too huge, it is probably okay. It should
> help with quite a lot of cards, but who knows...
> 
> Yes, it is probably worth trying.

I'd love to see it too. Pavel, even if you don't want to merge it for a
while, we can always incorporate it in the Suspend2 patches so it gets
some testing. I know I'd try it on my i830 based Omnibook.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
