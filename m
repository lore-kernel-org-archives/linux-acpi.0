From: Alexei Gilchrist <alexei-JAjqph6Yjy/o0IyPN7li9Ydd74u8MsAO@public.gmane.org>
Subject: PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
Date: Fri, 23 Jan 2004 11:04:31 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040123010430.GA1015@physics.uq.edu.au>
References: <m3hdyo2kce.fsf@reason.gnu-hamburg> <20040122140155.GC5194@hell.org.pl> <m3d69cj8hb.fsf@reason.gnu-hamburg> <20040122154638.GA11867@hell.org.pl> <m365f3dhtv.fsf@reason.gnu-hamburg> <40100962.4040306@blue-labs.org> <m37jzj9547.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m37jzj9547.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, I can report the same errors (and failure of the solutions) on a 
panasonic W2 (Intel 855GM video card)

see http://bugzilla.kernel.org/show_bug.cgi?id=1877

(NB contrary to original report the keyboard and mouse do work after a resume)

This is particularly a problem as APM also fails, and the various suspend-to-disk
progs only work very intermittently, so the machine has to be rebooted from scratch
each and every time.

regards,

Alexei


On Thu, Jan 22, 2004 at 08:04:56PM +0100, Georg C. F. Greve did merrily tap:
>  || On Thu, 22 Jan 2004 12:33:22 -0500
>  || David Ford <david+challenge-response-qokYbnrgTHEgsBAKwltoeQ@public.gmane.org> wrote: 
> 
>  df> Try hitting the hardware function key that swaps the CRT/LCD
>  df> and/or the function key that changes the font.
> 
> None of the keys make any difference.
> 
> Regards,
> Georg
> 
> -- 
> Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
> Free Software Foundation Europe	                 (http://fsfeurope.org)
> Brave GNU World	                           (http://brave-gnu-world.org)
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
