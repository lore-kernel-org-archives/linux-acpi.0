From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: RE: AW: Re: [PATCH] S4bios for 2.5.52.
Date: Fri, 20 Dec 2002 09:12:20 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000b01c2a79a$f13045b0$0101010a@NigelLaptop>
References: <20021219150600.C5DBE1480A@o-o.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20021219150600.C5DBE1480A-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Lyle Seaman' <lws-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, 'Herbert Nachtnebel' <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hmm. I didn't think that carefully about what was causing the write to
occur. Hence I unrolled I took your patch further and completely separated
the submitting of _all_ of the pages from the block_flushpage calls for all
of the pages (ie two loops). (I saw much more than a one second gain, even
on my faster desktop computer!) After reading this, I think I should look
sooner at what is going. I was going to anyway, but I was concentrating on
getting my whole port from 2.4 working first.

I'm not promising anything quickly - I have plenty of 'real' work at the
moment :>

Regards,

Nigel

> Still, writing pages synchronously, one at a time, is going
> to be slow no
> matter what you do.  *Especially* on slow laptop drives.
>
> What I sent Nigel was a little patch to write them 20 at a
> time, which reduced
> my suspend times from nearly 60 seconds to something around 2
> seconds.  I
> stopped at 20 because going beyond that was chasing
> diminishing returns and I
> didn't think that chewing up a huge chunk of stack was
> justified for a
> one-second reduction in suspend times.
>
> I didn't send it on to the rest of the list because I figure
> Nigel's other
> changes will be coming along as well, and I didn't want to
> make merging too
> difficult for everyone.



-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
