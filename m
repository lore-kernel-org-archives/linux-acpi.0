From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: asus_acpi still broken on Samsung P30/P35
Date: Wed, 21 Dec 2005 10:37:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512211035370.4827@g5.osdl.org>
References: <200512211611.51977.mail@hboeck.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-456525677-1135190223=:4827"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200512211611.51977.mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Hanno_B=C3=B6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-456525677-1135190223=:4827
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id jBLIb8DZ021292



On Wed, 21 Dec 2005, Hanno B=C3=B6ck wrote:
>=20
> This is not "some minor issue", this completely breaks the usage of cur=
rent=20
> vanilla-kernels on certain Hardware. Can please, please, please anyone =
in the=20
> position to do this take care that this patch get's accepted before 2.6=
.15?
>=20
> The patch is available inside mm-sources or here:
> http://www.int21.de/samsung/p30-2.6.14.diff
>=20
> If I should send it to anyone else or if there's anything I can do to h=
elp=20
> fixing this, I'm glad to help.

Last I saw this patch, I wrote this reply (the patch above is still=20
broken). Nobody ever came back to me on it.

			Linus

---
Date: Tue, 13 Dec 2005 21:15:56 -0800 (PST)
From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>,=20
    Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,=20
    stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptops

On Wed, 14 Dec 2005, Carl-Daniel Hailfinger wrote:
>=20
> The patch has been tested and verified, is shipped in the
> SUSE 10.0 kernel and does not cause any regressions.

I'd be _much_ happier if

 - the patch wasn't totally whitespace-damaged (your mailer seems=20
   to not only remove spaces at the end of lines, it _also_ adds them to=20
   the beginning when there was another space there, as far as I can tell=
)

   Being right "on average" thanks to having two different bugs does not =
a=20
   good mailer make.

 - you were to separate out the oops-fixing code from the code that adds=20
   handling for that (strange?) model type logic.

   It seems that the _oops_ is because the later paths just assume that=20
   it's a ACPI_TYPE_STRING and will dereference "model->string.pointer"=20
   regardless of whether that is true or not. And you add a test for=20
   ACPI_TYPE_INTEGER, however, you do _not_ fix the oops for any other=20
   type, so the exact _same_ bug is still waiting to happen if there is=20
   some other strange ACPI table entry some day.

So I think the proper fix is to _first_ just do something like

	if (model->type !=3D ACPI_TYPE_STRING)
		goto unknown;

which should fix the oops (no?), and then handling ACPI_TYPE_INTEGER abov=
e=20
that as one case would be a separate patch.

		Linus

--21872808-456525677-1135190223=:4827--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
