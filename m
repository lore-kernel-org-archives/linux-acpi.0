From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Fri, 18 Feb 2005 00:52:00 +0100
Message-ID: <87y8dm4ue7.fsf@gismo.pca.it>
References: <20050214211105.GA12808@elf.ucw.cz> <87ekfe7p1v.fsf@gismo.pca.it>
	<20050217232932.GB29815@elf.ucw.cz>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
In-Reply-To: <20050217232932.GB29815-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org> (Pavel Machek's message of
 "Fri, 18 Feb 2005 00:29:32 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--=-=-=

Hi Pavel!

On Fri 18 Feb 2005 00:29, Pavel Machek wrote:
>> > Table of known working systems:
>> >
>> > Model                           hack (or "how to do it")
>> > ------------------------------------------------------------------------------
>> IBM ThinkPad T42p (2373-GTG [1])  acpi_sleep=s3_bios (2)
<cut>
>> I've a working S4 with the same configuration, too. But it seems I
>> still suffer a problem about hwclock I already reported with another
>> laptop [5] [6]. In this case, the command proposed seems not working
>> anymore (I should test more deeply, just a question of time ;-) ).
>
> Thanks for detailed report. Time problems should be solved in
> 2.6.11-rc4.

Ok, thank you for the info. The problem I'm not using the latest -rc
is that once I install ALSA-1.0.8, I suddenly get no more sound on the
speaker, but the sound is working (I can see the GNOME Volume Meter,
vumeter, moving, so there's sound output). I cannot find the problem
and I haven't had time to post on the ALSA mailing-list yet, so I'm
still on 2.6.10 :-(

But I'm compiling the latest -rc (with the latest ACPI patch 20050211)
just to make some more tests :-D

Thx, bye,
Gismo / Luca

PS, Pavel, I cced the ACPI-devel mailing-list to let other people
aware of the solution for my hwclock problem.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCFS4kVAp7Xm10JmkRAknwAJ4x36Sp8o9qVqZh9LF0sM2Fl5N0igCfRFq9
U9xDwD7frE30P1Akr3ZnDcY=
=92ip
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
