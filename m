From: Mark Pritchard <mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org>
Subject: Re: Re: No battery information - Compaq Evo N800v, 2.4.20pre8, acpi 20021002
Date: Thu, 10 Oct 2002 21:43:50 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210102143.06104.mark.pritchard-acpi@modus.com.au>
References: <200210091825.LAA28601@ptolemy.la.asu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200210091825.LAA28601-iy676YoZKZKAgX/H7s3LlTe48wsgrGvP@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Kevin Schmidt <w9cf-iy676YoZKZKAgX/H7s3LlTe48wsgrGvP@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hey,

Thanks for writing back...much appreciated. I must admit, its quite over =
my=20
head, so when you say you know next to nothing, I'm waaay back at the=20
starting line!=20

I was wondering whether you could post your tweaked dst...I could take it=
 for=20
a spin and see how it goes.

I've also mailed Compaq requesting their AML for the N800V...might not ge=
t=20
anywhere, but it can't hurt.

Cheers

Mark

On Thu, 10 Oct 2002 04:25, Kevin Schmidt wrote:
> I have a Compaq evo n1000v which is very similar (the dsdt says n800).
> I am running 2.4.19+xfs+acpi-20020918 with a patched dsdt.
> The dsdt changes were:
> 1. Deleted the leading from variables flagged by errors as suggested
> in other messages to this list.
> 2. Added External definitions for variables not found
> and commented out the Alias line that caused a compiler error. This
> allowed the dsdt to compile with some warnings about missing return
> types. I tried adding zero returns to those, and the warnings went away
> but I could not detect any change in the way the machine ran.
>
> After the dsdt changes, the ac_adapter was detected properly and it det=
ects
> when it is plugged in or removed. The lid switch and the
> power button give events and I see /proc/battery, but the battery is
> not detected. There are still a couple of errors in dmesg from the
> dsdt.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
