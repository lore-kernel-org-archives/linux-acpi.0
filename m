From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI on Intel SE7501WV2
Date: Sun, 10 Oct 2004 09:10:42 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305754574D8@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: Bernard Normier <bernard-jCTGDdqZGLzlLTHTg0CpQwC/G2K4zDHf@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>The Intel SE7501WV2 is a dual Xeon server motherboard. Power management
is
>not a concern ... but stability is. When I boot with 2.6.8-1.521smp
(latest
>Fedora Core 2), or my own 2.6.9-rc3 smp kernel build, the log shows 2
>ACPI-related issues:
>
>- with USB enabled in the BIOS, dmesg shows:
>
>hub 2-0:1.0: USB hub found
>hub 2-0:1.0: 2 ports detected
>irq 169: nobody cared! (screaming interrupt?)
>irq 169: Please try booting with acpi=3Doff and report a bug
> [<021074d6>] __report_bad_irq+0x3a/0x77
> [<02107572>] note_interrupt+0x43/0x66
> [<021078c4>] do_IRQ+0x19d/0x225
>handlers:
>[<0225a679>] (usb_hcd_irq+0x0/0x4b)
>Disabling IRQ #169
What's the result if you disable 'CONFIG_PCI_MSI'?


>PCI: PCI BIOS revision 2.10 entry at 0xfdb75, last bus=3D4
>PCI: Using configuration type 1
>mtrr: v2.0 (20020519)
>ACPI: Subsystem revision 20040326
>    ACPI-0562: *** Warning: Type override - [DEB_] had invalid type
>(Integer) for Scope operator, changed to (Scope)
>    ACPI-0562: *** Warning: Type override - [MLIB] had invalid type
>(Integer) for Scope operator, changed to (Scope)
>    ACPI-0562: *** Warning: Type override - [DATA] had invalid type
(String)
>for Scope operator, changed to (Scope)
>    ACPI-0562: *** Warning: Type override - [SIO_] had invalid type
(String)
>for Scope operator, changed to (Scope)
>    ACPI-0562: *** Warning: Type override - [LEDP] had invalid type
(String)
>for Scope operator, changed to (Scope)
>    ACPI-0562: *** Warning: Type override - [GPEN] had invalid type
(String)
>for Scope operator, changed to (Scope)
>    ACPI-0562: *** Warning: Type override - [GPST] had invalid type
(String)
>for Scope operator, changed to (Scope)
>    ACPI-0562: *** Warning: Type override - [WUES] had invalid type
(String)
>for Scope operator, changed to (Scope)
>    ACPI-0562: *** Warning: Type override - [WUSE] had invalid type
(String)
>for Scope operator, changed to (Scope)
>    ACPI-0562: *** Warning: Type override - [SBID] had invalid type
(String)
>for Scope operator, changed to (Scope)
>    ACPI-0562: *** Warning: Type override - [SWCE] had invalid type
(String)
>for Scope operator, changed to (Scope)
>ACPI: Interpreter enabled
The error message possibly isn't harmful. Please latest kernel.

Thanks,
Shaohua


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
