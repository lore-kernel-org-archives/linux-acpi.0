From: Joshua Lauricha <laurichj-OqvYMq7jYtE3uPMLIKxrzw@public.gmane.org>
Subject: Re: S3 and S4: nothing happens
Date: Thu, 10 Oct 2002 19:22:55 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0210101816280.20282-100000@hill.cs.ucr.edu>
References: <3DA5B75D.80203@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DA5B75D.80203-S0/GAf8tV78@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Roy <roy_me-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Same thing happen here, using 2.4.20-pre8 w/acpi-20021002-pre8,
/proc/acpi/sleep gives S0 S3 S4 S5, but "echo 3 > /proc/acpi/sleep", or 4.
Give nothing.

Also, /proc/acpi/processor/CPU0/performance gives not supported. Is that
simply for 2.4.xx or some error?

I have a Fujitsu C-6631 w/a P3-1Ghz.

On Thu, 10 Oct 2002, Roy wrote:

> Anyone can help me with this:
> If I do a "echo 3 > /proc/acpi/sleep" or a "echo 4 > /proc/acpi/sleep"
> nothing happens (using 2.5.41 and 2.4.20-pre8-acpi). There isn't any
> message in /var/log/messages.
>
> A "cat /proc/acpi/sleep" gives me: S0 S3 S4 S5
>
> Any suggestions?
> Thanks, Roy!
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
