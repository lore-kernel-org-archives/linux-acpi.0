From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Battery Level Reported Incorrectly
Date: Wed, 02 Feb 2005 15:53:01 -0500
Message-ID: <1107377581.6619.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hi.

I'm using ACPI 20050125 on a Dell Inspiron 300m (BIOS A07) with a 2.6.10
kernel, and a patched DSDT (http://acpi.sourceforge.net/dsdt/view.php?
id=218). The battery's charge is being reported incorrectly--I at first
thought my battery had gone bad until I accessed the battery level page
in the BIOS setup, which reported the correct information. The battery
is reported as completely dead (e.g. "remaining capacity"
in /proc/acpi/battery/BAT1/state is 0 mAh) if the AC adapter is plugged
in and 257 mAh as soon as I unplug the adapter. This is incorrect--the
BIOS setup utility reports 100% charge. ACPI status reporting tools
(like the GNOME battery status applet and the "acpi" command) reflect
this in their percentanges. The battery's "info" entry:

present:		yes
design capacity:	1799 mAh
last full capacity:	1799 mAh
battery technology:	rechargeable
design voltage:		14649 mV
design capacity warning:180 mAh
design capacity low:	54 mAh
capacity granularity 1:	1 mAh
capacity granularity 2: 1 mAh
model number:
serial number:
battery type:		LION
OEM info:		DELL Computer Corporation

Windows was on this laptop for a few months before I installed Linux,
could that have anything to do with it? I'm afraid I don't know enough
about how ACPI works to know if that's a factor or not. As far as I
know, this is a new problem because most of the ACPI quirks had gone
with the previous ACPI release I had used (not sure exactly of the
version: probably 20041202).

Thanks for any help,
Andrew	



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
