From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: gericom notebook reboots instead of poweroff
Date: Tue, 2 Nov 2004 21:32:43 +0100
Message-ID: <20041102203243.GA996@openzaurus.ucw.cz>
References: <20041026194029.GA10954@pooh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041026194029.GA10954@pooh>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

>  I have a Gericom 1st supersonic (PIII 1.2Ghz) laptop, running Debian
> Sarge (up-to-date). I have it since ~2.4.14, and until 2.6.8.1 the
> 'halt' command shut down the machine correctly. Starting with 2.6.8.1-bk1
> it reboots. :( I realize that -bk1 has a big ACPI update, which may be
> the problem IMHO.
>  I have tried to look into existing bugreports, but could not find any
> similar to this on the Kernel Bugzilla nor in the ACPI Bugzilla. All I

Eh? Something very similar happens on acers and evos and probably
more.... See mail archives.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
