From: "Gareth Wheelton" <gareth-1LCzNYzl4/K5rx9LGsG9jg@public.gmane.org>
Subject: RE: ACPI can't perform S5 soft off
Date: Tue, 8 Jun 2004 14:17:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000801c44d5a$f99f0440$ba00a8c0@hasslemonkey.net>
References: <Pine.LNX.4.60.0406072232180.5497@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0406072232180.5497-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
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

Hi Hartwig


Kernel	= 2.4.26
Motherboard = Abit KT7-RAID with Bios Issue Date:2002/07/11

Turns out configuring the kernel without CONFIG_RTC solved my problem.
Not sure about how CONFIG_X86_UP_APIC influences this problem as that
was unset already.

If you have time please could you explain how these configurations have
prevented my machine entering S5.

Yipppeeee! I don't need to read 397 pages of ACPI specification!



Cheers Gareth

P.S. if you are ever in London your 1st beer is on me ;-)

-----Original Message-----
From: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org [mailto:hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org] 
Sent: 07 June 2004 21:35
To: Gareth Wheelton
Subject: RE: [ACPI] ACPI can't perform S5 soft off


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Gareth,
On Mon, 7 Jun 2004, Gareth Wheelton wrote:
>  hwsleep-0304 [17] acpi_enter_sleep_state: Entering sleep state [S5]
did you try to disable APIC or RTC.
You did not mention, what hardware and kernel you are talking about.

Cheers ;-)
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693 For
the pulic keys, please visit my page. -----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAxNFu9bBoTzOf1pMRAkZDAKCrf36nkhVQIdKcUGfOVqIDLfgsGwCg2Oce
4ta1oGaZgb+QkxBpo6SXnjI=
=Isar
-----END PGP SIGNATURE-----




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
