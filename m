From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: Re: Samsung P35 and S3 suspend
Date: Wed, 15 Dec 2004 14:28:53 +0100
Message-ID: <1103117333.5924.3.camel@mhcln03>
References: <41BFC3AD.5030001@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41BFC3AD.5030001-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>, Stefan =?ISO-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Mittwoch, den 15.12.2004, 05:55 +0100 schrieb Carl-Daniel Hailfinger:
> Hi,
> 
> after having read what I believe to be all available information
> about getting my Samsung P35 to resume properly from S3, having
> tried dozens of patches, recompiled the kernel at least 20 times,
> I hope that someone can shed some light on my failure to resume.
> 
> Every time I resume from S3 everything is dead. Keyboard, network,
> serial port, you name it. Unloading modules doesn't help. Booting
> with init=/bin/bash (to avoid loading any modules) doesn't help.
> Booting a kernel without framebuffer support doesn't help.
> Applying pci-resume-2.6.9.patch doesn't help. Loading a fixed
> DSDT doesn't help. Combinations of all of the above don't work
> either.
> 
> Right now I would be happy if at least the keyboard or network
> would work, giving me a chance to shutdown the machine properly.
> 
> I'm not demanding a howto or something like that, only a few
> hints where to look for improvement. For example, I could not
> find the "old style resume" patch Oliver mentioned.
> 
> My current base is 2.6.10-rc3-bk8, but I'm willing to test any
> 2.6.x kernel with any patches and any .config you throw at me.

I haven't had any luck with resume on any kernel > 2.6.9 so far.
So, I suggest you try 2.6.9 and apply the patches from here:
http://www.hentges.net/misc/howtos/samsung_p30_s3.shtml

HTH

-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
