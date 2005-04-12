From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI Suspend on Inspiron 1100
Date: Wed, 13 Apr 2005 01:07:29 +0200
Message-ID: <20050412230729.GA24414@elf.ucw.cz>
References: <20050331191931.GA16450@jose.lug.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050331191931.GA16450-0dTycEvvTfOQTptMt33A/4dd74u8MsAO@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org
Cc: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On =C4=8Ct 31-03-05 14:19:32, ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org wrote:
> Hello everyone,
>=20
> I have some questions on ACPI suspend on a Dell Inspiron 1100.  I have
> tried two different kernels: 2.6.8 (as comes with Debian sarge) and a
> 2.6.11.6 (which I built myself).  This is with BIOS A31.
>=20
> Neither one has working ACPI suspend, though the symptoms are different=
:
>=20
> 1) 2.6.8: putting the machine to sleep via proc/sysfs works, but the
> laptop immediately wakes back up.  It looks almost like some device is
> not going to sleep, generating activity, and then causing a wakeup.
>=20
> 2) 2.6.11.6: putting the machine to sleep via proc/sysfs works, but
> the machine never fully wakes up.  I can still login to a console and
> halt the laptop, but the display won't turn back on.  Switching
> to/from X11 VT doesn't seem to help.

Doc*/power/video.txt.

--=20
Boycott Kodak -- for their patent abuse against Java.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
