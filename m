From: Christopher Gahlon <lists-xMsVY1q4kzvQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI Suspend on Inspiron 1100
Date: Tue, 5 Apr 2005 08:36:17 -0500
Message-ID: <200504050836.17659.lists@gahlon.com>
References: <20050331191931.GA16450@jose.lug.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050331191931.GA16450-0dTycEvvTfOQTptMt33A/4dd74u8MsAO@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 31 March 2005 01:19 pm, ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org wrote:
> I have some questions on ACPI suspend on a Dell Inspiron 1100.  I have
> tried two different kernels: 2.6.8 (as comes with Debian sarge) and a
> 2.6.11.6 (which I built myself).  This is with BIOS A31.

I'm running the A31 Bios as well.  My fan actually shuts off once in a while 
now too! Woohoo!  Now if Dell would just address REAL problems...

> 1) 2.6.8: putting the machine to sleep via proc/sysfs works, but the
> laptop immediately wakes back up.  It looks almost like some device is
> not going to sleep, generating activity, and then causing a wakeup.

If you have USB drivers as modules, unload them and this should go away.  I 
had to with the 2.6.8 series and had to remove the monolithic USB drivers.
(I had to force module unloading, but i never had problems as a result)

> 2) 2.6.11.6: putting the machine to sleep via proc/sysfs works, but
> the machine never fully wakes up.  I can still login to a console and
> halt the laptop, but the display won't turn back on.  Switching
> to/from X11 VT doesn't seem to help.

I'm using a gentoo kernel: 2.6.11-gentoo-r2
Gentoo does patch their kernel, but I don't think they touch the ACPI code.  
I'm not 100% sure though...

I have S3 working on my Inspiron 1100 using vbetool and this script.
You have to do it from a text terminal.  Using it inside of X borks the system 
when you resume. (The usuall, keyboard/video don't work but you can ssh in 
and shut it down...)

I've found that the sleep commands are necessary.  I haven't experimented with 
shortening them.  YMMV.

#!/bin/bash
echo "Turning off display..."
vbetool dpms off
echo "Executing sleep command."
echo 3 > /proc/acpi/sleep
echo "Waiting 3 seconds before dpms on command."
sleep 3
echo "executing: vbetool dpms on"
vbetool dpms on
sleep 3
echo "executing: vbetool post"
vbetool post


-- 
Christopher Gahlon

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
     -Benjamin Franklin, Historical Review of Pennsylvania.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
