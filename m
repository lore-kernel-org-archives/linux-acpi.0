From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: [2.6.0-test5-mm1] Suspend to RAM problems
Date: Thu, 11 Sep 2003 08:54:31 -0700 (PDT)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.33.0309110852020.984-100000@localhost.localdomain>
References: <20030911124530.GA7695@rootdir.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030911124530.GA7695-YJlxJerscEeELgA04lAiVw@public.gmane.org>
To: Claas Langbehn <claas-YJlxJerscEeELgA04lAiVw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew de Quincey <adq-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> [...]
>   CC      drivers/acpi/sleep/proc.o
>   drivers/acpi/sleep/proc.c: In function `acpi_system_write_sleep':
>   drivers/acpi/sleep/proc.c:72: error: void value not ignored as it
>   ought to be
>   make[3]: *** [drivers/acpi/sleep/proc.o] Error 1
>   make[2]: *** [drivers/acpi/sleep] Error 2
>   make[1]: *** [drivers/acpi] Error 2
>   make: *** [drivers] Error 2
> 
> 
> Is there an incremental patch from -pm1 to -pm2?
> I would apply it to -test5-mm1 then

Patch below. Sorry about that.


	Pat

diff -Nru a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
--- a/drivers/acpi/sleep/proc.c	Thu Sep 11 08:54:01 2003
+++ b/drivers/acpi/sleep/proc.c	Thu Sep 11 08:54:01 2003
@@ -69,7 +69,7 @@
 	state = simple_strtoul(str, NULL, 0);
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state == 4) {
-		error = software_suspend();
+		software_suspend();
 		goto Done;
 	}
 #endif
