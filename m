From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Dell D600: teaching radeonfb how to wake up...
Date: Mon, 24 Nov 2003 12:29:47 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069637387.723.112.camel@gaston>
References: <20031119180119.GB22307@tate.loria.fr>
	 <20031120111315.GB432@openzaurus.ucw.cz> <1069370504.705.32.camel@gaston>
	 <20031120234708.GA431@elf.ucw.cz>  <20031121155010.C19564@loria2.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031121155010.C19564-SAjW485I7Qt98t58zOhiHA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emmanuel Thome <Emmanuel.Thome+acpi-/zGXu1G9BXs@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Certainly, it would be of great value, even if the finally chosen path is
> to do the POST code. If I recall recent discussions about this on the
> list, a couple of folks seem to prefer this ``hard way'' than the real
> mode/int10 stuff, for reasons I understand.
>
> Still, as you (Pavel) have yourself remarked, video chips suffering from
> this unconfigured wake-up disease are tantamount. It could even be the
> case of _most_ chips. If an interface for calling real mode stuff makes
> it possible to cure, say half of these graphics cards for x86 laptops,
> then that's not bad at all.
> 
> OTOH, even if the windows ati drivers do not fully repost the chip, the
> MacOS drivers possibly _do_ such a thing, don't they ? Or do they really
> get by using D2 state always ? Ben ? 

ATI drivers on Mac do re-POST most chips except the few earlier laptops
and iMacs which only needed D2 mode. All "desktops" cards need re-POST
(Desktops Macs will shut down the power to the PCI/AGP slots when going
to sleep) and latest laptops models need that too.

I just have confirmation from ATI contacts that their Windows driver
knows how to re-POST all chips on wakeup, it doesn't rely on BIOS
services. They might help us get something into shape for Linus but it
will take time.

In the meantime, if we can (not sure about it) call back into the BIOS
when waking up (Andi seemed to imply we are in real mode when getting
out of sleep), we may just use int10 to hard re-POST video cards at this
point. We must also make sure we do that for the AGP bridge if possible.

Ben.
 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
