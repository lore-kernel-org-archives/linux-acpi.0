From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: gpe-handler / acpi on ASUSL2400D
Date: Wed, 26 Mar 2003 10:57:29 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A22B@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Thias <post-OXl1b/uZKHizQB+pC5nmwQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Sebastian Thias [mailto:post-OXl1b/uZKHizQB+pC5nmwQ@public.gmane.org] 
> i'm a newbie on both acpi- and kernel-programming.
> I've got an ASUSL2400D-laptop and kenel 2.5.65.

Sounds like you're a quick learner. :)

> Upon pressing one of my laptops hotkeys, I receive an error 
> message about
> a missing gpe-handler.
> After fiddling a bit, I wrote a module that installs a 
> gpe-handler for 0x1D 
> (the one triggered by my hotkeys). The handler calls 
> "\_GPE._L1D" (using 
> acpi_evaluate_object ...). Only then can I receive notify-events for 
> "\_SB_.HOTK" and only then buttons like switching 
> LCD-Backlights off or 
> changing the brightness work.
> 
> My question: Why do I have to install a gpe-handler by myself 
> if there is
> a mehod "\_GPE._L1D" in dsdt. Is that the usual way to do such things?

Is the button driver installed?

The usual way is that you have a driver (e.g. for the lid button) that
registers for notifications on the lid device. When the lid button is
pressed, it generates a GPE, which the lid driver finds out about
because the core calls the GPE method associated with the GPE (e.g.
_L1D) and that method does a Notify() on the lid device. The lid device
gets the notification and tells power policy via /proc/acpi/event.

I'm not quite clear what is happening in your case. Can you elaborate
further?

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
