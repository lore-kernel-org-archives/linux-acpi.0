From: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome+acpi-/zGXu1G9BXs@public.gmane.org>
Subject: Dell D600: teaching radeonfb how to wake up...
Date: Wed, 19 Nov 2003 19:01:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031119180119.GB22307@tate.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


Hi all.

I'm one of the many folks not really delighted with my dell d600's
behaviour w/ acpi.

I'm running 2.6.0-test9 ; S1 works more or less, if you care to shut
down usb and network before.

S3 works halfway. Meaning the ``going to sleep'' part works ;).  USB is
completely dead on bootup (megabytes of ``host controller halted''
messages), but that's not my #1 concern. My #1 concern is the radeon
9000 (M9) graphics card, which doesn't come up (fortunately, network is
relatively polite, and enables me to investigate). I'm not even talking
graphic mode.

There has been some short threads on the topic on this list before
( http://sourceforge.net/mailarchive/message.php?msg_id=6162540 ).

s3_mode and s3_bios reboot the box on wakeup.

There seems to be no other choice but to manually wake up & reprogram
the device. And to get the docs (I'm discussing with /dev/null at
ati.com on that. Maybe /dev/null, or some alternate source, will
provide me with a bit of info. Maybe).

Fortunately, the kernel tree contains bits of code which can be useful.
All the registers are known by name and number, for example (and it's a
pity that the documentation about the ``PWR_MAN'' register is
inexistent). And the radeonfb driver contains a few things and hints.
I'd gladly try a piece of code, supposedly coming from ATI, which ought
to reset the device somehow. This piece of code was to be linked to the
powerbook power management system, and is #if0'ed anyway since it is
quoted to be no cure for some problem. Still, I think it's worth trying.

I'm not an expert on kernel programming. On which code paths should I
plug things ? Say I have to functions radeon_go_sleep and
radeon_wake_up, what device info can I expect to access, and where
should I plug my functions ? Does anybody know of a well-educated fb
driver, where such a manual reset of the device is done on wakeup. I
could follow this as an example.

E.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
