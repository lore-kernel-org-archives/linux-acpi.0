From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Suspend-to-RAM on ThinkPad R51
Date: Wed, 30 Mar 2005 22:24:16 +0200
Message-ID: <20050330202416.GA1347@elf.ucw.cz>
References: <200503261534.44710.barr.156@osu.edu> <200503282114.15289.barr.156@osu.edu> <20050329083823.GA3897@elf.ucw.cz> <200503301136.59046.barr.156@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200503301136.59046.barr.156-ZbGKxL/pcrQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> had less time to hack at this problem than before...
> 
> On Tuesday 29 March 2005 03:38 am, Pavel Machek wrote:
> > I'd like
> >
> > CONFIG_SERIO=y
> > CONFIG_SERIO_I8042=y
> >
> > ...to be done in modules. You'll probably need to modularize whole
> > input to achieve that.
> 
> I tried this. I'm now removing the modules usbhid, psmouse, libps2, serio, 
> i8042, and atkbd before suspend. It doesn't change anything, but I have a 
> couple of questions/observations that could possibly point us in the right 
> direction:
> 
> - Is there a possibility that some userspace program is locking up the video, 
> keyboard, and mouse? I tried stopping all the services that I could 
> (including X11) and although the video froze (display powered up, frozen 
> cursor as before), the keyboard was responsive to a capslock press. I haven't  
> had time to isolate the particular service that was causing that
> behavior.

Well, non-working video is common problem after suspend-to-ram, see
Documentation/power/video.txt.

Try init=/bin/bash to keep most of userspace out of picture...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
