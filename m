From: Michael Ost <most-NE/i7qws/Rdz3GwezmZiRw@public.gmane.org>
Subject: Re: HP XH545 laptop - boot fails with acpi on
Date: 31 Aug 2004 10:59:36 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093975176.1072.54.camel@ihop>
References: <1093631322.1083.22.camel@ihop>
	<037201c48cad$d8a52930$020ba8c0@SHERKA>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <037201c48cad$d8a52930$020ba8c0@SHERKA>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Ois=EDn?= Mac =?ISO-8859-1?Q?Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-08-27 at 20:19, Ois=C3=ADn Mac Fheara=C3=AD wrote:
> > and with acpi from 20020918.=20
>=20
> Uh. Have you tried a more recent one then? This is 2004 :)

Right. I was afraid the message would be confusing; too much discussion.

The exact same crash happens with a brand new, vanilla 2.6.7 kernel as
with the 2.4.19 kernel with the ancient ACPI patch. The ancient-ness of
the ACPI patch (and kernel) is, evidently, _not_ the problem.

My system hangs at bootup "Executing all device _STA and _INI
methods....." in 2.6.7.

- mo

ps: I am assuming that I don't have to patch 2.6.7 with ACPI...?=20



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
