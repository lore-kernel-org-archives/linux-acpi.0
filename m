From: Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Wed, 24 Jul 2002 09:47:15 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020724134715.6060914808@o-o.yi.org>
References: <lwspm@o-o.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
   of "Wed, 24 Jul 2002 09:38:21 EDT." <20020724133821.5598714808-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Also, drivers/acpi/system.c seems to assume that SAVE_STATE and RESTORE_STATE 
will implicitly disable and enable I/O, but that's not the way it's specified, 
and that's not the way that any code wants to work -- that I can see.  Do we 
agree?

> The more I look at this, the more convinced I am that driver-model.txt 
> describes the proper approach, and suspend.c just has it backwards.  Even 
> though no drivers really implement the functionality properly yet, it makes 
> sense to get the framework right so that they *can*, eventually.
> 
> I don't know why driver.h has the enums listed in a different order from 
> driver-model.txt, or if it's really necessary to fix the order, unless 
> somebody decides to start doing ordered comparisons.
> 
> Just to make it clear what I mean



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
