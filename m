From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Re: 2.6.9 S4: clock not updated after resume
Date: Tue, 26 Oct 2004 22:01:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <417EAD0D.1000200@pca.it>
References: <4177A9DC.7060503@pca.it> <20041021202051.GA21624@elf.ucw.cz> <4178C072.1020905@pca.it> <loom.20041023T170041-953@post.gmane.org> <417A99B4.40707@pca.it>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <417A99B4.40707-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 10/23/04 19:49, Luca Capello wrote:
> on 10/23/04 17:03, Jon Valvatne wrote:
>> Maybe I'm missing something here, but if the problem is that the
>> kernel doesn't update the system clock from the hardware clock on
>> resume, why bother with NTP? Can't you just do a hwclock --hctosys?
> well, I never did it because I didn't know this command, I'll try
> tomorrow and report :-)
'hwclock --hctosys' indeed did the trick :-)

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBfq0MVAp7Xm10JmkRAiYMAJ0YpRiDDvFCWusH29es4Y9QLl7tUwCfTme8
Vm9H2pjZ4Oj9CiBZMPsyRoc=
=Kbni
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
