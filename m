From: Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Subject: Re: s4bios: does anyone use it?
Date: Sat, 05 Mar 2005 22:08:06 +0100
Message-ID: <422A1FB6.3000504@ens-lyon.org>
References: <20050305191405.GA1463@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050305191405.GA1463-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek a =E9crit :
> Hi!
>=20
> Is there single user of s4bios? It used to work for me 4 notebooks
> ago, but I never really used it. I think I'm the only person that ever
> seen it working, but I could be wrong. Is there anyone using s4bios in
> 2.6.11?
>=20
> If not, I guess we should remove that code from kernel. It is not
> usefull, and it is likely broken.
> 								Pavel

Hi Pavel,

I always suspend my Compaq Evo N6OOc to disk using "echo 4b > /proc/acpi/=
sleep".
I don't remember the reason why I originally did choose this one instead =
of S4.
I just checked that S4 and S4Bios work the same on 2.6.11-mm1 (even with =
my
PCMCIA wireless card connected, great!).
 From what I remember, I didn't see any difference between S4 and S4Bios =
in
recent vanilla kernels.

By the way, it seems that Radeon makes suspend slower because it needs
to be blanked or something like that. Is there any way to avoid this ?

Regards

Brice


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
