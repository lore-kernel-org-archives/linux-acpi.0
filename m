From: Maier Gerfried <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Subject: Re: ACPI 20020829 and kernel 2.4.19-4GB #1 Fri Sep 13 13:14:56 UTC 2002 i686 on Gericom Supersonic M6T
Date: Fri, 22 Nov 2002 12:33:18 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037964798.3dde15fe382fb@sbox.tugraz.at>
References: <3DDE91EC.2090207@sec.co.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DDE91EC.2090207-db4prxYhZ5Fhl2p70BpVqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mariuso-QShcZ35DvxU@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Marius!

Zitiere Marius Oancea <mariuso-db4prxYhZ5Fhl2p70BpVqQ@public.gmane.org>:

> Hi, I have an Gericom M6T and I just installed SuSE 8.1.
> 
> If u add pci=acpi to the bootparam, acpi is working nearly acceptable :
>  - acpi events are not raported anymore
>  - when i start /stop acpid (at the time of acpi modules insertion) the
> complete system crash

... completely the same issue on my Suse 8.1 (Acer Travelmate Notebook)

> I tried  to compile a original 2.4.19  kernel (from kernel.org) and 
> patch this kernel with acpi-20020918-2.4.19.diff.

Why didn't you try a more recent kernel+acpi-patch?

I'm now using 2.4.20-rc1 with the recent acpi-patch and ererything works fine. 
(I first installed the Suse-kernel-sources and then copied the .config-file 
into the new 2.4.20-rc1-tree - make menuconfig - make bzimage and so on.)

I had no major problems with this.

> After that, acpi is working very well, but ... I don't have the exotic 
> features of SuSE anymore (PCMCIA driver is not the last one and is not 
> stable enough, SuSE hardware autodetection is not working too .... , 
> grub, orinocco wireless card neither).

Did you configure the kernel yourself? The Suse Kernel has the option "prompt 
for development options" (One of the first options when you do make menuconfig 
or make xconfig - Unfortunately I do not know the exact name any more) enabled. 
This allows you to select drivers/modules marked as "(EXPERIMENTAL)", eg. 
FireWire, Bluetooth, I thonk WLan too, and so on.

> So, hopefully  somebody in this list has a patch for the SuSE 8.1 
> kernel. The most stable acpi for Gericom Supersonic M6T is
> acpi-20020918.
> 
> Should I address this question to another list ?
> 
> If yes, on wich list ?
> 
>     With all my respect
>         Marius OANCEA

If you need some help updating the kernel, please feel free and mail me 
directly.

Gerfried 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
