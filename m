From: Bernd Schubert <bernd-schubert-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Thinkpads running hot
Date: Mon, 22 Aug 2005 23:11:11 +0200
Message-ID: <200508222311.11759.bernd-schubert@gmx.de>
References: <43077C3C.5030501@suse.de> <43083B55.4000700@xms.se> <4308A3E6.7080002@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4308A3E6.7080002-l3A5Bk7waGM@public.gmane.org>
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
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello!

> But even I could find the EC address and value to set the fan on full spe=
ed
> (echo 0x2f 0x50 >/proc/acpi/ibm/ecdump - with ibm_acpi module)
> (>5000 instead of ~3700 rpm) , the machine still run very hot.

Blimey! Thomas, you can't imagine how happy you made me with this command. =
Not=20
that this special command works on my R31, but I never knew how to write da=
ta=20
to the EC-table. After the repair of my R31 (see below), they also adjusted=
=20
the fan-trigger temperatures *grumble* making the fan more or less always=20
running. It was rather easy to find the fan-trigger temperatures in the=20
ec-table and now I finally can adjust it to normal data.

>
> However, when passive cooling works well, people shouldn't notice much.
> It seems as if these machines are designed to work with OS thermal
> management. The userspace governor works nicely and temperature stays at
> passive trip point with 1200 instead of 1700 MHz (even on 70 C passive tp
> limit it stays at 1200 MHz poking around 70 C - default is 92 C).

Hmm, about two years ago I had the same problem on my R31. I sent it to=20
repair, wrote a nice explanation whats going on (about one a4-page), after=
=20
not having it back after two weeks I called the repair-centre, they connect=
ed=20
me with a technician - he didn't get my error-report, but when I explained =
=20
him about the problem, he then seemed to know what to do. I got back the=20
notebook two days after the phone-call, on the report about what they had=20
done was written that the cpu-cooler was not properly connected to the cpu.=
=20
Before the repair the cpu-temperature went up to more than 100=B0C, but now=
 I=20
can't get more than 80=B0C (at high load with fft calculations).
Maybe this is also an issue with recent thinkpads?

Cheers,=09
	Bernd


=2D-=20
Bernd Schubert
PCI / Theoretische Chemie
Universit=E4t Heidelberg
INF 229
69120 Heidelberg



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
