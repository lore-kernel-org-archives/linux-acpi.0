From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: S3 on Asus M6R
Date: Mon, 21 Mar 2005 17:29:20 +0100
Message-ID: <423EF660.7010906@gmx.net>
References: <20050321135401.GC30293@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050321135401.GC30293-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

[forgot the CC:]
Jan Kasprzak schrieb:
> 	Hi all,
> 
> 	I have an Asus M6R laptop (http://www.fi.muni.cz/~kas/m6r/).
> I have tried to use ACPI S3 suspend-to-ram, but it does not work for me:
> 
> - usually the system either immediately resumes and locks up
> 	after "echo 3 > /proc/acpi/sleep", or it or powers itself down
> 	and does a cold boot when I push the power button. I have found
> 	that the lm_sensors package is what causes the problem (altough	
> 	I have no idea why).
> 
> - without lm_sensors enabled (chkconfig lm_sensors off), I can suspend
> 	my system (the power LED starts blinking, which means the system
> 	is suspended to RAM). But I cannot resume it back - after hitting
> 	the power button the LEDs are on as when the laptop is normally
> 	running, but I get no output on the display, no response to ping, no
> 	response to CapsLock key, etc.
> 
> 	I have read Documentation/power/video.txt, but neither using
> vbetool or boot-radeon utility make any difference for me.
> 
> 	I have tried to use bash -x s3.sh >s3.log 2>s3.err, where s3.sh
> is as follows:
> 
> #!/bin/bash
> chvt 1
> rmmod ohci-hcd
> rmmod ehci-hcd
> sync
> echo 3 > /proc/acpi/sleep
> sync
> /tmp/boot-radeon
> chvt 7

Can we see your kernel command line? Do you use any framebuffer? Does
it work if you boot with init=/bin/bash?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
