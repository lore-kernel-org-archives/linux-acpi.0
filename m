From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Re: Suspend-to-RAM on ThinkPad R51
Date: Wed, 30 Mar 2005 11:36:58 -0500
Message-ID: <200503301136.59046.barr.156@osu.edu>
References: <200503261534.44710.barr.156@osu.edu> <200503282114.15289.barr.156@osu.edu> <20050329083823.GA3897@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050329083823.GA3897-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sorry for not getting back to you sooner, but classes started Tuesday and I've 
had less time to hack at this problem than before...

On Tuesday 29 March 2005 03:38 am, Pavel Machek wrote:
> I'd like
>
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
>
> ...to be done in modules. You'll probably need to modularize whole
> input to achieve that.

I tried this. I'm now removing the modules usbhid, psmouse, libps2, serio, 
i8042, and atkbd before suspend. It doesn't change anything, but I have a 
couple of questions/observations that could possibly point us in the right 
direction:

- Is there a possibility that some userspace program is locking up the video, 
keyboard, and mouse? I tried stopping all the services that I could 
(including X11) and although the video froze (display powered up, frozen 
cursor as before), the keyboard was responsive to a capslock press. I haven't  
had time to isolate the particular service that was causing that behavior.
- I tried compiling my kernel without framebuffer (vesafb-tng) or splash 
(Gentoo's fbsplash) support, and the behavior is the same as before except 
the cursor blinks. Are framebuffer drivers an issue for suspend-to-RAM? 
Perhaps trying the intelfb driver would give better results?

I should also point out that I've tried removing all modules that I could and 
suspending. This hasn't helped either. I'm going to try installing Fedora 
Core on this laptop and see if some particular configuration element of my 
Gentoo installation is causing lockups. Thanks for all your help.

Andrew

> 								Pavel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
