From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: ACPI stops working after memory upgrade vpr Matrix 175b4
Date: Tue, 3 Feb 2004 09:31:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040203083143.GA29079@hell.org.pl>
References: <401F0395.1090407@thedesignexperience.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <401F0395.1090407-eQMij45H2SHXYFsarriMmxagbA6BzR3y@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Bauer <dave-eQMij45H2SHXYFsarriMmxagbA6BzR3y@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Dave Bauer:
> My ACPI stopped working when I added an additional 256mb RAM to my vpr 
> Matricx 174b4 laptop. It has 256mb already, I added 256mb to make it 
> 512mb and I got a bunch of AE_NO_MEMORY errors in the ACPI code.
> 
> I took the extra RAM out, and the ACPI support works.
> 
> I am using kernel 2.6.1 with acpi patches. I had the same problem on 
> 2.6.0. On 2.4.20 with acpi patches the machine would not even boot with 
> the extra memory.
> 
> I have a custom DSDT file that I fixed errors in. When it was working on 
> 2.4.20 It looked like all the ACPI features were active and functional.

Recompile your DSDT. Since the amount of RAM changed and you're probably
using old DSDT containing wrong addresses, no wonder you're hitting errors.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
