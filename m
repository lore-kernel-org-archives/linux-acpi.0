From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: RFC 0/4: make ACPI interpret safe for suspend/resume
Date: Thu, 20 Jan 2005 17:26:47 +0800
Message-ID: <1106213207.16186.10.camel@sli10-desk.sh.intel.com>
References: <1106104620.12957.270.camel@sli10-desk.sh.intel.com>
	 <20050119101858.GE25623@elf.ucw.cz>
	 <1106184495.13181.68.camel@sli10-desk.sh.intel.com>
	 <20050120091242.GB1452@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050120091242.GB1452-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-01-20 at 17:12, Pavel Machek wrote:
> Hi!
> 
> > > [Or perhaps you want this variable to be acpi-local?]
> > For the memory allocating issue and semaphore issue, we actually can not
> > use the new system state, we can just do:
> > if (in_atomic() || in_interrupt())
> > 	kmalloc(.., GFP_ATOMIC)
> > But this possibly will mask some real runtime errors, so we want to add
> > a new system state to make suspend/resume work and not break normal
> > process. But If new system state is a bad idea, we can make it
> > acpi-local.
> 
> Actually, I do not quite like new system state, but introducing new
> "in_suspend()" macro would certainly be ok. We actually talked about
> that one on linux-pm, just noone got around to implement it.
I rethought the issue and get a new idea (I'll resend it later). Now we
don't require the new system state. But in_suspend is a good idea.

> > > > P.S. Did anybody know why we should freeze all processes for S3 and
> > > > S4BIOS? I checked FreeBSD code, it doesn't. I know it's safer, but if
> > > > all device drivers can freeze request to them, it's possibly not
> > > > required to me.
> > > 
> > > Freezing all processes should not be required. 
> > How about just make suspend/resume task as a highest priority task with
> > FIFO scheduler policy? 
> 
> That might do the trick for S3,
What I like it is a) it speeds up freeze process in a system with many
tasks, b) easy to move to SMP case on the future.

>  but not for swsusp. Imagine normal
> process holding some lock you want (for writing image to disk). You
> can run on FIFO scheduler, but then you block on this lock, and
> userspace process gets to run, and gets confused.
Ok, that makes sense. Could we split S3 from swsusp? That is S3 doesn't
use freeze_process.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
