From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fwd: Acer Extensa 3001 battery problem (smart battery)
Date: Mon, 13 Sep 2004 09:15:26 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305751B66C2@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johannes Schanda <johannes.schanda-1R9WWMedIqeELgA04lAiVw@public.gmane.org>
Cc: =?iso-8859-1?Q?David_G=F3mez?= <david-0d+f1cuTMnnk1uMJSBkQmQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Johannes Schanda wrote:
>Hi everyone,
>
>Ok, previous message was too big, I've changed the attachments to urls. =
If
>the
>other message comes through later, sorry about the double post.
>
>I have a problem with my Acer Extensa 3001 laptop. The battery and ac
>adaptor
>are not detected, i.e. the /proc/acpi/battery and /proc/acpi/ac_adaptor
>directories are empty. I've already tried fixing my dsdt (it contained =
3
>warnings), applying the ecdt fix from bugzilla.kernel.org and setting
>acpi_os_name boot paramter.
>
>After investigating my dsdt I'm pretty sure that I actually have a =
smart
>battery, I even tracked down the dsdt code for it:
>
>Device (EC0)
>                {
>                    Name (_HID, EisaId ("PNP0C09"))
>                    Name (_CRS, ResourceTemplate ()
>                    {
>                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
>                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
>                    })
>                    Name (_GPE, 0x1D)
>                    Name (OSEJ, 0x00)
>                    Device (SMBC)
>                    {
>                        Name (_HID, "ACPI0001")
>                        Name (_EC, 0x1820)
>                        Device (SBS0)
>                        {
>                            Name (_HID, "ACPI0002")
>                            Name (_SBS, 0x02)
>                        }
>                    }
>
The DSDT is the same as David G=F3mez's. Looks like many Acer notebook =
provide smart battery system.

>This section looks nearly identical to the smart battery example from =
the
>acpi 2.0 spec. Now my question is this: Is there anything left I can =
try,
>or
>does acpi4linux not support smart batteries yet? As far as I understand =
the
Linux doesn't support smart battery yet. Smart battery is more =
complicated than control method battery.

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
