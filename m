From: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Subject: Re: 2.5.34?
Date: Mon, 16 Sep 2002 12:12:55 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209161612.g8GGCtv24883@p2.parker.boston.ma.us>
References: <willy@debian.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
   of "Mon, 16 Sep 2002 16:33:35 BST." <20020916163335.J10583-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>, Gustavo Sverzut Barbieri <gsbarbieri-/E1597aS9LRfJ/NunPodnw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Matthew Wilcox wrote:
>
>but 2.5.35 is out, so there's no need any more ;-)

ok, I'll try 2.5.35;  Is there a changelog for acpi? (other than the
kernel changelog)

S1 is working for me with 2.4.19, but even if I throttle back the cpu it
eats a lot of power (and generates a lot of heat!)

I've been fooling around with S3.  It looks like the big recent
additions (in 2.5) are to try and set the video mode in the wakeup
callback.  I keep sending email to the list but I have not heard from
anyone talk about the status of this code.

I want to ask "does the s3 wakeup code work for anyone?"; I suspect it
does since I've read reports that S4 is working for some and it uses
the same code path (for wakeup anyway).

Any suggestions how to debug this?  I would hack in some code to spit
messages out the uart but my hp laptop doesn't have one :-) I may try
a pcmcia 16550 card and a kgdb hack...

S3 puts it to sleep fine but when I wake up it seem to be hung - no lcd,
no keyboard...  It's pretty hard to say how far it gets.

-brad


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
