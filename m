From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: acpid and usb/ieee1394 hub problem
Date: Tue, 11 Nov 2003 01:00:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068505199.20290.14.camel@litshi.luna.local>
Mime-Version: 1.0
Content-Type: text/plain
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, thockin-xsfywfwIY+M@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I am not sure yet if this is an acpi or a kernel bug but I am hoping
someone here will have a better idea.

It seems that on some machines there is a problem inserting the usb and
the ieee1394 (firewire - I hope I got the number right).
I know of several other people who ran into this bug but I haven't managed
to verify yet if this happens on all machines or just some of them (I onl
ran into the usb bug since I don't have any firewire peripherals).

When loading the usbcore module (modprobe) using a script through acpid
events the module can't be unloaded later. It locks up on rmmod and is
marked deleted. The locking point is in drivers/usb/hub.c, function
usb_hub_cleanup, on the line:
wait_for_completion(&khubd_exited);
This was called from drivers/usb/usb.c, function
static void __exit usb_exit(void);
This happened both when acpid was run as a daemon and in debug mode
(doesn't daemonize).
I tried to write a small perl script that just polls /proc/acpi/event (both
daemon and interactive) that loaded the module on event and it seemed to
work fine. Looking into the acpid I couldn't see anything that looked
suspicious (didn't check the environment/socket setup before the fork/exec
though if that may cause a problem although it doesn't seem so).
It does work fine with a small perl script that does the same thing, so
the bug is with something acpid does.

Thanx



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
