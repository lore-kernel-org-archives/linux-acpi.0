From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Samsung P35, S3, black screen (radeon)
Date: Thu, 03 Feb 2005 13:23:55 +0100
Message-ID: <420217DB.709@gmx.net>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net> <e796392205020221387d4d8562@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <e796392205020221387d4d8562-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nikolaus Filus <nfilus-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Stefan Schweizer schrieb:
> On Thu, 03 Feb 2005 02:46:03 +0100, Carl-Daniel Hailfinger
> <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org> wrote:
> 
>>Please try latest 2.6.11-rc2-bkX and NO additional patches. Make sure you
>>don't compile in radeonfb or atyfb. Vesafb doesn't matter. Xorg version
>>is irrelevant.
>>Kernel commandline should contain
>>video=vesa:off
>>and no other video parameters.
> 
> Are you able to use framebuffer(radeonfb,1024x768) with this
> configuration or do you need to use plain vga-console for it to work?

No.
For a working framebuffer console you would have to perform the steps
my script does *before* the kernel tries to access the framebuffer
console after resume. Since this is not yet possible, you're out of
luck. If
- the vbestate utility was a kernel module or
- the kernel could be told not to access the framebuffer after resume
you could make it work.

The first solution seems to be easier for me because acpi_sleep=s3_bios
already tries to boot the card (and crashes), so fixing it would at
least give you a lockup-free resume with framebuffer console. And
there ist the ACPI video module which may also help there (haven't
checked yet).

To sum it up: What happens if you access graphics functions?
- after resume: black screen, lockup
- after resume and POST: black screen
- after resume, POST and vbestate restore: everything OK

On a side note: Is it possible to set the acpi_sleep variable through
sysfs or procfs? Since the variable is only needed on resume, having
some userspace utility set it if there is a radeon card in the machine
would make it easier for distros to do the right thing (tm).

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
