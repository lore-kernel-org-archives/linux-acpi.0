From: Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org>
Subject: Re: kacpid problems
Date: Sat, 6 Nov 2004 03:02:07 +0100
Message-ID: <20041106020207.GA7283@pooh>
References: <418C0EFA.6000001@yahoo.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <418C0EFA.6000001-eZNTXLQAfP4@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

* dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org> [2004-11-06 00:38:34 +0100]:

> When my processor gets too hot, over 85 C it tries to shutdown(S5), but 
> the only thing that happends is that kacpid starts running and runns 
> with 99% CPU usage.
> (taken from top)
> 5 root       7 -10     0    0    0 R  99.0  0.0   0:17.94 kacpid
> 
> Is it someone who knows what is wrong? Is it a bug or is it my hardware 
> that is the problem?
 I have this also, but not always. Also even kacpid shows 99% CPU usage,
as I see gkrellm, it shows that about 45% is spent in kernel space, and
the rest in user space. I say not always because sometimes my machine
goes without any problem even when hot, or bugging when it is not really
hot. Don't know if my 'bug' is really related to yours, but yes, it is
annoying as when this happens I can not shutdown manually even. The last
line I see acpi_poweroff_called (even if I stop the kacpid process
before).
 Is it a laptop or a desktop machine?

Regards,
Laszlo/GCS



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
