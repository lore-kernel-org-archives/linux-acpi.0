From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: Gateway 200x - trouble supplying ECDT table
Date: Mon, 22 Dec 2003 11:51:19 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031222115119.10c88a18.greg@morningdave.org>
References: <20031222101055.7d0c9c71.greg@morningdave.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031222101055.7d0c9c71.greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello again,

    I've made a bit of progress on this, but am still a bit puzzled.
 
    It turns out that grub.conf does not require the double-slash when specifying the path to the Embedded Controller device. My grub.conf looked like this before:

	title=Gentoo Linux (2.4.23 fake-ecdt)
	root (hd0,5)
	kernel (hd0,5)/boot/linux-2.4.23 root=/dev/hda8 ecdt_fake=0x66:0x62:0x1c:0x01:\\_SB_.PCI0.LPCB.H_EC

dmesg would print the following messages when I got to the fake ECDT stuff:

	ACPI: Faking ECDT
	ACPI: Could not use ECDT

Now, my grub.conf is:

	title=Gentoo Linux (2.4.23 fake-ecdt)
	root (hd0,5)
	kernel (hd0,5)/boot/linux-2.4.23 root=/dev/hda8 ecdt_fake=0x66:0x62:0x1c:0x01:\_SB_.PCI0.LPCB.H_EC

And dmesg gives me:

ACPI: Faking ECDT
evregion-0345: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0422 [12] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPCB.H_EC._REG] (Node df5e4408), AE_BAD_PARAMETER
ACPI: Could not use ECDT

So, instead of giving up on the fake ECDT immediately, it throws a couple of errors and then gives up. I think that that's progress, as it at least seems to be recognizing my attempt. I'm still not sure why I continue to get AE_BAD_PARAMETER errors, though. Perhaps there is also something wrong with the DSDT? I did notice that /proc/acpi/embeddedcontroller/H_EC/info does not seem to agree with my dsdt, as it appeared that other people's did in the previous email thread about this. Here is the output of cat /proc/acpi/embeddedcontroller/H_EC/info:

	gpe bit:                 0x00
	ports:                   0x08, 0x05
	use global lock:         yes


I have updated the grub.conf and dmesg files and added /proc/acpi/embeddedcontroller/H_EC/info to http://www.morningdave.org/acpi/ to reflect these stunning new developments, in case anyone is really bored and would like to look them over.

Thanks again,
 Greg
  
On Mon, 22 Dec 2003 10:10:55 -0500
Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org> wrote:

> Hello,
> 
>    I know that this has been covered here before, but I have gotten stuck, so I was wondering if someone could give me a nudge in the right direction.
> 
>    I have a Gateway 200x. Apparently, as discussed here previously (http://sourceforge.net/mailarchive/message.php?msg_id=6514510), these machines do not provide an ECDT. I am getting some EmbeddedController errors in dmesg, and do not have battery, button, thermal or ac adapter support. Obviously, it would be nice to resolve this :)
> 
>    I followed the thread above, and noticed that there is a patch for the 2.4.23 kernel that allows you to supply an ECDT as a boot parameter. Sounds like just the thing. I have applied the patch and am sending what I believe to be the correct parameters to the kernel in my grub.conf, but it will not use the faked ECDT. I imagine that I am just doing something stupid, but I can't figure out what it is right now. I have tried a number of different ways of specifying these parameters, but none has worked so far. I've posted some files (DSDT, dmesg, grub.conf and the version of the patch that I applied) at http://www.morningdave.org/acpi/. If someone could look them over and let me know if anything jumps out as obviously wrong, I would really appreciate it. Right now, I'm hopeful that it is just a subtle difference in the syntax for lilo.conf and grub.conf that I am not catching. If you n
 eed any other information, please let me know.
> 
>    Also, if it wouldn't be too much trouble, could someone let me know how one determines the command and data ports that are used by the EmbeddedController? I am using the values that folks seemed to agree on in the previous thread for this machine (0x66 and 0x62, respectively). But my only real justification is that they were mentioned in that thread, and I see those values in the DSDT. I don't really understand how I could have identified them without someone who knows what he is doing providing them first.
> 
>    Thanks,
>    Greg
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
