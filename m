From: Pavel Vondricka <Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org>
Subject: Re: Freezing more and more (Gericom Supersonic M6T)
Date: Fri, 7 Mar 2003 13:51:38 -0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303071351.38346.Pavel.Vondricka@ff.cuni.cz>
References: <200303041529.11172.Pavel.Vondricka@ff.cuni.cz> <20030307095014.GA28237@schiggy.intern.quelltext.com> <20030307101310.GC28237@schiggy.intern.quelltext.com>
Reply-To: Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030307101310.GC28237-dzH3swnhYuu5cqaZGqYS/O8dC6aEkcuFVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
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

Thanks,
I also use KDE 3.1, but my system is based on RedHat 8.0. The computer really 
behaves strange. I have two more questions:

Where can I get acpi 20030306? Some CVS download, you mean?

Does it matter if patching the kernel shows messages like "Hunk XXXX suceeded 
at position -235 ..."? Lately I can never patch any kernel without these 
warnings. Does ACPI use another kind of kernel than vanilla to make patches 
to?

> that my Prism 3 based WLAN card does not longer work with this kernel
> as the orinoco module has unresolved symbols (perhaps a problem with

Personally, I use the hostap drivers (a prism 2.5 card), which is known to 
generate lots of interreupts. However, as I told you, the system often hangs 
even though I do not use the card. And independently on the system load!!! It 
doesn't hang because of overload. It hangs also when I leave my computer for 
a few minutes! Sometimes. Sometimes it works 20 hours without problems - I 
managed to compile KDE 3.1 over night. The computer started hanging the next 
day, when I tried to run it. Mainly when I played with transparency settings 
of menus, aso. in KDE look&feel. Then I removed the processor.o module from 
the kernel and it became stable again. But one or to days later it started 
hanging again, even without the processor.o module.

So, I think it would hardly mean anything if I managed to run my computer for 
one week without problems without ACPI. This can happen even with ACPI. Could 
the problem be some wrong way of handling interrupts at run-time? Then I 
wouldn't find the problem anyway, because I couldn't use my modem, eth0, 
pcmcia and sound without ACPI.Is there any way to find out if it is ACPI 
software or hardware that handles these interrputs wrongly (if the problem 
would be here)?

Anyway, thanks for the patch!
Pavel

-- 
###########################################################################
# mailto:Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org / ICQ:143159880 
# http://web.ff.cuni.cz/~vondric
#
# Muzete mi psat cesky s libovolnym kodovanim (UTF-8, ISO-8859-2,
# windows-1250, atd. ...)
###########################################################################




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
