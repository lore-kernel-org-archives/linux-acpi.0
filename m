From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: [SOLVED] RE: ACPI Hotkeys don't work with latest ACPI
	release
Date: Sun, 06 Feb 2005 13:23:33 -0500
Message-ID: <1107714213.22960.3.camel@localhost.localdomain>
References: <3ACA40606221794F80A5670F0AF15F84071415C1@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84071415C1@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It seems that the DSDT for my laptop has changed. I had been using the
copy I posted to the DSDT pages at acpi.sourceforge.net, but I
discovered that a disassembled copy from /proc/acpi/dsdt was several
dozen kilobytes larger. Fixing this one (same modification as before)
and recompiling and inserting it into my kernel fixed this issue.

My best guess as to why this is is that I replaced the Intel
PRO/Wireless 2100 card in the notebook with an Intel PRO/Wireless
2915ABG card. Interestingly, the new DSDT seems to cure the kernel panic
that I saw using that card with NDISwrapper and WPA-PSK.

Andrew

On Sat, 2005-02-05 at 14:17 +0800, Yu, Luming wrote:
> I mean the original one, and the modified one.




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
