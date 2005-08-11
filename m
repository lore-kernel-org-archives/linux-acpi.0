From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Thermal trouble on 64-bit
Date: Thu, 11 Aug 2005 22:05:59 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC1FA@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: Johan Brannlund <johan_brn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Please try 2.6.13-rc6 and option ec_burst=3D1
The patch at http://bugzilla.kernel.org/show_bug.cgi?id=3D3851=20
could help.

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Johan Brannlund
>Sent: 2005=C4=EA8=D4=C28=C8=D5 4:19
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Thermal trouble on 64-bit
>
>Since I didn't get a reply the first time, I thought I'd try to provide
>some more information in the hope that someone will take pity on me.
>The thermal control on my AMD Turion HP 6125 laptop doesn't work quite
>right.=20
>The fan often gets "stuck" on whatever speed it had initially and the
>temperature readings also often do not change after a few minutes of
>running. Doing "rmmod thermal; modprobe thermal" makes the temperature
>readings in /etc/acpi/thermal/ start updating again, at least for a few
>minutes when I have to repeat the procedure. The kernel is Ubuntu's
>2.6.12-6-amd64-k8. Maybe I should mention that I have to boot the
>kernel with "noapic" to get it to run at all.
>
>Does anyone know what might be causing this?
>
>- Johan
>
>
>
>
>
>
>	=09
>____________________________________________________
>Start your day with Yahoo! - make it your home page=20
>http://www.yahoo.com/r/hs=20
>=20
>
>
>-------------------------------------------------------
>SF.Net email is Sponsored by the Better Software Conference & EXPO
>September 19-22, 2005 * San Francisco, CA * Development=20
>Lifecycle Practices
>Agile & Plan-Driven Development * Managing Projects & Teams *=20
>Testing & QA
>Security * Process Improvement & Measurement *=20
>http://www.sqe.com/bsce5sf
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
