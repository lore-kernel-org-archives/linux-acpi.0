From: Chris Hellberg <chris-f+BL+UTttwNjFI1wkQMVnwC/G2K4zDHf@public.gmane.org>
Subject: ACPI fan not always working
Date: Thu, 11 Nov 2004 00:47:35 -0800 (PST)
Message-ID: <20041111084735.48153.qmail@web51503.mail.yahoo.com>
Reply-To: chris-f+BL+UTttwNjFI1wkQMVnwC/G2K4zDHf@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm currently running  2.4.27 kernel (from the
mainline) and am finding that in some cases, the OS
doesn't turn the fan on via ACPI on my Fujitsu S6130
Laptop. Usually a reboot fixes it and the fan starts
whirring like mad for a bit to lower the temp.

Other ACPI info is output (such as battery info) from
the /proc filesystem. The /proc/acpi/fan directory is
present but empty. I'm not sure if it has entries when
the fan is working. I can't find any userspace tools
to activate the fan manually. Are there any around,
and to help fix this problem (if it's a bug), what
additional info do you guys need?

Couple of things that look devel-like:
chrish@lappy:/proc/acpi$ cat debug_layer
0xffff3fff
chrish@lappy:/proc/acpi$ cat debug_level
0x0000000f
chrish@lappy:/proc/acpi$

Cheers,

Chris


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
