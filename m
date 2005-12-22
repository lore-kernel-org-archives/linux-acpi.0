From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Thu, 22 Dec 2005 12:02:19 +0100
Message-ID: <20051222110219.GB9838@elf.ucw.cz>
References: <43A8F98D.3000704@csstirisano.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43A8F98D.3000704-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jaco Kroon <jacok-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, seife-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi

> I'm having some trouble with suspend/resume on my Toshiba Satellite P10 
> and was wondering whether anybody would be able to assist.
> 
> The omnibook module makes some functionality (like the multimedia keys, 
> temperature readings, LCD and FAN adjustments) available.  It however 
> does not help with suspend/resume at all.
> 
> It seems like the notebook only supports standby and suspend to ram.  It 
> seems to come out of standby almost immediately and never come out of 
> suspend to ram.  Running hibernate-ram -n works fine, but when running 
> it without -n it actually suspends to RAM, hdd spins down, network goes 
> down, CPU fans stop and the power led turns red (instead of the normal 
> blue - this is in accordance with what I've seen with Windows).
> 
> When it's time again to resume however, it just does nothing and I need 
> to power-cycle the machine to get it usable again.

P10... is it that beast with pentium4 and hyperthreading? Dual cpu
fans?

That worked for me. See Doc*/power/video.txt. Yep, that one works with
right config. Get swsusp working, first. Then you can debug s2ram.


							Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
