From: Z F <mail4me9999-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: can not access battery status
Date: Thu, 24 Jun 2004 19:56:29 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040625025629.66989.qmail@web20416.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello eveybody,

Could someone help me to resolve this problem.

I have a Dell Latitude X300 and I get this error when the battery
module
is loaded:

    ACPI-0347: *** Error: Handler for [EmbeddedControl] returned
AE_BAD_PARAMETER
    ACPI-1133: *** Error: Method execution failed [\_SB_.BAT1._STA]
(Node c1151240), AE_AML_NO_RETURN_VALUE
    ACPI-0347: *** Error: Handler for [EmbeddedControl] returned
AE_BAD_PARAMETER
    ACPI-1133: *** Error: Method execution failed [\_SB_.BAT2._STA]
(Node c1151480), AE_AML_NO_RETURN_VALUE


Also, when I load  the ac module, I get this:
    ACPI-0347: *** Error: Handler for [EmbeddedControl] returned
AE_BAD_PARAMETER
    ACPI-1133: *** Error: Method execution failed [\_SB_.ADP1._PSR]
(Node c1153e40), AE_BAD_PARAMETER


This looks like there is a common problem. I do not know where to start
to look for the solution. Any suggestion is highly appreciated.

Thank you very much

Lazar


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
