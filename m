From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Acer Travermate 8005 and battery info
Date: Thu, 7 Oct 2004 11:22:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041007092237.GB983@elf.ucw.cz>
References: <415C270F.5050306@lanil.mine.nu> <20041001102926.GD18786@elf.ucw.cz> <415D8CCF.8050602@lanil.mine.nu> <20041001194739.GE1100@openzaurus.ucw.cz> <41603BA0.9090900@lanil.mine.nu> <20041003203457.GD3379@elf.ucw.cz> <41617104.2040302@mega.ist.utl.pt> <20041005143951.GB4723@openzaurus.ucw.cz> <4162F3C8.9050509@lanil.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4162F3C8.9050509-pw/8oln/LLv0Dx+PQ6IoOQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Axelsson <smiler-pw/8oln/LLv0Dx+PQ6IoOQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >I believe that smbus is subset of i2c... So first step would be
> >"make it talk with smart battery over i2c".
> >
> >Anyway I may be wrong. You'll know for sure when the patch starts
> >working :-).
> 
> Ive read through the (short) smbus specs and the 2.2.14 patch and I dont 
> think its very hard to incoperate into the kernel (but Ive never done 
> any kernel coding before ;) except for the asm because Im almost totally 
> blank on asm.

2.2.14 driver is calling BIOS, right? You do not want to do that.

> The biggest problem I have is that I aint 100% sure that I have smart 
> battery because shouldnt my /proc/acpi/battery/* be totally empty then?

Well, you'll never be 100% sure. But if it is Acer then smart battery
is very probable.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
