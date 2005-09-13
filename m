From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [Acpi4asus-user] Re: Re: [PATCH] Fixed buffered ACPI events for a lot ASUS machines
Date: Tue, 13 Sep 2005 22:21:50 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC209@pdsmsx403>
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
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, jfvasconcelos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>ec_burst patch will be enabled in SUSE Linux 10.0 by default.

Great!

Please check patch link at :
 http://bugzilla.kernel.org/show_bug.cgi?id=3D3851#c73

The same patch against Lindent-ed ec.c is at:
 http://bugzilla.kernel.org/show_bug.cgi?id=3D3851#c75

>Beside lost mouse/key-strokes on some specific machines (also=20
>happen with=20
>ec_burst=3D0), I don't know of any greater harm ec_burst causes.
>If you know any other issues I'd appreciate if you let me know.

After fixing the infamous regression of old burst mode ec patch,
the latest burst mode ec driver has been validated on pretty much boxs.
(One example is  http://bugzilla.kernel.org/show_bug.cgi?id=3D4665)

And, I don't know other regression could exist. So, I think this patch
is safe.
If you know it,  please drop me a link to bug report.  It's really
appreciated.

As for lost mouse/key-strokes issues,  the root cause is quite
complicated.
the latest ec driver has eliminated  the long delay of polling ec status

while holding spin lock. So, the latest ec driver itself shouldn't hang
system
a period that causes mouse/key lost.

In case you unluckily encounter problem with ec_burst=3D1, please also
test ec_burst=3D0. If ec_burst=3D0 works and ec_burst=3D1 doesn't, then=20
it is a regression with ec_burst=3D1.=20


Thanks,
Luming


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
