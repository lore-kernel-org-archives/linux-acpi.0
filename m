From: tierra.y.libertad-hi6Y0CQ0nG0@public.gmane.org
Subject: Re: No events when pressing power button
Date: Sat, 3 Aug 2002 21:44:06 +0200 (MEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020803194522.357575086@marcos.python.subname.de>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Linux ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Tony.Glader-cP9NhJtB8odr1ooMESYBxBZCeNDtXRbv@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On  2 Aug, Tony Glader wrote:
> On Fri, 2 Aug 2002, Aaron Gaudio wrote:
>=20
>> If you want to read from /proc/acpi/event directly, kill acpid.
>> Otherwise, the event will be consumed by acpid and you'll never see
>> anything on
>> /proc/acpi/event.
>=20
> Of course I killed acpid. Otherwise I just got something like 'Device
> or resource busy'.

Have you already tried an UP kernel without IOAPIC support?
My Dual PII board has the same problem but events are working without
IOAPIC interrupt routing.

> I also noticed that ACPI doesn't power off everytime my computer when
> I shutdown it. About in 50% shutdowns it powers off and 50% doesn't.

Same problem with my board. I posted it here several times, but it seems
that nobody has an idea about its solution.

--=20
R=FCdiger
--------------------------------------------------
pgp/gpg public-key at
http://home.htp-tel.de/ruedigerotte/key.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
