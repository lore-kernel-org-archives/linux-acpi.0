From: Jeremy Moles <jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org>
Subject: RAM > 1GB
Date: Wed, 02 Feb 2005 11:34:03 -0500
Message-ID: <1107362043.4512.11.camel@localhost>
Reply-To: jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org
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
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello ACPI gurus. :)

I have a Dell X300 here using a custom DSDT table appropriate with the
BIOS version. The trouble is, the system has an "unusual" amount of
RAM--so much so that it breaks ACPI and prevents a few things from
working. 128Mb of RAM is built into the motherboard and an additional
1Gb has been added.

When the system is booted WITH the additional RAM, I get a number of
errors. The dmesg file is here:

http://downloads.emperorlinux.com/research/ACPI/dmesg-bad

When the system is booted WITHOUT the additional RAM, everything works
as intended.

http://downloads.emperorlinux.com/research/ACPI/dmesg-good

I've also provided the DSDT table that I'm using, which can be found in
the same directory as the dmesg files.

I would appreciate any help on fixing this issue if anyone is available.
At any rate, keep up the good work! You guys make a lot of what we do
here possible!

>>cheers<<

-- 
Jeremy L. Moles
EmperorLinux
1-888-651-66
www.EmperorLinux.com
jeremy-LdSqz1EEwCk7YuNMryXyOw@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
