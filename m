From: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: RE: ACPI can't perform S5 soft off
Date: Tue, 8 Jun 2004 23:03:41 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0406082255390.5581@frog.athome>
References: <000801c44d5a$f99f0440$ba00a8c0@hasslemonkey.net>
 <20040608120259.I80205@root.org>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040608120259.I80205-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Gareth Wheelton <gareth-1LCzNYzl4/K5rx9LGsG9jg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Nate & Gareth,
On Tue, 8 Jun 2004, Nate Lawson wrote:
> On Tue, 8 Jun 2004, Gareth Wheelton wrote:
>> Kernel	= 2.4.26
>> Motherboard = Abit KT7-RAID with Bios Issue Date:2002/07/11
>>
>> Turns out configuring the kernel without CONFIG_RTC solved my problem.
>> Not sure about how CONFIG_X86_UP_APIC influences this problem as that
>> was unset already.
>>
>> If you have time please could you explain how these configurations have
>> prevented my machine entering S5.
>
> The question is, why does disabling the RTC affect S5?  I don't know how
> Linux handles GPEs but it sounds like it's not disabling/enabling the
> proper GPEs for S5 (based on lowest sleep state in _PRW).  Is this
> possible?

I did not investigate this further, on why the RTC-module is doing this. A 
week ago, we had this discussion on the list with the Acer TM-63x not 
powering-off. As mine did all the time, I suggested first to update the 
BIOS. But later we found out, that it was the RTC-module, that I did not 
use. BTW the generic-RTC-module is usable. My problem was, as I tried to 
reproduce this finding, it corrupted my ext2-filesystem. As I need this 
notebook for my work, I did stop going deeper into this... for the moment.

cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAximy9bBoTzOf1pMRArVwAKCG0cy1DBgmeacyEqDsnqxNhZmSnACgkUA/
OzGmpmQUjUH/ylaw6mhdlFA=
=E0pj
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
