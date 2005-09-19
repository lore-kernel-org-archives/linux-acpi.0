From: Fred Blaise <chapeaurouge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: battery life with cpufreq
Date: Mon, 19 Sep 2005 11:47:05 +0200
Message-ID: <9cfa150205091902472a50849e@mail.gmail.com>
References: <9cfa150205091902116057595e@mail.gmail.com>
	 <20050919092448.GA9023@isilmar.linta.de>
	 <9cfa150205091902354d5b4c43@mail.gmail.com>
	 <1127123139.11913.2.camel@nouse.net>
Reply-To: chapeaurouge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1127123139.11913.2.camel-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
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
To: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 9/19/05, Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org> wrote:
> Hi,
>=20
> On Mon, 2005-09-19 at 11:35 +0200, Fred Blaise wrote:
>=20
> [...]
>=20
> > ok.. So the fact that my CPU goes down to 383Mghz instead of the
> > normal 3Ghz is not frequency scaling? (pardon the noob that I am if
> > this question doesn't make sense)
>=20
> This is frequency scaling.  But it has nothing in common with
> throttling.
>=20
> Are you saying that you're stepping down from 3 GHz to 300 MHz and do
> not see any improvements regarding battery life time?
Yes.=20
`--> cat cpuinfo=20
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz
stepping        : 9
cpu MHz         : 382.040
[...]
>=20
> [...]
>=20
> See you,
>=20
>    Timo
>=20
>


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
