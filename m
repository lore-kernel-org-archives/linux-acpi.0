From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: CUR-DLS blacklisted? + IRQ trouble
Date: Sun, 22 Feb 2004 23:08:11 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4039365B.6090105@mega.ist.utl.pt>
References: <402F823D.6070702@mega.ist.utl.pt> <1077079669.4948.24.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1077079669.4948.24.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi len,

i tried to file the bug report with no success...

first it was too long, and then i kept getting "internal server error"
from the bugzilla server, until i quit.

i have the whole post backed up on my desktop, so i can send it directly
to you... or you can suggest something else.

[]

Len Brown wrote:

| Pedro,
| We got that entry from UnitedLinux last August.
|
| It is quite possible that the system is unjustly blacklisted, or that it
| was blacklisted out of convenience b/c nobody could figure out exactly
| what was wrong when ACPI on that system failed.
|
| I'll be happy to look into it if you're willing to file a bug and help
| me debug to make a proper diagnosis.
|
| thanks,
| -Len
| ---
| How to file a bug against ACPI:
|
| http://bugzilla.kernel.org/ Category: Power Management, Component: ACPI
|
| Please attach dmesg -s40000 output (or serial console log if dmesg
| unavailable)
| Please attach copy of /proc/interrupts if possible
|
| Please attach the output from acpidmp, available in /usr/sbin/, or in
| pmtools:
| http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
|
| Please attach the output from dmidecode, available in /usr/sbin/, or
| here:
| http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
|
| Please attach the output from lspci -v
|
|
|
| On Sun, 2004-02-15 at 09:29, Pedro Venda wrote:
|
| hi everyone,
|
| i have two questions to which i haven't found answers anywhere, so i am
| asking here.
|
| - i have an ASUS CUR-DLS motherboard (dual P3) and the 2.4 and 2.6
| kernels both say: "ASUS CUR-DLS detected: force use of acpi=ht" when
| starting disabling ACPI. i must do a acpi=force in order to be able to
| use it, which consequences i don't know. i looked through the acpi
| documentation and this board is NOT on the blacklist. i am asking why
| does the kernel disable ACPI on my mb by default? what's wrong with it?
| are there any known problems?
|
| - on the same machine, i have 2 nics. one of them is onboard (intel
| eepro/100) and the other is a realtek 8139. they used to work ok with
| some versions of the kernel, but now they only work together without
| ACPI. with acpi, the realtek displays the famous SIOCIFADDR "device is
| busy...". is this normal? what can be happening here?
|
| thanks for your time.
| regards,
| pedro.

- -------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel




| -------------------------------------------------------
| SF.Net is sponsored by: Speed Start Your Linux Apps Now.
| Build and deploy apps & Web services for Linux with
| a free DVD software kit from IBM. Click Now!
| http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
| _______________________________________________
| Acpi-devel mailing list
| Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
| https://lists.sourceforge.net/lists/listinfo/acpi-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAOTZbeRy7HWZxjWERAl3xAJ4vjSrqzfkNsqUIJBJUPfNh7fR9+wCeNRc2
dfkBqul5JxyCRziCt5zohUk=
=2N1O
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
