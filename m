From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: Re: Really weird usb problem with acpi.
Date: 01 Apr 2003 00:33:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1049149990.1101.7.camel@chevrolet.hybel>
References: <1048877988.32560.26.camel@chevrolet.hybel>
	 <20030401141842.GA1714@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030401141842.GA1714-VNkyu7EogrqGmfs5Z0+9fw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

tir, 01.04.2003 kl. 16.18 skrev Pavel Machek:
> Hi!
> 
> > With acpi enabled, everything works perfect, EXCEPT the keyboard/mouse.
> > I just get the infamous "device not accepting address" message.
> > 
> > But if I boot the computer with ps/2 keyboard and mouse. Pulls out the
> > ps/2 keyboard and mouse, and plugs in the usb-cable, the
> > usb-keyboard/mouse works. But if I then restart the computer with the
> > usb keyboard/mouse still attached, I'm back to "device not accepting
> > adress".
> 
> Disable "emulate ps/2 when you have
> usb" support in bios.
> 				Pavel

Actually, I had tried that already. But there is another option in my
BIOS; "PS/2 Mouse Function Control", which let me choose to reserve
irq12 even if there is no mouse connected. That did the trick :) Thanks
a lot for giving me the inspiration to check this :)

I have seen Alan say that some mb's with MPX chipset need to have a
mouse connected even if it's not used, but it is actually needed here as
well. Asus CUV266-DLS (with Via Apollo Pro 266 chipset).

Btw. even if you choice to disable ps/2 emulation would have worked,
that wouldn't have been a good option, since I use Grub, and have
several kernels (for testint 2.5.x), which I would have been unable to
select between. But now everything works perfect :)

Regarding my "oh noone helped me" post, I'm really sorry. I really don't
know why I wrote that. It wasn't meant like that. I'm sincerely sorry.

Thank you very much for you patience :)

Best regards,
Stian



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
