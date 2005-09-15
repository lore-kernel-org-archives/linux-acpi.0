From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: fans not working after suspend to disk on nc-4000 and nc-8000
Date: Thu, 15 Sep 2005 13:11:52 +0200
Message-ID: <20050915111152.GD2725@elf.ucw.cz>
References: <E1ECHiU-0005le-00@dorka.pomaz.szeredi.hu> <20050907183218.GA773@openzaurus.ucw.cz> <E1EDgJz-0000PH-00@dorka.pomaz.szeredi.hu> <20050910215552.GA2463@openzaurus.ucw.cz> <E1EFCcc-0008Jy-00@dorka.pomaz.szeredi.hu> <20050914210420.GD3460@elf.ucw.cz> <E1EFqlx-0002iN-00@dorka.pomaz.szeredi.hu> <20050915103219.GC2725@elf.ucw.cz> <E1EFrKP-0002mG-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1EFrKP-0002mG-00-VFwzv6uONVrxNFs70CDYszOMxtEWgIxa@public.gmane.org>
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

> > > > Not sure... interpretter should not be involved with it. (Perhaps you
> > > > need to use platform, not shutdown mode,
> > > 
> > > Tried this... And it worked.  Am I right in thinking that this is S4
> > > instead of S5?  Why is it not the default if ACPI is enabled?
> > 
> > Yes, it is S4 instead of S5, and it caused too many problems last time
> > we tried enabling it by default.
> 
> Well, but ACPI seems to rely on it.  You can't have it both ways.
> Either ACPI should be tought not to rely on S4 and reinitialize
> everything after resume, or to rely on S4 but then _require_ S4 for
> suspend.  Am I not right?

You are right, it is broken. OTOH S4 hangs some machine in
ugly/undebuggeable ways. But perhaps that was already fixed?

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
