From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: smp/swsusp done right
Date: Wed, 30 Mar 2005 23:22:53 +0200
Message-ID: <20050330212253.GB1347@elf.ucw.cz>
References: <20050323204019.GA11616@elf.ucw.cz> <Pine.LNX.4.61.0503301413050.12965@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503301413050.12965-SOP5cCwKKQRMCHjbocvOOJqQE7yCjDx5@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, seife-l3A5Bk7waGM@public.gmane.org, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > This is against -mm kernel; it is smp swsusp done right, and it
> > actually works for me. Unlike previous hacks, it uses cpu hotplug
> > infrastructure. Disable CONFIG_MTRR before you try this...
> > 
> > Test this if you can, and report any problems. If not enough people
> > scream, this is going to -mm.
> 
> Yay! Thanks for getting that done Pavel =)

Well, I guess it is thank you -- I got rid of ugly FIXME that would
involve arch-dependend assembly to be solved properly.

... hmm, can play_dead handle all the memory being overwritten? Also
it should probably save and restore registers including MTRRs.

...so I more moved ugly FIXME to better place. Oh well, at least it
uses common infrastructure now. People at Intel doing suspend-to-RAM
on smp systems will need to solve it properly, anyway, because they
need to go to real mode and back.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
