From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Wed, 3 Nov 2004 18:21:20 +0100
Message-ID: <20041103172120.GB18092@wotan.suse.de>
References: <88056F38E9E48644A0F562A38C64FB60033E4DDC@scsmsx403.amr.corp.intel.com> <20041103155217.GH24195@wotan.suse.de> <yzosm7q97q2.fsf@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yzosm7q97q2.fsf-vJEk5272eHo@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ole.rohne-vJEk5272eHo@public.gmane.org
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Emmanuel Thom?? <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2004 at 06:13:09PM +0100, ole.rohne-vJEk5272eHo@public.gmane.org wrote:
> Andi> I don't think proper point is a big issue anyways. The only
> Andi> kernel user that really cares about video state is the console.
> 
> And as most modern graphics adapters are bus master capable, how do
> you make sure it is not hanging on the bus request at the moment you
> re-enable BM arbitration?

The machine is comming fresh out of suspend. Nobody should be doing
bus mastering. 
> 
> Speaking as someone who's tried extensively to get the "usermode,
> anytime"-approach to work, what really turned me off was not being
> able to get the console working.

When you want to restore a graphics mode in the X server you don't
have a console anyways, so I don't see the problem here.

earlyprintk to serial or vga if you're in text mode should always work.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
