From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Thu, 04 Nov 2004 09:24:29 +0100
Message-ID: <yzo654mowci.fsf@cern.ch>
References: <88056F38E9E48644A0F562A38C64FB60033E4DDC@scsmsx403.amr.corp.intel.com>
	<20041103155217.GH24195@wotan.suse.de> <yzosm7q97q2.fsf@cern.ch>
	<20041103172120.GB18092@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041103172120.GB18092-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org> (Andi Kleen's message of
 "Wed, 3 Nov 2004 18:21:20 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Emmanuel Thom?? <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andi> On Wed, Nov 03, 2004 at 06:13:09PM +0100, ole.rohne-vJEk5272eHo@public.gmane.org wrote:
Andi> I don't think proper point is a big issue anyways. The only
Andi> kernel user that really cares about video state is the console.

>> And as most modern graphics adapters are bus master capable, how do
>> you make sure it is not hanging on the bus request at the moment you
>> re-enable BM arbitration?

Andi> The machine is comming fresh out of suspend. Nobody should be doing
Andi> bus mastering. 

There is absolutely no guarantee that the machine comes "fresh out of
suspend"! Here is my recollection of what the ACPI specs says: The
machine resumes with interrupts and BM disabled, it is the
responsibility of the OS to make sure all devices are "quiescent"
before reenabling interrupts and BM.

Once again I'd lament the fact that most of the device suspend/resume
code is not done from specs, but rather empirically based on overly
forgiving firmware implementations. Specifically, the code seems to
assume the hardware as it comes out of a boot, but there is no such
guarantee.

>> Speaking as someone who's tried extensively to get the "usermode,
>> anytime"-approach to work, what really turned me off was not being
>> able to get the console working.

Andi> When you want to restore a graphics mode in the X server you
Andi> don't have a console anyways, so I don't see the problem here.

If you decide you don't care about the console there is no
problem. But please don't advertise that as fully working S3
suspend/resume.

Andi> early printk to serial or vga if you're in text mode should
Andi> always work.

You mean "should always work" as in "not hanging the machine"?
Maybe...  It certainly doesn't "work" in the sense of displaying text
on the screen.

Ole




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
