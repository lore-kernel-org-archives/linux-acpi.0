From: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Re: vbetool on pure AMD64 system
Date: Mon, 14 Nov 2005 12:02:16 -0500
Message-ID: <4378C318.9090105@cfl.rr.com>
References: <200511092342.40477.hugelmopf@web.de> <20051111103315.GB27805@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051111103315.GB27805-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

When you say that vm86 is not supported on x86-64, what do you mean 
exactly?  I'm pretty sure that the hardware supports it, and I don't see 
how the vesa frame buffer Xorg driver works without it.  If the hardware 
supports v86 mode, why wouldn't the kernel?

For the OP: you might check if your bios has an option to repost the 
video bios on S3 resume.  I turned that on in my bios and that fixed 
this problem for me.  You also might try switching consoles after the 
resume, for instance, by pressing ctrl-alt-F1, then ctrl-alt-F7 ( or 
whichever tty the X server is on ) to switch back to X.  That sometimes 
will reset the video state.

Pavel Machek wrote:
> Hi!
> 
>> due to your work in new kernels, my AMD64-laptop now resumes after an ACPI S3 
>> suspend (I can type commands and they get executed) :-). Thanks a lot.
>>
>> But the LCD stays black. So I read about the various options to reinitialize 
>> the VGA, which were:
>> 1. kernel boot options: acpi=s3_sleep, acpi=s3_mode, pci=routeirq. I tried 
>> each one of them, LCD still stays black.
>> 2. Using the vbetool to save/restore the state of the VGA.
>>
>> Here is the problem: I didn't find an AMD64 version of vbetool (using Debian 
>> testing AMD64), so I forced the i386 package and manually met its 32bit 
>> dependencies. It does run, and the "vgastate off" option does disable the 
>> LCD. But saving and restoring the state, I get the following error:
>>
>> # vbetool vbestate save > /tmp/save
>> Can't get video state buffer size (vm86 failure)
>> Get video state buffer size failed
>> Can't save video state (vm86 failure)
>> Save video state failed
> 
> vm86 is unsupported on x86-64. Something like qemu will be required
> :-(.
> 								Pavel



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
