From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Samsung P35
Date: Fri, 12 Nov 2004 16:01:48 +0100
Message-ID: <20041112150148.GA1031@elf.ucw.cz>
References: <41948E80.5030207@helios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41948E80.5030207-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> since two weeks I am owner of a Samsung P35 XVM 1600. I succeeded to 
> install debian sarge with kernel 2.6.8 only by providing nolacpi as 
> kernel parameter. I thought this would switch off acpi but I got several 
> ACPI messages on boot time like:

nolacpi is typo. You want acpi=off?

> My problem:
> Suspend does not work. Neither Fn + Sleep Key nor echo mem|disk > 
> /sys/.../state
> 
> mem does something - display is switching to text mode but returns 
> immediately.

Do you have swap file and kernel command line set up correctly? dmesg
after attempt?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
