From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M3N standby resume regression in 2.6.x -- works under
 2.4.x
Date: Fri, 14 Jan 2005 21:40:40 +0100
Message-ID: <41E82E48.6070403@pca.it>
References: <200501111652.28556.jcard@fe.up.pt>
 <20050112224425.GB2139@elf.ucw.cz> <200501141909.34406.jcard@fe.up.pt>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200501141909.34406.jcard-A1Gx7Te15Zc@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

on 01/14/2005 08:09 PM, Jo=C3=A3o Cardoso wrote:
> OK, I have compiled 2.6.11-rc1 without USB support.
<cut>
> ... e100_suspend+0x8b/0xe0
> ... e100_suspend...
> So, there is obviously a problem with the e100 network driver.
I think so, but have you tried with the eepro100 driver instead?

> S3 doesn't work either, but never worked, even in 2.4.xx
Have you searched on the mailing-list archive for my posts [1]? I had=
 an
M3N (M3410C) for a while and I tried sleep modes with different kerne=
ls.
I don't remember exactly the results, but IIRC S3 worked quite well. =
And
AFAIK Georg Greve made other tests with some positive results.

> What is the next step? A new laptop? WinXP? (sorry, but I'm not exa=
ctly=20
> happy)
No, I was very happy with this laptop, so I don't advice you to chang=
e it.

Thx, bye,
Gismo / Luca

[1] http://sourceforge.net/mailarchive/message.php?msg_id=3D6861190
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFB6C5HVAp7Xm10JmkRApI2AJ0b1TY2F6TAnG/wM0MPd0TxtmLvaACfayDH
3/lUUTZZ/IGL0nKwix3y3UU=3D
=3Drr/W
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
