From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: RAM > 1GB
Date: Wed, 2 Feb 2005 18:07:00 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0502021802360.4159@frog.athome>
References: <1107362043.4512.11.camel@localhost>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
In-Reply-To: <1107362043.4512.11.camel@localhost>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jeremy Moles <jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org>
Cc: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Jeremy,
On Wed, 2 Feb 2005, Jeremy Moles wrote:

> I have a Dell X300 here using a custom DSDT table appropriate with the
> BIOS version.
So you will need to boot without DSDT-override with the additional RAM. 
Now extract the DSDT and apply your patches to it.
The DSDT is not a static thing - it is build on the fly, and takes the 
plugged in amount of RAM into account (if you do not override it).

Hope that helps
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFCAQjC9bBoTzOf1pMRApReAJwPgI1d0odbG+g4S8jGLeSbbGf7oQCgmxJs
fs+njdgPk80kKLWxDpbkoFM=
=gKdu
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
