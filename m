From: "Alexander Isacson" <alexander-O4oeKNg1Q5OZuzBka8ofvg@public.gmane.org>
Subject: Re: Please, please help me enable a serial port.
Date: Thu, 27 Nov 2003 17:02:21 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <10675.192.176.33.6.1069948941.squirrel@firewall.isacson.dyndns.info>
References: <14650.192.176.33.6.1069920559.squirrel@firewall.isacson.dyndns.info>
    <20031127125449.GZ11694@parcelfarce.linux.theplanet.co.uk>
Reply-To: alexander-O4oeKNg1Q5OZuzBka8ofvg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031127125449.GZ11694-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I added -Iinclude/asm-i386/mach-default to the compile line which made it
compile. But inserting it reported "-1 Invalid module format". The I trie=
d
adding -DKBUILD_NAME and -DKBASE_NAME and then I got "-1 Unknown symbol i=
n
module". The output from dmesg states:

fpi2002: Unknown symbol cli
fpi2002: Unknown symbol sti

So once again I'm stuck.

Thanks for you time and effort.
/Alexander

> On Thu, Nov 27, 2003 at 09:09:19AM +0100, Alexander Isacson wrote:
>> The driver I was using before is called fpi2002 and I found it here:
>> http://linux-tablet-pc.dhs.org/. I attached it below along with the
>> readme. All it does is enable /dev/ttyS0. I'm no kernel programmer so
>> this
>> is like rocket-science to me. I also attached the compilation error I
>> get
>> when trying to recompile the driver for 2.6.0-test10
>
> The problem is with the Makefiles used for this module.  The include
> paths are wrong for 2.6 so it won't work.
>
> here's a command line used to compile something in *my* kernel:
>
>   gcc -Wp,-MD,drivers/block/.floppy.o.d -nostdinc -iwithprefix include
> -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=3D2 -march=3Dk6
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer
> -DKBUILD_BASENAME=3Dfloppy -DKBUILD_MODNAME=3Dfloppy -c -o
> drivers/block/.tmp_floppy.o drivers/block/floppy.c
>
>
>> gcc -O2 -D__KERNEL__ -DMODULE -fomit-frame-pointer
>> -I/usr/src/linux/include -I/usr/src/linux/include/asm -c fpi2002.c -o
>> fpi2002.o
>
> I suspect you need to add -Iinclude/asm-i386/mach-default to this comma=
nd
> line.  It would probably be helpful if you could get the original autho=
r
> to *talk to us* rather than putting up a random page of bitching about
> how ACPI doesn't do what he wants.
>
> --
> "It's not Hollywood.  War is real, war is primarily not about defeat or
> victory, it is about death.  I've seen thousands and thousands of dead
> bodies.
> Do you think I want to have an academic debate on this subject?" -- Rob=
ert
> Fisk
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
