From: Mike Wohlgemuth <mjw-JUfvz9/eqXCsTnJN9+BGXg@public.gmane.org>
Subject: Re: Compaq Evo N800v: I have a fixed DSDT table
Date: Tue, 29 Apr 2003 20:25:32 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EAF17FC.2010705@woogie.net>
References: <20030428121157.A20348@fermat.unipv.it> <3EAEDD12.9070106@woogie.net> <20030429224718.A26481@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030429224718.A26481-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Daniele Boffi wrote:

>I think your problem is related to Xfree. I am using XFree4.2 with the
>configuration file you can download at
>  
>
You are correct.  The trick was to not load dri in the modules section. 
 That has some downsides, but nothing I can't live with.

One thing I did notice is that if I hit the lid button while running X, 
the screen blanks, but when I release it, the screen is not restored (it 
just stays blank with the backlight on).  Hitting ctrl-alt-f1 to get to 
a text console and hitting the lid button again fixed the problem, and I 
could then hit ctrl-alt-f7 to get back to X.

Thanks for the help.

Mike



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
