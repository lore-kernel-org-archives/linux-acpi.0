From: Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org>
Subject: Re: kacpid problems
Date: Mon, 8 Nov 2004 03:48:59 +0100
Message-ID: <20041108024859.GA12540@pooh>
References: <3ACA40606221794F80A5670F0AF15F84041AC028@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC028@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

* Yu, Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [2004-11-08 09:58:49 +0800]:

> Could you verify if killing kacpid can make the thing better?
 This just happened to me again. I did /etc/init.d/acpid stop, and it
did, but issuing halt left me with the acpi_power_off called message.
I think some memory corruption may happen in kernel space, or it is just
ACPI failing for some reason.
 If this helps, I can say that this bug happens slowly, first I just
realise that more and more CPU time is being used; say 6% user space and
14% kernel space from looking on a gkrellm display while my system is
completely idle. It goes up to 48% user space and 49% kernel space CPU
usage causing the box to crawl (load also goes up, usually it's ~3.0 -
~5.0). So if I see this happening, I act quickly, logout from GUI, and
issue halt from console; still in these cases the box can not halt, but
display acpi_power_off called. Also not that I have this for a long
time, if memory serves me right, then I have this with all 2.6.x
versions and with late 2.4.x versions as well.
 Let's wait on 'dev_zero' if s/he has the very same symptoms or not.
Also if I can do anything, say running a modified acpid which logs an
extra amount of debug log, please tell me. Otherwise I can not directly
reproduce this problem. :-(

Cheers,
Laszlo



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
