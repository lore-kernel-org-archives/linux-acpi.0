From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [2.6 patch] drivers/acpi: #ifdef unused functions away
Date: Thu, 11 Nov 2004 16:46:56 +0100
Message-ID: <20041111154656.GE8417@stusta.de>
References: <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de> <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de> <418D403E.30608@conectiva.com.br> <1099933263.13831.9547.camel@d845pe> <20041110012134.GB4089@stusta.de> <20041111151727.GB1108@parcelfarce.linux.theplanet.co.uk> <20041111153650.GD8417@stusta.de> <20041111154017.GC1108@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041111154017.GC1108-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
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
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnaldo Carvalho de Melo <acme-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 11, 2004 at 03:40:17PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 11, 2004 at 04:36:50PM +0100, Adrian Bunk wrote:
> > On Thu, Nov 11, 2004 at 03:17:27PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 10, 2004 at 02:21:34AM +0100, Adrian Bunk wrote:
> > > > This patch only #ifdef's completely unused code away - it does not make 
> > > > the many global functions only used inside the file they are defined in 
> > > > static.
> > > 
> > > It also ifdefs out the acpi_install_gpe_handler and acpi_remove_gpe_handler
> > > calls I use in the driver I posted on Sunday.  Please fix this.
> > 
> > ????
> > 
> > My patch doesn't #ifdef these functions away.
> 
> Sorry, acpi_remove_gpe_block, not acpi_remove_gpe_handler:
> 
> @@ -383,6 +398,7 @@
>  acpi_status
>  acpi_remove_gpe_block (
>         acpi_handle                     gpe_device);
> +#endif  /*  ACPI_FUTURE_USAGE  */

I didn't saw your patch on linux-kernel, and although Len has said that 
he'd apply my patches I have yet to hear an answer indicating either 
problems in my patches or that he'd applied them.

Did Len already integrate your driver into his tree?

If yes, I will correct the acpi_remove_gpe_block case (it's only this 
one function?) as soon as his tree appears in the next -mm.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
