From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: broken power button
Date: Thu, 05 Feb 2004 22:33:55 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076038435.5849.8.camel@localhost>
References: <1076036158.4792.12.camel@tinny.home.foo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1076036158.4792.12.camel-3lu5YwujmwObGSPjaX/RoA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>
Cc: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Apologies for sending this twice, Scott. I forgot to copy the list.



Hi Scott,

    I have the same issue with my power button on my Gateway 200X (which
I think is roughly the same machine as the Dell X200). It appears to be
an issue with fixed-feature power buttons. I opened bug 1920 to address
the problem. You can check it out here:

    http://bugzilla.kernel.org/show_bug.cgi?id=1920

    Thanks,
    Greg


On Thu, 2004-02-05 at 21:55, Scott T. Smith wrote:
> APM will let me suspend to RAM and restore, but the touchpad is broken
> the whole time.
> 
> So I'm trying ACPI -- ACPI seems to suspend successfully, but it will
> not wake up.  I have to unplug the battery and power supply for 10+
> minutes to reset it.
> 
> I think it's related to the power button.  I notice that the power
> button does not generate any events via acpid (but if I close the lid,
> or press Fn-ESC, then I do see events).  However, if I hold the power
> button down for 4 seconds, the machine does shut off immediately. 
> (Holding it down for 4+ seconds while frozen does nothing).
> 
> In tracing this further, I noticed that the ASL lists the button 'PWRB',
> while ACPI (via dmesg) lists the button 'PWRF'.  I think (can someone
> clarify this?) that this is the difference between a "fixed hardware
> power button" and a "control method power button."
> 
> I tried renaming all references to PWRB to PWRF and recompiling, but
> that did no good.  I think (again, can someone clarify this?) that I
> need to set the PWR_BUTTON flag, but I don't know how to do that.  There
> is a reference to SLP_BUTTON in the dsdt.asl file, but it's in a
> comment.
> 
> Am I on the right track here?
> 
> oh, specs:  2.6.2-rc2-mm1 (ACPI v20040116), Dell Lattitude X200 (P3M
> 800), patched DSDT to cope with battery issue.
> 
> 	Scott
> 
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
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
