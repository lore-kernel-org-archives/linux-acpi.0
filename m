From: <joerg.beyer-htSm2yLGOjU@public.gmane.org>
Subject: Re: Help needed....
Date: Tue, 15 Oct 2002 19:23:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210151723.g9FHNgX26060@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, RuudKoendering <ruud.koendering-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Ruud Koendering <ruud.koendering-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org> schrieb am 15.10.02 18:39:13:
> I'm using the Mandrake 2.4.19-6mdk Mandrake kernel in version 9.0
> 
> Where can I see and how if ACPI is loaded(?), working(?)

if acpi is there you have /proc/acpi/* . If that is missing, you dont have
acpi. If the value in /proc/acpi for temerature, battery state and so on
are ok, then you ACPI is working.

    hope this helps
    Joerg



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
