From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: EC Confusion
Date: Thu, 4 Aug 2005 00:04:35 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC1F8@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Plese test linux-2.6.13-rc5. If you have regression , please try it with =
kernel option ec_polling.


Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Paulo Vitor Magacho da Silva
>Sent: 2005=C4=EA8=D4=C23=C8=D5 22:26
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] EC Confusion
>
>Hi,
>
>I am trying one more time to see if I can get ACPI working without any=20
>problems in my laptop. When I hit Fn+F4 (Sleep button) nothing=20
>happens. If I=20
>hit several times it starts working. If I hit Fn+F5 (to turn=20
>off the LCD) it=20
>confuses with Fn+F4. And if I hit a few times it starts to work.
>The last working kernel versions I had were kernel 2.6.7 and kernel=20
>2.6.12-rc2-mm2, but both of them present problems when=20
>resuming. The first=20
>one resumes but the ethernet card doesn't work properly and=20
>the second one=20
>reboots when resuming (it's a problem in the wakeup.S file=20
>that I couldn't=20
>figure out where yet).
>I've also tryed kernel 2.6.12 with the latest patches posted=20
>this week in=20
>the mailing list. Still the same problem.
>
>Thanks,
>Paulo
>
>_________________________________________________________________
>MSN Messenger: converse online com seus amigos . =20
>http://messenger.msn.com.br
>
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>from IBM. Find simple to follow Roadmaps, straightforward articles,
>informative Webcasts and more! Get everything you need to get up to
>speed, fast. =
http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
