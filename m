From: Antoni Villalonga <frikimaster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Fri, 9 Sep 2005 23:59:55 +0200
Message-ID: <75eeb70e05090914594e3619ba@mail.gmail.com>
References: <41E81C2C.8010809@bartol.udel.edu>
	 <47e0449d05011419037877f931@mail.gmail.com>
	 <m2fz13x8mw.fsf@phoenix.squirrel.nl>
	 <41EA2C1D.3030909@bartol.udel.edu> <41EC7C7D.1070003@bartol.udel.edu>
	 <41EC9316.80109@bartol.udel.edu> <41EDE2EA.7090404@bartol.udel.edu>
	 <41EF1F6A.5000807@bartol.udel.edu>
	 <75eeb70e05090520257be89afa@mail.gmail.com>
	 <75eeb70e050906125344c326ad@mail.gmail.com>
Reply-To: frikimaster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <75eeb70e050906125344c326ad-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

2005/9/6, Antoni Villalonga:
> 2005/9/6, Antoni Villalonga:
> > I know about sbs-linux project in sourceforge, but I get a big delay
> > (about ~20 seconds) with my Acer TM 4001 when I try to read battery
> > status.
> >
> > There are any way to fix it?
> >
> > Thanks!!
>=20
> Thanks to Olaf and Yu!
>=20
> It doesn't work for me, I don't have more time today at weekend I'll retr=
y. :-)
>=20
> THANKS!!

It works now.

The delay of `cat /proc/acpi/battery/BAT0/state` its nearly 0.170 seconds.

Read form this file block my pc while it is reading.I advise it if i'm
moving the mouse or typing, it stop for a moment.

$ while true; cat /proc/acpi/battery/BAT0/state > /dev/null; done
It block totally the computer <:D

Thanks to all!

PS: I use linux-2.6.13

--=20
$ sh ~/.bash_history

Antoni Villalonga i Noceras
#Web# ~> http://friki.org
#Bloc# ~> http://bloc.balearweb.net/friki
#Jabber# ~> friki-STYuutOhSz/k1uMJSBkQmQ@public.gmane.org


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
