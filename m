From: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>
Subject: Re: broken power button
Date: Thu, 05 Feb 2004 21:07:26 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076044045.4744.10.camel@tinny.home.foo>
References: <1076036158.4792.12.camel@tinny.home.foo>
	 <1076038435.5849.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1076038435.5849.8.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Cc: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-02-05 at 19:33, Greg Sarjeant wrote:
>     I have the same issue with my power button on my Gateway 200X (which
> I think is roughly the same machine as the Dell X200). It appears to be

the older ones are identical AFAIK; the newer 200X's have 14" screens
though and seem totally different.

> an issue with fixed-feature power buttons. I opened bug 1920 to address
> the problem. You can check it out here:

I applied the patch; I think ACPI should report a warning in this case. 
According to p63, there are 2 bits of information (4 choices) but only 2
legal possibilities.  Windows must be ignoring the PWR_BUTTON field and
just checking for the existance of PWRB.  ACPI should complain if
PWR_BUTTON is not set and PWRB exists, or if PWR_BUTTON is set and PWRB
doesn't exist.

Similarly, if SLP_BUTTON is not set and SLPB exists, ACPI should throw a
warning too.

Unfortunately, while this lets me receive PWRB notifications, it doesn't
solve the lockup on suspend.  Ugh.

	Scott



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
