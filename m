From: "Sourav K. Mandal" <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: 06 Aug 2002 02:13:32 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028614416.4553.3.camel@localhost.localdomain>
References: <200208010551.BAA23125@biohazard-cafe.mit.edu>
	<20020803220614.21895.qmail@scrye.com>
	<1028528792.7332.14.camel@anodyne.mandal>
	<20020805150428.10039.qmail@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020805150428.10039.qmail-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2002-08-05 at 11:04, Kevin Fenzi wrote: 

> it stores and restores them ok, but I cant change them once linux is
> up and running. LIke the buttons stop doing anything. ;( 

Yeah, trying it out myself it seems like a DRI thing.  Try 
turning off DRI in your XF86Config and see if it helps. You might have
to reboot ... DRI doesn't work when coming back from suspend, and some
things don't work once you run DRI.  For me, once I run DRI the
backlight refuses to turn off on lid close -- reboot fixes this. 

If that doesn't work, try switching to a text console.

I have yet to apply Charl's patch, and so I alternate between DRI and
no-DRI XF86Configs.  I don't know if the patch fixes the backlight thing
... 


Sourav



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
