From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI very nearly working on Thinkpad 240x
Date: Mon, 3 Mar 2003 09:07:18 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84713810B@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Matthew Garrett [mailto:mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org] 

> Having upgraded my BIOS to the latest available from IBM, I've very 
> nearly got working ACPI.
> 
> 1) S1 usually works correctly, but the backlight doesn't get switched 
> off. Is there any trivial way of dealing with this?
> 
> 2) S3 suspends and resumes. On resume, the backlight comes back on the
> machine is responsive from the network. The keyboard and mouse don't
> work, though - if I use modular input drivers, a rmmod i8042 
> && modprobe
> i8042 brings things back to life. Switching on the Toshiba keyboard 
> kicking code doesn't result in any change in behaviour. The 
> symptoms are 
> that no input results in an increase in interrupts until I reload the 
> module. 

Given what I know about the state of the code, I am AMAZED you get even
this far. :) You are running into problems because your devices (mouse,
keyb, video) are not saving and restoring context properly on resume.
That code has yet to be written, although it's nice to know that
reinitializing seems to kind of work, too.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
