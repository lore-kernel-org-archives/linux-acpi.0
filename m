From: Mario Lang <mlang-0OxMAPPu35xAfugRpC6u6w@public.gmane.org>
Subject: Re: Switching LCD off on a laptop (or change to CRT)
Date: Wed, 25 Sep 2002 19:07:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87vg4uf16u.fsf@lexx.delysid.org>
References: <871y7kkd7s.fsf@lexx.delysid.org>
	<1032798967.1161.9.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1032798967.1161.9.camel-AynNu1t4G8oLie942ae2tA@public.gmane.org> (Jurgen Kramer's message
 of "23 Sep 2002 18:36:07 +0200")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Jurgen Kramer <gtm.kramer-c1aixF9oqgPk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Jurgen Kramer <gtm.kramer-c1aixF9oqgPk1uMJSBkQmQ@public.gmane.org> writes:

> I have the Japanese version of this laptop (Victor MP-XP7210) do the
> Fn+F4, Fn+F5, Fn+F6 and Fn+F7 work for you?

No.

> BTW Fn+F10 works for me with kernel 2.4.19 + ACPI 20020918. The LCD does
> go off. I do not have the VGA connector cable so I cannot see if it
> switches to VGA output.
Thanks for that tip, it actually works!

I'm using 2.4.20-pre7-acpi-20020918 now, and it boots fine,
all devices continue to work, Fn+F10 switches my LCD off, and
setting limit in /proc/acpi/processor/CPU0/ also works, nice!

(Btw, I'm wndering why it always shows P0:T0 as active state,
even if I do nothing on the machine.  Is there a way to
set it such that it automatically sets T1 or some higher state it the
system load is effectively 0?

-- 
A happy,
  Mario


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
