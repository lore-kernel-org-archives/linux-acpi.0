From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Re: first shoot for smartbattery
Date: Mon, 3 Jan 2005 18:02:59 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0501031751590.5329@frog.athome>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt>
 <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org>
 <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl>
 <20050103143902.GQ19199@poupinou.org> <41D95CDC.8050802@phys.ethz.ch>
 <41D95F53.5000008@tiscali.be> <41D967B5.7040002@tiscali.be>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811592-1589536157-1104771779=:5329"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41D967B5.7040002-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811592-1589536157-1104771779=:5329
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by post.webmailer.de id j03H39FC009911

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Fran=E7ois,
On Mon, 3 Jan 2005, Fran=E7ois Valenduc wrote:
> ...
> however the value for "time to empty" seems more correct.

> results with the AC adapter unplugged:
>   current:       64345 mA
>   remain:        6327 mA or mWh
>   time to empty: 221 minutes
>   time to full:  221 minutes
>   temperature:   27.4 C
>   voltage:       16589 mV
> And with the AC adapter plugged:
>   current:       0 mA
>   remain:        6330 mA or mWh
>   time to empty: 65535 minutes
>   time to full:  65535 minutes
>   temperature:   27.4 C
>   voltage:       16809 mV
> I don't really understand why each time the time to full or to empty ar=
e the=20
> same. I tried it knowing my battery was fully loaded so I should get 0 =
minute=20
> for time to full.
I did not look into the source... but usually the times are calculated:
You take the capacity (remain-value) and divide it by the current. As the=
=20
ACPI-1.0 spec only asks for a current-value, if you use a=20
rechargable-battery and if this is in discharging-mode, you see, that the=
y=20
did only, what the specs asked as a minimum.  I am not sure, if the=20
current-value would not need to be -1, if it is unknown however.
So it is quite clear, that dividing something (especially if this itself=20
is not zero) by zero will give you an +overflow... with MAX_UINT (65535=20
for 16bit) is the nearest representable value.

Cheers
   hartwig felger

Hartwig Felger informatics

- --=20
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFB2XrI9bBoTzOf1pMRAgMjAKDbqUvfvroCvKk63ntxTxxSru9H8wCgrlr8
Ro5LxZQc1D5jkA6RSdOiAKI=3D
=3Ds2U+
-----END PGP SIGNATURE-----
---1463811592-1589536157-1104771779=:5329--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
