From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: ANNOUNCE: Asus ACPI driver v0.22
Date: Thu, 22 May 2003 18:19:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030522181941.748c2f71.nils@kernelconcepts.de>
References: <20030522130747.GC12331@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030522130747.GC12331-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 22 May 2003 15:07:47 +0200
Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> wrote:
> Hi,
Hi!

> We have released a new version of the Asus ACPI driver with Julien.
> Please check http://sourceforge.net/projects/acpi4asus/ for any
> information.
> 
> Current version has the following features:
> - support for hotkeys through /proc/acpi/event
Work!

> - switching LEDs
Also works, very cool! The email LED is ... guess it ... blue!

> - changing display brightness and switching LCD backlight
Work too!

> Current models supported: L2000D, L3800C, M2400X (untested), and
> possibly others.

I tested on L3800C, all very fine!
I also hacked up a script for xscreensaver to use the lcd on/off feature
as screensaver; makes me feel better concerning life of my backlight.

> We absolutely need more feedback, especially DSDTs, to further develop
> the driver and support other models. Please, all Asus notebook owners,
> send in your DSDTs and test the driver!

I have BIOS V1.18a from November 2002. I think most others will use this
too and thus have the same DSDT.

> All feedback and comments are welcome, especially related to the

OK, I'll have to test if switching screens, especially to and from
TV-out. Last version prohibited this, I think because the hotkey event
then went into the asus-ACPI driver instead of some builtin-BIOS code...
very weird. I'll let you know.

> possible future integration of the driver code with the ACPI project.

Oh, yes, Andrew, please :)
This is very nice and finally makes use of the extra hotkeys of the ASUS
notebook.

> Best regards,
Thanks so much for the work in this driver!

> Karol 'sziwan' Kozimor
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
