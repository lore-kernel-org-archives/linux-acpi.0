From: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Subject: Re: Critical temperature even when idle with 2.6.7+patch, works fine in 2.4.26
Date: Fri, 2 Jul 2004 14:27:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040702122725.GD16229@rap.rap.dk>
References: <20040702094846.GB2141@torni>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040702094846.GB2141-WhBRsLHorrc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ville =?iso-8859-1?Q?P=E4tsi?= <drc-gbHDUNYU5Z6UJGkj1VpxcA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 02, 2004 at 12:48:47PM +0300, Ville P=E4tsi wrote:
> I have an Acer TravelMate 233xc laptop. The system cooling isn't handle=
d
> by ACPI. The system works fine in 2.4.26 and with moderate fan speed
> (judged by the sound) the system stays at around 60 degrees celcius.
>=20
> When I boot into 2.6.7 (with the 2004-06-21 patch) the system starts to
> heat up, atlest judging from /proc/acpi/thermal_zone/THM0/temperature .
> The fan also gets faster. The system load is basically none (No X
> running). Then the system reports it has reached the critical
> temperature of 80 degrees and shuts down.=20
> If I try to start the machine too soon after it does an emergency
> shutdown (instant power off) while the kernel is loading, so I guess
> it's not a temperature measurement error.  I don't have cpufreq running
> and /proc/cpuinfo reports 2.0GHz (which is the normal).

I have the same problem on an Acer Travelmate 233 XC (same model).
The system gets really heated under kernel 2.6.7, while under 2.6.3 it
runs much cooler. Also I see from metering power consumption that=20
it seems like the CPU does not do idle looping. It does not reach 80
degrees, but something like 65 degrees is common, while on 2.6.3 the
system stays about 48 degrees. I run X on the system, but the system is
quite idle.

best regards
keld


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
