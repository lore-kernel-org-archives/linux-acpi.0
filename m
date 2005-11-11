From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: vbetool on pure AMD64 system
Date: Fri, 11 Nov 2005 11:33:15 +0100
Message-ID: <20051111103315.GB27805@elf.ucw.cz>
References: <200511092342.40477.hugelmopf@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200511092342.40477.hugelmopf-S0/GAf8tV78@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> due to your work in new kernels, my AMD64-laptop now resumes after an ACPI S3 
> suspend (I can type commands and they get executed) :-). Thanks a lot.
> 
> But the LCD stays black. So I read about the various options to reinitialize 
> the VGA, which were:
> 1. kernel boot options: acpi=s3_sleep, acpi=s3_mode, pci=routeirq. I tried 
> each one of them, LCD still stays black.
> 2. Using the vbetool to save/restore the state of the VGA.
> 
> Here is the problem: I didn't find an AMD64 version of vbetool (using Debian 
> testing AMD64), so I forced the i386 package and manually met its 32bit 
> dependencies. It does run, and the "vgastate off" option does disable the 
> LCD. But saving and restoring the state, I get the following error:
> 
> # vbetool vbestate save > /tmp/save
> Can't get video state buffer size (vm86 failure)
> Get video state buffer size failed
> Can't save video state (vm86 failure)
> Save video state failed

vm86 is unsupported on x86-64. Something like qemu will be required
:-(.
								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
