From: Lyle Seaman <lws-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Toshiba ACPI Extras 0.16
Date: Sat, 26 Jul 2003 09:24:56 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030726132501.C766314829@o-o.yi.org>
References: <willy@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
   of "Sat, 26 Jul 2003 06:20:12 BST." <20030726052012.GO1485-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> seems to me you'd be better off doing ...
> 
> 	len = strlen(str);
> 	if (len > n)
> 		len = n;
> 	memcpy(str2, str, n);
> 	str2[n] = '\0';
> 
> i wrote a short note entitled "strncpy Considered Harmful" a few years ago.
> unfortunately, it seems lost in time.

Obviously, you meant: 	memcpy(str2, str, len);

But strlen() is dangerous when you point it at something that you can't swear is null-terminated.  It almost always works because, somewhere along the line, there's a null byte.  BUT, it *is* walking off the end of your string and poking about in memory, and you never know what that might do.

You could just do this:
	memcpy(str2, str, n); 	str2[n] = '\0';

But, enlighten me.  What's wrong with strncpy, that is solved by doing the above?




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
