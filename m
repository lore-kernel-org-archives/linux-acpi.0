From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: generic ACPI video and hotkey drivers vs. platform-specific drivers
Date: Fri, 11 Mar 2005 18:43:46 +0100
Message-ID: <20050311174346.GA21611@message-id.gmane0305.slipkontur.de>
References: <200502230953.j1N9rPLp020723@shell0.pdx.osdl.net> <1109884125.2102.781.camel@d845pe> <20050306104506.GM3485@openzaurus.ucw.cz> <200503110407.50728.destynova@esatclear.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <200503110407.50728.destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
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

On Fri, Mar 11, 2005 at 04:07:50AM +0000, Ois=EDn Mac Fheara=ED wrote:
> On Sunday 06 March 2005 10:45, Pavel Machek wrote:

> > There's utility for X called "hotkeys"; it has hw-specific config fil=
es,
> > but on linux it should be possible to have one generic config file. X=
 are
> > usefull for displaying overlays telling you current volume setting, e=
tc.
> > 				Pavel
>=20
> I don't think so - I use hotkeys and I had to mess around with get/setk=
eycodes=20
> etc and basically mess around for quite a while with some Acer keyboard=
=20

What pavel wanted to say (IIUC) was, that there are already enough tools
for grabbing "generic" keys (AKA your keyboard) from the input system
and reacting on them, so routing ACPI hotkeys through the input layer
seems a good thing to do. I tend to agree.
=20
> So... it's a handy utility, but I can't see a "generic" solution (from =
my=20
> uneducated accidental wrist-putting-machine-to-sleep hassle point of vi=
ew).

maybe because your acer does not generate "normal" keystrokes for those
buttons but ACPI events? So you would benefit from these solution, too.
--=20
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
