From: "JP Mercury" <swirlee-HptHbbG/L9RWk0Htik3J/w@public.gmane.org>
Subject: Averatec laptop- acpi_power_off hang
Date: Wed, 2 Feb 2005 14:55:12 -0700
Message-ID: <20050202214755.M81868@stickist.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
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

Hi everyone,

I first posted to the list in December when I was having some trouble getting
an  Averatec 3250 laptop to report temperature. Thanks to Zhenyu Wang, that
problem was cleared with a change to my DSDT (scoping problem). 

Now I'd like to tackle the stubborn problem of powering off. Linux shuts down
but after acpi_power_off is called, it hangs. I tried the noapic, nolapic
kernel options as suggested for some other laptops- no go. Now I'm wondering,
could this be another DSDT problem? 

Here's my disassembled DSDT:
http://home.graffiti.net/swirlee/acpi-dsdt.dsl

There's also a problem with this laptop with other sleep states-- for example,
S3 seems to suspend (screen goes off, fans power down, power light flashes,
etc)  , but when I press a key the system reboots instead of resuming.

Any insight is much appreciated.

Thanks,
-Jan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
