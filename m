From: Gertjan <g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>
Subject: Asus ACPI Hotkeys
Date: Sat, 3 May 2003 11:26:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030503112602.3d2ac1c3.g.zwartjes@student.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I recently bought an Asus Laptop from the L3 series. It has hotkeys, or
multimedia buttons, for volume up, down, mute, internet, mail etcetera.
Especially the volume up, down and mute are the buttons I would like to
see working.

After some research I found out that these buttons are ACPI buttons. In
Windows Asus has a driver which handles the buttons with a nice OSD
interface. But as I use Linux and not Windows, I can't use these buttons
since they are not currently supported. There are loads of programs to
assign commands to special buttons ('hotkeys', 'lineakd', etcetera), but
the problem is, that my buttons do not generate scancodes, because they
are ACPI buttons.

I really would like to have them working. I'm prepared to write a driver
for them if needed and that's why I'm posting this request. Can somebody
help me, where to start, which steps to take? I'll post my results and I
hope that eventually the buttons will get supported in the ACPI patches.

Regards,

Gertjan



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
