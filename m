From: Jonas Petersson <zap-7RBX4Gk6oWI@public.gmane.org>
Subject: Re: Thinkpads running hot
Date: Sun, 21 Aug 2005 10:29:09 +0200
Message-ID: <43083B55.4000700@xms.se>
References: <43077C3C.5030501@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43077C3C.5030501-l3A5Bk7waGM@public.gmane.org>
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
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Thomas,

Thomas Renninger wrote:
> I got several reports of Thinkpads shutting down due critical temp limi=
t.
> Here are some more:
> [...]
> Still when the processor is on load the critical temperature is reached=
 quickly
> (1-3 minutes?).
>=20
> Thinkpads are widespread and I wonder whether others have experienced t=
hat problem
> and whether it only exists on current kernels or got it solved somehow.

Have these Thinkpads been in use for a while? My 1.5 year old ASUS would
occasionally turn off like that and initially I assumed it was either a
bug or my hardware being close to death. However, when I pulled it apart
I found that the way out from the fans were partially blocked by a layer
of dust.  After I cleaned that out it runs ~20 degrees cooler which
seems to solve the problem (and it is less noisy too).

In fact, it also seems to have solved my earlier suspend2 issue which
would have a seemingly random failure once every two weeks just when X
should be refreshed during the final stages of resume.

			Best / Jonas
--=20
Jonas Petersson  |  XMS Penvision  |  mailto:Jonas.Petersson-7RBX4Gk6oWI@public.gmane.org
Box 3294, V=E4stg=F6tegatan 13, S-600 03 Norrk=F6ping | http://www.xms.se=
/
Tel: +46 11 400 13 00 | Dir: +46 11 400 13 05 | Fax: +46 11 10 30 50


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
