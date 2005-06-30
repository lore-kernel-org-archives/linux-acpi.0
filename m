From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: FW: Bug with ACPID under FC4
Date: Wed, 29 Jun 2005 20:41:52 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3003F443EA@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

FYI,
FC4's selinux vs acpid:

-----Original Message-----
From: Lance Mosher [mailto:lance.mosher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]=20
Sent: Wednesday, June 29, 2005 2:31 PM
To: Brown, Len
Subject: Re: Bug with ACPID under FC4

Hi Len,
Thanks for getting back to me so quickly!
I just did a search with selinux and acpid and turn out selinux in FC4
puts some pretty harsh restrictions on the acpid (like i/o access,
apparently). The fix is to just to tell SELinux to leave acpid and
apmd alone:

If anyone runs into this in the future just tell them to
system-config-securitylevel and then go to the SELinux tab and in the
list open SElinux Service Protection and check the 'Disable SELinux
protection for apmd daemon' box.

Follow this thread for more info:
http://lists.suspend2.net/lurker/message/20050616.014202.5d0ab62e.en.htm
l

Thanks again,
-Lance

On 6/29/05, Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Maybe some of those security enhancements in FC4?
>=20
> Have you tried booting with selinux=3D0?
>=20
> -----Original Message-----
> From: Lance Mosher [mailto:lance.mosher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Wednesday, June 29, 2005 2:04 PM
> To: Brown, Len
> Subject: Fwd: Bug with ACPID under FC4
>=20
> Len,
> I hope you can help me with this since Tim's mail bounced back. I'm
> running the latest FC4 kernel, just so you know.
> Cheers,
> -Lance
>=20
> ---------- Forwarded message ----------
> From: Lance Mosher <lance.mosher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date: Jun 29, 2005 1:57 PM
> Subject: Bug with ACPID under FC4
> To: Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
>=20
>=20
> Hi Tim,
> I wouldn't bother you if I hadn't tried every conceivable way to fix
> this problem. I'm using acpid to run a script that reads and writes a
> file based on the ac adapter state. In Fedora Core 3 everything worked
> beautifully.
>=20
> In FC4 I'm getting some peculiar permission denied problems from the
> event handler. Basically at the beginning of the script I'm trying to
> read a text file using "read VARIABLE < /file", but the handler gives
> a permission denied error. The script is in bash and the file and
> directories have full permissions to everyone. The script executes
> fine as run by either my username or as root.
>=20
> I've talked to the folks in #bash on irc.freenode.net and they thought
> I was pulling their chain. I've tried calling the script from my
> username in the event file as: action: su username -c "bash
> /scriptfile/", but the su asks for a password...
>=20
> Either way, the script seems to run as root, but has less access to
> the filesystem than my own username. Is there a way to give acpid more
> access?
>=20
> Thanks much,
> -Lance
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
