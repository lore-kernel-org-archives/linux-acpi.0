From: Mike Wohlgemuth <mjw-JUfvz9/eqXCsTnJN9+BGXg@public.gmane.org>
Subject: Re: ACPI vs. PCMCIA on Compaq Evo N800c
Date: Tue, 29 Apr 2003 14:19:07 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EAEC21B.8010409@woogie.net>
References: <3EAB29E2.5030702@woogie.net>	<16045.31555.910630.383445@hotzenplotz.chateau-neukoelln.de>	<3EAD88F1.1070603@woogie.net> <16045.36504.536147.599551@hotzenplotz.chateau-neukoelln.de> <3EAD9C72.9060301@woogie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3EAD9C72.9060301-JUfvz9/eqXCsTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I just wanted to thank everyone who had suggestions on this problem.  It 
turns out that my problem was that I was compiling PCMCIA support as a 
module.  Any kernel I built this way failed to load pcmcia support. 
 Building it into the kernel and not as a module fixed my problem. 
 Thanks again for all the help.

Mike



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
