From: Arjen Verweij <sphere-4V0eaZAy+Mi7Qac5JyVuKSvJykC1LJ6w@public.gmane.org>
Subject: System no longer responds to magic packets after power down.
Date: Mon, 1 Dec 2003 02:34:24 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.10.10312010214310.13819-100000@vengeance.et.tudelft.nl>
Reply-To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
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

Hi,

I have a machine with an abit nf7-s motherboard in it. Debian sid runs
nicely on it, with a 2.4.22 kernel. There is a rather peculiar quirk with
Wake-on-LAN though. After power down from Linux, the box will no longer
respond to magic packets. This is only the case with power down from
Linux, and not from Windows. In order to be able to wake the box up again,
I have to power on/off the box.

I suppose something gets reset then, but I don't know what it is. Does
anyone have a clue where the problem might be? Personallly I think it
could be either ACPI or the binary driver from nvidia, although I don't
have a clue how the latter would waste the WOL function. It is just an
observation that the driver in W2K can detect if WOL is enabled or not.
Maybe it can turn it off as well?

To exclude the nvidia driver as the culprit, I tried to boot without the
nvnet module, shutdown and ether-wake. No dice. So now I am wondering
about ACPI.

The 2.4.22 kernel is vanilla, no patches applied. Should I file a
bugreport as described on the project pages?

Thanks for your effort.

Regards,

Arjen



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
