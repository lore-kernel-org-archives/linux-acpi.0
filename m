From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: /proc/acpi/alarm -- does it work or not?
Date: Wed, 28 Dec 2005 19:24:32 +0100
Message-ID: <20051228182431.GA26207@hell.org.pl>
References: <20051226204305.GA2028@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051226204305.GA2028-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ronald.mythtv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Pavel Machek:
[...]

Last time I checked (2.6.15-rc[45]) it worked fine -- I use it routinely
for S3 stress-testing (speaking of which, my machine has just failed to
resume after some 20 days of uptime and > 150 S3 cycles).

> Here are my attempts: [Commands were typed one-after-another where it
> makes sense, and I left machine suspended for long enough -- timer
> should have expired]
> 
> root@amd:/proc/acpi# cat alarm
> 2005-12-00 01:03:24
> root@amd:/proc/acpi# echo '0-0-0 22:35:00' > alarm

You got it mixed up. It's either
"2005-12-28 19:50:00" for absolute or
"+0000-00-00 00:01:00" for relative.

RTC IRQ counter is incremented whenever the timer triggers, regardless of
whether the system is up or down (my system, at least).

HTH, best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
