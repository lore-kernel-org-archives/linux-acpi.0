From: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-/zGXu1G9BXs@public.gmane.org>
Subject: Re: D600: S1 and S3 resume
Date: Tue, 25 Nov 2003 13:57:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031125125723.GA5591@tate.loria.fr>
References: <Pine.LNX.4.30.0311251150140.19330-100000@pcd403z.vsb.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0311251150140.19330-100000-Rd/Vp7eeBLeOZheNW5JDhQ@public.gmane.org>
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


>   I tested the patch for xfree radeon_driver.c, and now video wake up
> after resume from S3.  But system is terrible slow. CPU is half second
> working and half second is stopped. I have kernel 2.6-test10, bios A05.
 
>   I have problem with resume from S1 and S3, when uhci-hcd and sound
>   card is loaded. When D600 resume from S1, display "back to C!", "set
>   pci latency 00:1d.0, 00:1d.1 and 00:1d.2 to 64" and hang.  When
>   resume from S3 I have black LCD and do not see anything.  (I have to
>   say, that 00:1d.0-1-2-7 are usb devices on pci.)
 
I now have a patch for this (it's one single problem : your cpu is very
busy on irq11 dealing w/ usb panic messages. Look up your syslog, you'll
get an idea). You'll have to wait a few jiffees for the patch though, as
I'm on the road right now.

The patch in question is more exactly a kludge than a real cure of the
problem. It seems that on S3 resume, the ehci hcd is fine, but two of
the three uhci hcd's wake up in a messy state. Disabling them when such
a messy state is detected does the trick (hunt for USBCMD_HCRESET in
uhci-hcd.c, IIRC).

 
>   What kernel is at this moment the best choice for D600? 2.4 or 2.6? What
> you are using and your experiences with suspend?

2.6, definitely. Unless you're happy with S1.

A short data: My laptop draws ~16W when running, and this goes down to
0.4W on S3.

 
>   And back to patch for X. I debug the code and ax, bx, cx, dx items in
> Int10 struct are zero. The "->num-0xe6" is little mystery for me.


Err, ole ? (I bloody don't know the answer. The last time I did real
mode vesa programming was a looooong time ago).


>   I did try call Int 10h using "lrmi" - linux real mode interface, but
> it failed (SIGSEGV), when try outw to some port.

You probably have to resort to a couple of hacks in order to have your
real mode thingy (a virtual machine, I presume) access IO ports.

> And last information: when I suspend to S3 in "Dock", after resume is
> display ok, even I remove the notebook from dock before wakeup. But CPU is
> slow.

See above.

> I did ask dell about more technical informations about D600, but they
> did say me, that all technical delatils are marked internally
> "confidential" and nobody can share them. I hope Dell will change your
> restriction and improve support for linux.

Very expectable from canned_answers_daemon-QXIuMnnTXwEAsOHDdpmTTuG/Ez6ZCGd0@public.gmane.org

E.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
