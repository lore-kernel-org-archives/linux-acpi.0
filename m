From: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Subject: Re: [PATCH] Toshiba ACPI Extras 0.16
Date: Sat, 26 Jul 2003 18:09:06 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F22FC02.80407@prairienet.org>
References: <willy@debian.org>	<20030726132501.C766314829@o-o.yi.org> <20030726.111800.13461649.imp@bsdimp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030726.111800.13461649.imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

M. Warner Losh wrote:
> So what was wrong with strlcpy?  Was strncpy used because trailing
> NULs for the length of the field was required?  That, and the point
> below, are the only differences between two versions of the code
> posted.

The strlcpy function expects the input string to be zero-terminated, 
which is not the case here.

> Also:
> 	strncyp(str2, str, n); str2[n] = '\0';
> means that you copy n + 1 bytes into str2, which is typically a bug,
> so a comment explaining why it isn't would be in order.

It isn't a bug because

     char* str2 = kmalloc(n + 1, GFP_KERNEL)

> As it is the comment of 'don't even consider using strlcpy' is about
> useless because it tells what, but not why.  And there's a long
> history of people in the Linux world ignoring dictates when the
> reasons get lost in the mists of time.

What's going on is that someone made a conversion to my driver which was 
not functionally equivalent and caused a serious bug, and did not notify 
me of the change.  It's my name in the maintainer field and I have to 
deal with resulting bug reports.  I wasted an entire day tracking down 
exactly what happened, discussing it with the people involved and even 
more with those not involved, and preparing a correction.

This should have never happened, and the comment I added is only a 
reaction to this.  To me it states the obvious, "don't break my code", 
and indeed left to my own devices it wouldn't be there.


-- 
http:// if   l .o  /



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
