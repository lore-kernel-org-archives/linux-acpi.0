From: Christopher Gahlon <lists-xMsVY1q4kzvQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI Suspend on Inspiron 1100
Date: Tue, 5 Apr 2005 08:43:08 -0500
Message-ID: <200504050843.08268.lists@gahlon.com>
References: <20050331191931.GA16450@jose.lug.udel.edu> <200504050836.17659.lists@gahlon.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504050836.17659.lists-xMsVY1q4kzvQT0dZR+AlfA@public.gmane.org>
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

On Tuesday 05 April 2005 08:36 am, Christopher Gahlon wrote:
> #!/bin/bash
> echo "Turning off display..."
> vbetool dpms off
> echo "Executing sleep command."
> echo 3 > /proc/acpi/sleep
> echo "Waiting 3 seconds before dpms on command."
> sleep 3
> echo "executing: vbetool dpms on"
> vbetool dpms on
> sleep 3
> echo "executing: vbetool post"
> vbetool post

A quick follow up.  After the post runs you're left looking at the Video Post 
message.

Hit enter and you get your prompt back, or just switch to the VT with X and 
compute away.

If anyone working on ACPI wants information from my boxen (DSTD etc.) shoot 
the list, or me and email and I'll do whatever I can to help improve ACPI on 
Dell's borked implementation...

Thanks for all your hard work!  It's greatly appreciated.

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
