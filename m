From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Subject: Samsung P35 and S3 suspend
Date: Wed, 15 Dec 2004 05:55:09 +0100
Message-ID: <41BFC3AD.5030001@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
Cc: Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>, Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>, =?UTF-8?B?U3RlZmFuIETDtnNpbmdlcg==?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

after having read what I believe to be all available information
about getting my Samsung P35 to resume properly from S3, having
tried dozens of patches, recompiled the kernel at least 20 times,
I hope that someone can shed some light on my failure to resume.

Every time I resume from S3 everything is dead. Keyboard, network,
serial port, you name it. Unloading modules doesn't help. Booting
with init=/bin/bash (to avoid loading any modules) doesn't help.
Booting a kernel without framebuffer support doesn't help.
Applying pci-resume-2.6.9.patch doesn't help. Loading a fixed
DSDT doesn't help. Combinations of all of the above don't work
either.

Right now I would be happy if at least the keyboard or network
would work, giving me a chance to shutdown the machine properly.

I'm not demanding a howto or something like that, only a few
hints where to look for improvement. For example, I could not
find the "old style resume" patch Oliver mentioned.

My current base is 2.6.10-rc3-bk8, but I'm willing to test any
2.6.x kernel with any patches and any .config you throw at me.

Thanks for your help!
Carl-Daniel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
