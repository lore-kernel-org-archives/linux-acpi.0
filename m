From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Samsung P35 and S3 suspend
Date: Wed, 15 Dec 2004 18:59:11 +0100
Message-ID: <41C07B6F.70900@gmx.net>
References: <41BFC3AD.5030001@gmx.net> <1103117333.5924.3.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1103117333.5924.3.camel@mhcln03>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>, =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Matthias Hentges schrieb:
> Am Mittwoch, den 15.12.2004, 05:55 +0100 schrieb Carl-Daniel Hailfinger:
> 
>>[...]
>>Every time I resume from S3 everything is dead. Keyboard, network,
>>serial port, you name it. Unloading modules doesn't help. Booting
>>with init=/bin/bash (to avoid loading any modules) doesn't help.
>>Booting a kernel without framebuffer support doesn't help.
>>Applying pci-resume-2.6.9.patch doesn't help. Loading a fixed
>>DSDT doesn't help. Combinations of all of the above don't work
>>either.
>>[...]
>>My current base is 2.6.10-rc3-bk8, but I'm willing to test any
>>2.6.x kernel with any patches and any .config you throw at me.
> 
> 
> I haven't had any luck with resume on any kernel > 2.6.9 so far.
> So, I suggest you try 2.6.9 and apply the patches from here:
> http://www.hentges.net/misc/howtos/samsung_p30_s3.shtml

Do you have any hints what to exclude in the .config? The .config
which was once available in your forum is marked as "deleted
attachment" and cannot be downloaded.

Oh, and once I get S3 working with 2.6.9 I'll do a binary search
to find the changeset that is causing the problems after 2.6.9
and report back.

Thanks,
Carl-Daniel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
