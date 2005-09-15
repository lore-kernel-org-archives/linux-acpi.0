From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: fans not working after suspend to disk on nc-4000 and nc-8000
Date: Thu, 15 Sep 2005 12:32:19 +0200
Message-ID: <20050915103219.GC2725@elf.ucw.cz>
References: <E1ECHiU-0005le-00@dorka.pomaz.szeredi.hu> <20050907183218.GA773@openzaurus.ucw.cz> <E1EDgJz-0000PH-00@dorka.pomaz.szeredi.hu> <20050910215552.GA2463@openzaurus.ucw.cz> <E1EFCcc-0008Jy-00@dorka.pomaz.szeredi.hu> <20050914210420.GD3460@elf.ucw.cz> <E1EFqlx-0002iN-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1EFqlx-0002iN-00-VFwzv6uONVrxNFs70CDYszOMxtEWgIxa@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Not sure... interpretter should not be involved with it. (Perhaps you
> > need to use platform, not shutdown mode,
> 
> Tried this... And it worked.  Am I right in thinking that this is S4
> instead of S5?  Why is it not the default if ACPI is enabled?

Yes, it is S4 instead of S5, and it caused too many problems last time
we tried enabling it by default.

> Setting PowerdownMethod to platform seems to solve the problems in
> thermal_zone.  It didn't sove the fan driver confusion issue though.

Okay, so we have some progress.

> > and call _WAK properly?)
> 
> What's that?

Don't worry. Its one of methods platform mode calls.

> > Anyway, some suspend/resume functionality needs to be added and I
> > have no problem with machines here... so I guess its up to you.
> 
> I'm not implying you should do it.  It's clearly an ACPI issue (fan
> driver is part of ACPI) not an swsusp issue.  But it would be better
> if someone who knows that part of the code (ACPI maintainers?) could
> have a look at this fan issue.
> 
> We are all lazy, I'm more lazy than the average, but if nobody comes
> forward after a certain nagging, I will have to take a look at it :)

I'm afraid ACPI people still have bigger problems to go after :-(.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
