From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: presario 2500 hangs on resume s3
Date: Thu, 25 Aug 2005 20:24:58 +0200
Message-ID: <20050825182457.GB443@openzaurus.ucw.cz>
References: <1124730128.10429.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1124730128.10429.5.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Antonio Distante <antonio.distante-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Pavel Machek's patch that should play a beep on resume:
> 
>  --- clean/arch/i386/kernel/acpi/wakeup.S	2005-01-22 21:24:51.000000000 +0100
>  +++ linux/arch/i386/kernel/acpi/wakeup.S	2004-12-25 15:51:04.000000000 +0100
....
> 
> I applied it to a 2.6.13-rc5 vanilla kernel and build it without framebuffer
> support. I booted the new kernel with "init=/bin/sh" and then tried to S3. On
> resume system hangs and I can't hear no beep. I hope this helps. Just ask if you
> need some other informations.

Try it with apic disabled and minimal config...

Yep, this is hard to debug. If above does not help, I do not know what to
do...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
