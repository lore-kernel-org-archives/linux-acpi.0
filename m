From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: fans not working after suspend to disk on nc-4000 and nc-8000
Date: Wed, 14 Sep 2005 23:04:20 +0200
Message-ID: <20050914210420.GD3460@elf.ucw.cz>
References: <E1ECHiU-0005le-00@dorka.pomaz.szeredi.hu> <20050907183218.GA773@openzaurus.ucw.cz> <E1EDgJz-0000PH-00@dorka.pomaz.szeredi.hu> <20050910215552.GA2463@openzaurus.ucw.cz> <E1EFCcc-0008Jy-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1EFCcc-0008Jy-00-VFwzv6uONVrxNFs70CDYszOMxtEWgIxa@public.gmane.org>
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

> > Okay, so ACPI is basically okay, but fan driver is confused.
> > You need to add code to handle suspend and resume into fan.c.
> > Probably force everything on for suspend, and sync it with
> > software expectations after resume.
> 
> Also how do you explain the fact, that removing the fan and
> thermal_zone modules before suspend and inserting them after resume
> doesn't help at all?
> 
> It seems to me as if something in core ACPI is breaking.

Not sure... interpretter should not be involved with it. (Perhaps you
need to use platform, not shutdown mode, and call _WAK properly?)
Anyway, some suspend/resume functionality needs to be added and I have
no problem with machines here... so I guess its up to you.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
