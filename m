From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Wed, 3 Nov 2004 16:52:17 +0100
Message-ID: <20041103155217.GH24195@wotan.suse.de>
References: <88056F38E9E48644A0F562A38C64FB60033E4DDC@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60033E4DDC-exJ48ZlmiLpQxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ole.rohne-vJEk5272eHo@public.gmane.org, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Emmanuel Thom?? <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2004 at 06:45:53AM -0800, Pallipadi, Venkatesh wrote:
> Other options here are:
> - to have the usermode emulator and call it from 
> Proper point in kernel using call_usermodehelper().

I don't think proper point is a big issue anyways. The 
only kernel user that really cares about video state is the
console.

But you would need to be careful to not schedule
the X server or a DRI client before it has run.
You would need a kind of "single process" mode.

I suspect doing it in assembly early would be cleaner.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
