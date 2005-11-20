From: Carsten Tschense <carsten-Bz3kcRWZgqLk1uMJSBkQmQ@public.gmane.org>
Subject: Re: ACPI on hp nx6125 doesn't update battery state
Date: Sun, 20 Nov 2005 11:13:36 +0100
Message-ID: <1132481616.8343.5.camel@localhost>
References: <3ACA40606221794F80A5670F0AF15F84041AC21F@pdsmsx403>
	 <1132444338.4120.12.camel@localhost>  <20051120065846.GA19063@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051120065846.GA19063-ORSVBvAovxo@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yes! ;) Read the mail from Luming Yu, I forgot to include it...



Am Sonntag, den 20.11.2005, 08:58 +0200 schrieb Ville Syrj=E4l=E4:
> On Sun, Nov 20, 2005 at 12:52:18AM +0100, Carsten Tschense wrote:
> > Hi,
> > thanks for your help! :)
> > I booted with that this morning and let the notebook running for abou=
t 5
> > hours without looking after it. ... It seems to be a bit dangerous as
> > the notebook was damn hot, the fan wasn't running. A "cat temperature=
"
> > helped again. It said 58=B0 for 2 minutes, that was defenatly wrong..=
.
>=20
> Have you tried using the ec_burst=3D1 kernel option? I have a few HP=20
> Omnibook 5x0/6x00 series laptops that require it to work correctly.
> Without ec_burst=3D1 battery, thermal, brightness keys etc. are all=20
> broken.
>=20
> PS.
> Big thanks to the ACPI people. The early ec_burst patches didn't work=20
> correctly with these laptops but now I'm running 2.6.14-mm1 and=20
> everything appears to work perfectly.
>=20



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
