From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Slightly OT: Battery usage
Date: Mon, 6 Jun 2005 16:06:01 +0000
Message-ID: <200506061606.01346.stefandoesinger@gmx.at>
References: <m2br6jx2t1.fsf@phoenix.squirrel.nl> <42A4282C.7070808@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42A4282C.7070808-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Content-Disposition: inline
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
Cc: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Montag, 6. Juni 2005 10:40 schrieb Nils Faerber:
> Johan Vromans wrote:
> > Thanks to Rich Townsend's work I can now see the astounding speed at
> > which the Li-Ion battery of my Tavelmate degrades :-(.
> > Is there a usage pattern that minimizes this? For example, always keep
> > the batter maximally charged, or --the opposite-- always discharge fully
> > before charging?
>
> That is really OT but anyway interesting to PM so let's continue this.
>
> As to all I know about Li-Ion and Li-Poly batteries should:
>
> - not be stored fully charged, charge to 30%-40% and the store at a cool
> place, like your food fridge, but always above 0=B0C!
>
> - not be charged to full all the time. All Li-* batteries like only to
> be recharged after they have discharged for at least 10% or more (i.e.
> max. 90% remaining). Before that they should not be recharged to full
> again. Many notebook charging circuits do not honor this and kill their
> batteries within approx. one year (my Asus L3C did this, my Fujitsu
> Siemens Lifebook B-Series does not, IBM T42p does not, etc.)
>
> - be charged in at least two phases, first phase up to 75%-80% at full
> charging current, after that only a very weak charging current should be
> applied, like 10% of nominal current.
>
> - never be discharged completely, i.e. up to the point where the machine
> switches itself off.
>
> Every charge/discharge discharge cycle reduces your battery's life!
I've seen a really good website about LI-Ion batteries, but sadly, I've los=
t=20
the link :-(. It basically says the same things as Nils wrote, only with mo=
re=20
details.

=2D Some Linux-Side hints:
There's a Howto how to extend battery uptime:=20
http://www.tldp.org/HOWTO/Battery-Powered/index.html

=2D I've made the experiance(Acer TM 803) that hard drive standby can help =
A LOT=20
to improve battery uptime. I can reach up to 5h 30 min with the primary=20
battery only, compared to the advertised ~4h 30min.
I've tuned my memory mangement settings to avoid disc access, and I've neve=
r=20
had any problems, except with gaming. It's annoying of if the disc goes to=
=20
sleep and the game stopps 3 secounds to start the disc and load the sound o=
f=20
your enemy appearing.

=2D Lowering the display bightness also helps.

=2D Turn off / remove unnecessary hardware(wlan, bluetooth, cdrom). I like =
to=20
leave my DVD drive at home and insert a wight saver module or a secound=20
battery.

=2D Disable unnecessary logging, and enable DPMS. Lowering the cpufreq also=
=20
helps.

=2D Li-Ion batteries are very sensitive to too much heat. This is not only=
=20
important for storing the battery, a major factor is also the temperature=20
inside the laptop while the battery is in use. So if you can configure your=
=20
laptop to use less power you have a double payoff: It directly runs longer,=
=20
and it's better for your battery because it's much cooler.

=2D My battery shipped with my Travelmate has lost 90% of it's capatiblity =
after=20
1 1/2 year after ~500 recharge cycles.I've spent a lot of money into 2 new=
=20
batteries(1 primary and one secondary battery), and when tuning your hard=20
drive keep in mind that hard drives are not more expensive than batteries.

Cheers,
Stefan


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
