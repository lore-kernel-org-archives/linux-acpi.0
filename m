From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.14-rc4-mm1, acpi, irq problems, hdc (cdrom) dead
Date: Mon, 17 Oct 2005 18:38:33 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3004E6C758@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>Since some kernel revisions (hard to tell since when, I don't use cdrom
>very often), the cdrom hdc is not working any more:
>
>vmunix: hdc: lost interrupt

> 2.6.14-rc4-mm1

Can you try vanilla 2.6.14?

If 2.6.14 works, then does 2.6.14-rc4-mm1 with git-acpi.patch backed out =
work better?:
http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4=
/2.6.14-rc4-mm1/broken-out/git-acpi.patch

If 2.6.14 fails, does 2.6.13 work better?


> Kernel command line: BOOT_IMAGE=3D2.6.14-rc4-mm1 ro root=3D303 lapic
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!

forcing the LAPIC to be enabled when the BIOS didn't enable it
is risky -- you're asserting that you know more
about the hardware than the BIOS writer knew.

Do you still have the issue without the "lapic" boot option?

>     ACPI-0284: *** Info: Table [DSDT] replaced by host OS

You're somewhat on your own here since you've replaced the OEM's =
firmware.
Do you still have the issue without replacing the BIOS?

cheers,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
