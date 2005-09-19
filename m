From: Fred Blaise <chapeaurouge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: battery life with cpufreq
Date: Mon, 19 Sep 2005 11:53:34 +0200
Message-ID: <9cfa1502050919025331a15ad0@mail.gmail.com>
References: <9cfa150205091902116057595e@mail.gmail.com>
	 <20050919092448.GA9023@isilmar.linta.de>
	 <9cfa150205091902354d5b4c43@mail.gmail.com>
	 <1127123139.11913.2.camel@nouse.net>
	 <20050919094827.GB26933@isilmar.linta.de>
Reply-To: chapeaurouge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050919094827.GB26933-JwFqNg2GrOVrgjWwlLH9qw@public.gmane.org>
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
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>, chapeaurouge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 9/19/05, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org> wrote:
> Hi,
>=20
> On Mon, Sep 19, 2005 at 11:45:38AM +0200, Timo Hoenig wrote:
> > > ok.. So the fact that my CPU goes down to 383Mghz instead of the
> > > normal 3Ghz is not frequency scaling? (pardon the noob that I am if
> > > this question doesn't make sense)
> >
> > This is frequency scaling.  But it has nothing in common with
> > throttling.
>=20
> No, p4-clockmod is frequency throttling or frequency modulation, but defi=
nitely
> not scaling.

Ok.. well.. speedstep* do not work here (my frequency will remain
stuck where it last was). On the other hand, p4_clockmod, i can see in
cpuinfo the frequency going up and down.

Here are the relevant modules loaded:
`--> lsmod=20
[...]    =20
speedstep_lib           3940  1 p4_clockmod
cpufreq_powersave       1632  0=20
cpufreq_userspace       4348  0=20
cpufreq_ondemand        6140  0
freq_table              4004  1 p4_clockmod
[...]

So you would be saying that even though I can see the frequency change
in cpuinfo, it is kind of "lying" to me? I can feel the difference
too, when I use the laptop. It definitly has the speed of a 383Mghz
when the cpuinfo shows it at that frequency..
Thanks
>         Dominik
fred
>


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
