From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Fri, 4 Feb 2005 15:29:45 -0500
Message-ID: <9e473391050204122942da8aa7@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <200502041010.13220.jbarnes@engr.sgi.com>
Reply-To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502041010.13220.jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jesse Barnes <jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 4 Feb 2005 10:10:12 -0800, Jesse Barnes <jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org> wrote:
> Jon does your emulator sit on top of the new legacy I/O and memory APIs?  I
> added them for this very reason, though atm only ia64 supports them.  There's
> documentation in Documentation/filesystems/sysfs-pci.txt if you want to take

The link I am posting is to the original scitech code which is free to
use. I have a bunch of versions on my local machine but none are up to
using all of the new sysfs APIs. Looking at the sysfs calls it is
simple to convert the reset app to use them. The reset app is already
trapping the io/out instructions.

Instead I have been concentrating on feeding new babies and getting
the last two pieces of kernel support in. We still need a solution for
VGA routing (I posted on but the design needs work) and making the
initial user space call out.

I would prefer to use hotplug for the user space call out but when I
do I run into the framebuffer and DRM drivers. This having multiple
drivers for the same piece of hardware is a pain. So hotplug on the
standard device is not an option.

Other options would be to directly call_usermodehelper() or create a
temporary class device for each VGA card as it is found. The temp VGA
device would trigger the reset app. They would be temp since there may
be multiple ones.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
