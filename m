From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Sat, 05 Feb 2005 02:10:25 +0100
Message-ID: <42041D01.3010200@gmx.net>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>	 <9e47339105020321031ccaabb@mail.gmail.com> <1107528057.6191.128.camel@gonzales>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1107528057.6191.128.camel@gonzales>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Xavier Bestel <xavier.bestel-GANU6spQydw@public.gmane.org>
Cc: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Xavier Bestel schrieb:
> Le vendredi 04 f=C3=A9vrier 2005 =C3=A0 00:03 -0500, Jon Smirl a =C3=A9=
crit :
>=20
>>Doing this in user space lets you have two reset
>>programs, vm86 and emu86 for non-x86 machines.
>=20
>=20
> Perhaps only emu86 should be used, to have a well-debugged codepath on
> all archs (amd64, ppc, ...)
> As it's usermode, the code size is less of a problem.

Well, if it has to live in initramfs, it better be really small.
An initramfs with a size of 8 megabytes isn't going to make you
many friends.


Regards,
Carl-Daniel
--=20
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
