From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACER 632 notebook reboots instead of poweroff
Date: Mon, 1 Nov 2004 13:50:34 +0100
Message-ID: <20041101125034.GA32347@atrey.karlin.mff.cuni.cz>
References: <20041026194029.GA10954@pooh> <20041027141833.GC8443@zimen.sk> <20041031231945.GA6909@elf.ucw.cz> <16774.358.944292.65501@aber.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16774.358.944292.65501-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Cc: mizu <michal-VaXaUECoPuY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

>  > >   the same problem is with my ACER 632 too.
>  > > 
>  > >   I've tried disable wakeup devices /proc/acpi/wakeup, but with no
>  > > success.
>  > 
>  > What happens with acpi=off?
>  > 
>  > I have evo n620c here which has similar symptoms, and has another
>  > funny set of symptoms with acpi=off...
>  > 
> 
> I have exactly the same problem with my ACER TM 636.  Will try with
> acpi=off asap and report.
> 
> Do you also have funny thermal and battery readings when running on
> batteries?

Thermal seems to more or less work until I do swsusp; battery reading
seems to be okay. evo is really different beast from acer...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
