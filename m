From: Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org>
Subject: Re: kacpid problems
Date: Mon, 8 Nov 2004 04:18:22 +0100
Message-ID: <20041108031822.GA13253@pooh>
References: <3ACA40606221794F80A5670F0AF15F84041AC028@pdsmsx403> <20041108024859.GA12540@pooh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041108024859.GA12540@pooh>
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

* Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org> [2004-11-08 03:48:59 +0100]:

> > Could you verify if killing kacpid can make the thing better?
>  This just happened to me again. I did /etc/init.d/acpid stop, and it
> did, but issuing halt left me with the acpi_power_off called message.
> I think some memory corruption may happen in kernel space, or it is just
> ACPI failing for some reason.
 OK, just happened again, so update: I did /etc/init.d/acpid stop; but
as I saw CPU usage went to half kernel space, half user space. But(!)
now I can confirm that kacpid with pid 5 stuck in a D state, tried to do
something, but the box was so crawling that I chose to pull out the cord
instead.

HTH,
Laszlo



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
