From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: video extensions (Re: Handling \_GPE._L03)
Date: 26 Jul 2004 17:54:00 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1090878839.2063.5.camel@dhcppc4>
References: <003901c45b1c$91e1e910$6900a8c0@DEVELOPER>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <003901c45b1c$91e1e910$6900a8c0-nm0TT7E1c8rl2ZiQzgSchg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Wayne Wylupski <wayne-/9RTSe/R4cJBDgjK7y7TUQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-06-25 at 21:26, Wayne Wylupski wrote:
> Hello,
>  
> My laptop is a Fujitsu Lifebook P2110.  I get ACPI events for the
> function keys for video (switch to other video adapter. or S-output,
> or shrink the screen).  The Method that gets called is \_GPE._L03.  I
> know that the ACPI portion of the kernel is handling the method, but
> how do I register my own handler so I may generate acpid events?  It's
> not obvious to me there's a device (_HID) associated with this method,
> and I don't see a precedent for this within the other drivers in
> drivers/acpi.

Wayne,
how did you confirm that the L03 is being called?

Bruno prototyped some of the display extensions here:
http://bugzilla.kernel.org/show_bug.cgi?id=1944

Perhaps you can attach your acpidmp output to that
bug report and we can see if we can't get the extensions
working on your laptop?

thanks,
-Len





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
