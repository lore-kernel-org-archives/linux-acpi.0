From: Maier Gerfried <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Fri, 08 Nov 2002 08:45:06 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036741506.3dcb6b824e289@sbox.tugraz.at>
References: <E187ipj-0001ss-00@usw-sf-list2.sourceforge.net> <000001c28231$b7cae110$c200a8c0@pikachu> <20021105164048.GF18318@schiggy.intern.quelltext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021105164048.GF18318-dzH3swnhYuu5cqaZGqYS/O8dC6aEkcuFVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Zitiere Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>:

[...]
> Just FYI, "on" and "off" are not the right keywords here:
> 
>     echo >/proc/acpi/fan/FAN0/state 0		turns the fan on
>     echo >/proc/acpi/fan/FAN0/state 3		turns the fan off
> 
> (On my machine, though, 3 doesn't turn the fan off, but makes it run
> slower and thus more quiet.)

Does this mean, that there shold be /proc/acpi/fan/... present in the latest 
acpi (kernel 2.4.20-rc1)?

Well, unfortunately I do not have it :-(
(fan-module seems to be loaded without any problems - meaning: error messages; 
acpi-debug enabled)

Maier Gerfried


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
