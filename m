From: David Sun <outfox-u2tTgNRCH2jM1kAEIRd3EQ@public.gmane.org>
Subject: Newbie question &machine don't power off with acpi
Date: 13 Nov 2004 01:06:22 +0800
Message-ID: <1100279182.3190.24.camel@outfox>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hi ACPIers

Sorry if this is a question/problem already discussed on this list, but
I am really new to ACPI, so I will appreciate if you could spend 5
minutes to save me 5 hours/days...

here is my situation:
a stripped 64MB linux on CF card
Phoenix BIOS(dont remember the exact version, but i am sure it's not on
the blacklist)
VIA Samuel 2 CPU
linux kernel 2.4.26

I first tried the kernel several days ago with acpi enabled, (ACPI
support buitin ,button support built in), it worked fine, powered off
decently with '/sbin/init 0'

After I took some effort to customize the acpi source code to reduce
kernel size to fit in the 64MB CF card, although the kernel compilation
was smooth, and booted successfully, it does not power off with
`/sbin/init 0`; instead, it just stands there with the last line "Power
Off"

I can't recall exactly what I have done, and don't like to go backward
to the original acpi code, any hint on how to debug acpi or what
information I should provide to the list for further help is highly
appreciated :)

thanks
David



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
