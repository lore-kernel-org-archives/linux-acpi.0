From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Power button events unavailable after resume
Date: Fri, 29 Oct 2004 17:32:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041029153254.GG5387@message-id.gmane0305.slipkontur.de>
References: <200410121343.31099.barr.156@osu.edu> <20041017202103.GE7476@elf.ucw.cz> <200410181058.43697.barr.156@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200410181058.43697.barr.156-ZbGKxL/pcrQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 18, 2004 at 10:58:36AM -0400, Andrew Barr wrote:

> On Sunday 17 October 2004 04:21 pm, Pavel Machek wrote:
>
> > Try again with vanilla kernel and "platform" powerdown method.
> 
> Thanks for the suggestion. Earlier you suggested turning on ACPI S4 support. 
> This seems to fix my problem. With recent versions of Software Suspend 2, S4 
> support has moved from a compile option to a /proc entry, so it wasn't 
> getting used by default. Adding a script to turn it on fixed my button issue.

BTW: swsusp1 "platform" method is basically the same as swsusp2 "S4" wrt
     powerdown.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
