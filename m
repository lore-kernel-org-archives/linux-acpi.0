From: Pavel Vondricka <Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org>
Subject: Re: Freezing more and more (Gericom Supersonic M6T)
Date: Sun, 9 Mar 2003 13:09:47 -0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303091309.47181.Pavel.Vondricka@ff.cuni.cz>
References: <200303041529.11172.Pavel.Vondricka@ff.cuni.cz> <200303071531.55933.Pavel.Vondricka@ff.cuni.cz> <20030307161743.GA6986@schiggy.intern.quelltext.com>
Reply-To: Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030307161743.GA6986-dzH3swnhYuu5cqaZGqYS/O8dC6aEkcuFVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

By the way, do you not use ALSA as well? I could also suspect these drivers=
=20
(or the combination of them), because they are also under development and I=
=20
still use some 0.90rc5 version. The computer very often hangs when playing=
=20
audio as well.

> "abra" is the name of my machine. I am using Debian; when I compile a
> kernel, I make a Debian package out of it, and use =ABmachine name=BB.=AB=
date=BB
> as the version number for this package, i.e. the package file gets called

Oh, I see!

> Yes, strange. Perhaps you are applying the ACPI patch to a different
> version of the kernel sources?

Of course not :-( ...

> Yes, the very first insertion of a card is not noticed, but if I take
> out the card and insert it once again, it works (all subsequent
> insertions are properly noticed, too).

Then it hangs on my computer. But may be it's because of the hostap, may be=
=20
it's because of the external pcmcia, may be it's because of the card (my=20
colleagues had problems using it under windows, it hangs as well under some=
=20
conditions!)

Thanks,
Pavel


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
