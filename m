From: Michael Wahlbrink <linux.wali-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: IBM Thinkpad R32 and ACPI
Date: Wed, 16 Apr 2003 12:58:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030416125853.625072c6.linux.wali@gmx.de>
References: <20030415110541.469a64e9.linux.wali@gmx.de>
	<200304151747.h3FHlUK07346@throb.netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200304151747.h3FHlUK07346-7GtV0IYKK74tA4QZiFxQkx2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 15 Apr 2003 13:47:30 -0400
bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org wrote:

> Michael Wahlbrink <linux.wali-Mmb7MZpHnFY@public.gmane.org> writes:
> 
> 
> > Hi Brian, Hmm, it have the same effect like commenting out these "if
> > (ec_ecdt && ec_ecdt->uid == uid) {...}" block in acpi_ec_add() of
> > ec.c. No errormessages anymore but also no events from the
> > powerbutton...  I'll no try for testing a kernel with both hacks ;-)
> 
> Nothing interesting will happen.  The ec_add is a hack, my fix is (at
> least closer to) a real fix.  If you comment it out the "fixed" code
> won't even get called.
> 
> > ...  And I'll give 2.5.66 a shot to see if it makes a difference
> > ....  thanks for the quick response regards micha
> 
>  I think I noticed the same problem, but I guess I didn't really care.
> I'm not sure it's worth the effort until the sleep functions are
> fixed.  You might be able to get somewhere if you looked at the DSDT
> table, I dunno.  It may be possible that the power button isn't
> controlled by acpi.
Hmmm, it seems that it is also controlled by acpi, because in a kernel without your fix the Powerbutton produces also these errormessages like the volume keys and all fn+Fx (only fn+F4) always gives the right action... So as I see the things in the moment, I prevent with the fix from giving the errors, but I'm not get any more usable events in /proc/acpi/events  cause fn+F4 and the LID-switch worked also before. The only difference in usability is that I can now use fn+F7 again to switch between the displays (internal/external).

> Good luck!
It seem that I'll need it for acpi on that Laptop....

Thanks to all who work on ACPI-support for linux

regards
micha


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
