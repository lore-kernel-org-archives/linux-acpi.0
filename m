From: Lyle Seaman <lws-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Subject: Re: AW: Re: [PATCH] S4bios for 2.5.52.
Date: Thu, 19 Dec 2002 10:05:55 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021219150600.C5DBE1480A@o-o.yi.org>
References: <Herbert.Nachtnebel@tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
   of "Thu, 19 Dec 2002 10:49:06 +0100." <B900970C7DD9474C972986EB3EC7C58F0D404E-PWLG29+z7hEKeIAE67mlpo2P0GrZ+RbP@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Herbert Nachtnebel <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> but that sounds like a unpluged block queue which get flushed every 5 s=
econds (or 30 seconds) by the bdflush daemon. There are two things which =
counters this, 1st: swsusp works on ide and there aren't such problems si=
nce aeons and 2nd Pavel knows that :-)
> Hence, apologies for this hip shot.

I'm not sure I understand what you're saying, Herbert.  =


There was something broken in yield() or schedule() back around 2.5.20 - =

2.5.40 that made rw_swap_page_sync EXCRUTIATINGLY slow, but that's been f=
ixed.

Still, writing pages synchronously, one at a time, is going to be slow no=
 =

matter what you do.  *Especially* on slow laptop drives.

What I sent Nigel was a little patch to write them 20 at a time, which re=
duced =

my suspend times from nearly 60 seconds to something around 2 seconds.  I=
 =

stopped at 20 because going beyond that was chasing diminishing returns a=
nd I =

didn't think that chewing up a huge chunk of stack was justified for a =

one-second reduction in suspend times.

I didn't send it on to the rest of the list because I figure Nigel's othe=
r =

changes will be coming along as well, and I didn't want to make merging t=
oo =

difficult for everyone.






-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
