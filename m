From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [SOLVED] RE: ACPI Hotkeys don't work with latest ACPIrelease
Date: Mon, 7 Feb 2005 13:21:49 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8407141CF4@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Good job. :-)=20

>-----Original Message-----
>From: Andrew Barr [mailto:barr.156-ZbGKxL/pcrQ@public.gmane.org]=20
>Sent: 2005=C4=EA2=D4=C27=C8=D5 2:24
>To: Yu, Luming
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [SOLVED] RE: [ACPI] ACPI Hotkeys don't work with=20
>latest ACPIrelease
>
>It seems that the DSDT for my laptop has changed. I had been using the
>copy I posted to the DSDT pages at acpi.sourceforge.net, but I
>discovered that a disassembled copy from /proc/acpi/dsdt was several
>dozen kilobytes larger. Fixing this one (same modification as before)
>and recompiling and inserting it into my kernel fixed this issue.
>
>My best guess as to why this is is that I replaced the Intel
>PRO/Wireless 2100 card in the notebook with an Intel PRO/Wireless
>2915ABG card. Interestingly, the new DSDT seems to cure the=20
>kernel panic
>that I saw using that card with NDISwrapper and WPA-PSK.
>
>Andrew
>
>On Sat, 2005-02-05 at 14:17 +0800, Yu, Luming wrote:
>> I mean the original one, and the modified one.
>
>
>


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
