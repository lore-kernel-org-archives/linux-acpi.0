From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [2.6 patch] drivers/acpi: #ifdef unused functions away
Date: 11 Nov 2004 14:17:48 -0500
Message-ID: <1100200668.5517.707.camel@d845pe>
References: <20041106114844.GK1295@stusta.de>
	 <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de>
	 <418D403E.30608@conectiva.com.br> <1099933263.13831.9547.camel@d845pe>
	 <20041110012134.GB4089@stusta.de>
	 <20041111151727.GB1108@parcelfarce.linux.theplanet.co.uk>
	 <20041111153650.GD8417@stusta.de>
	 <20041111154017.GC1108@parcelfarce.linux.theplanet.co.uk>
	 <20041111154656.GE8417@stusta.de>
	 <20041111160842.GD1108@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041111160842.GD1108-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>, Arnaldo Carvalho de Melo <acme-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-11-11 at 11:08, Matthew Wilcox wrote:
> On Thu, Nov 11, 2004 at 04:46:56PM +0100, Adrian Bunk wrote:

> > If yes, I will correct the acpi_remove_gpe_block case (it's only
> this
> > one function?) as soon as his tree appears in the next -mm.
> 
> acpi_remove_gpe_block and acpi_install_gpe_block.

No problem, both of these patches are on my list for today and I'll fix
this minor conflict.

thanks,
-Len





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
