From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: broken power button
Date: Fri, 06 Feb 2004 07:46:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076071581.5785.15.camel@localhost>
References: <1076036158.4792.12.camel@tinny.home.foo>
	 <1076038435.5849.8.camel@localhost>
	 <1076044045.4744.10.camel@tinny.home.foo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1076044045.4744.10.camel-3lu5YwujmwObGSPjaX/RoA@public.gmane.org>
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

On Fri, 2004-02-06 at 00:07, Scott T. Smith wrote:
> I applied the patch; I think ACPI should report a warning in this case. 
> According to p63, there are 2 bits of information (4 choices) but only 2
> legal possibilities.  Windows must be ignoring the PWR_BUTTON field and
> just checking for the existance of PWRB.  ACPI should complain if
> PWR_BUTTON is not set and PWRB exists, or if PWR_BUTTON is set and PWRB
> doesn't exist.
> 
> Similarly, if SLP_BUTTON is not set and SLPB exists, ACPI should throw a
> warning too.
> 
You're probably right.  I am hopeful that we can find a more robust
solution to the problem. This is an admittedly sloppy (and hopefully
temporary) workaround that just saves me the trouble of commenting out
those three whole lines of code in future kernels. :)

> Unfortunately, while this lets me receive PWRB notifications, it doesn't
> solve the lockup on suspend.  Ugh.
> 
Ah, drat. For what it's worth, I have similar issues with suspend,
though I haven't tried suspending to RAM for a while, which was when I
saw the behavior you describe. I have been able to suspend to disk from
a console, and others have reported doing so from unaccelerated X. I've
never managed to resume successfully from X, however.

Greg



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
