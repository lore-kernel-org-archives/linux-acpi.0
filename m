From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 16:06:00 +0100
Message-ID: <42136158.5000906@gmx.net>
References: <20050214211105.GA12808@elf.ucw.cz> <e796392205021521541da7ee25@mail.gmail.com> <200502160948.43005.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <200502160948.43005.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Stefan D=F6singer schrieb:
>>The problems with this patch are:
>>- you need to press a key to come back from the "resume-console" after
>>resume. - DRI in X does not work (at least for me with intel-agp, other=
s
>>reportet it works)
>>I just disabloed it by not loading intel-agp (hotplug-blacklist)
>=20
> You can force the radeon X driver to use pci mode by setting Option=20
> "ForcePciMode" to "true" or something simmilar in you X config file. Th=
is way=20
> you can get dri without intel-agp. This is much slower, but enought to =
play=20
> tuxracer ;-)

How do I enable DRI with my card to test that crash? I have the
following in my XF86Config:

Section "DRI"
    Group      "video"
    Mode       0660
EndSection

but nothing else about DRI. So do I have to change something in
my configuration?

Oh, and could you please include run "lspci -vv" and include the
part about VGA compatible controller in your mail? I have some
hypothesis about the settings there having to do with resume.


Regards,
Carl-Daniel
--=20
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
