From: "Pawel S. Veselov" <vps-DfbhUdzxHZh1tZTNRjcZhg@public.gmane.org>
Subject: newbie
Date: Mon, 30 Dec 2002 14:25:26 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.50.0212301414320.19635-100000@manticore.2y.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi !

I just subscibed to this list. From watching some messages, I understand
the ACPI is not really progressing in 2.4. kernel, s that correct ?

The sourceforge webpages unfortunately don't contain much information
on the developement status, neither about the sources.

So, a few questions : is there an official sourcetree, or whatever is developed
is in the 2.5.x kernel ?

Is 2.4.x kernel is to be maintained with the latest ACPI changes ? If not, then
is it posible to take the ACPI subsystem from 2.5 kernels and recompile with
2.4, or are there incompatible kernel interfaces involved ?

The reason I got involved in ACPI is that I got HP Pavillion ze5155 laptop,
and it doesn't have any APM, it's pure ACPI. Looks like power buttons
is the only OSPM component that is processed correctly. Removing battery/
ac adaptor doesn't even trigger SCI (according to /proc/interrupts), so
I guess not all of the statuses are enabled. Also, battery status returned
is always 0x0f, so the battery is believed to be absent all the time.
I'm not sure how to identify the ACPI bios, so I can report what kind is it.
The motherboard is ALi M<something>, that's all I know.

Thanks !
    Pawel.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
