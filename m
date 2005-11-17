From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: How to wait that the machine resume in a script
Date: Thu, 17 Nov 2005 23:24:11 +0100
Message-ID: <20051117222411.GC14597@elf.ucw.cz>
References: <dlf12g$pc0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dlf12g$pc0$1@sea.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Olive <olive.lin-r68uw1Ih06TDnxYzvZI3hw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On St 16-11-05 11:19:33, Olive wrote:
> Hello,
> 
> I just test acpi and it appears to have behave properly. I would like to 
>  know via a script that the machine has been resumed. Something like
> 
> echo -n disk /sys/power/state
> waitresumed
> continue with the script
> 
> The naive solution to wait until "echo -n disk /sys/power/state" returns 
> do not work because it returns too quicly.

Really? It should not... it can not. When machine is suspended, script
can't run...
									Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
