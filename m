From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: [RFC][PATCH 0/4] Software coordination of frequency across CPUs sharing common P-state
Date: Thu, 1 Sep 2005 11:04:36 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600598CC5B@scsmsx403.amr.corp.intel.com>
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
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: cpufreq <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shah, Rajesh" <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Dominik Brodowski
>Sent: Thursday, September 01, 2005 2:08 AM
>To: Dave Jones
>Cc: Pallipadi, Venkatesh; cpufreq;=20
>acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len; Shah, Rajesh
>Subject: [ACPI] Re: [RFC][PATCH 0/4] Software coordination of=20
>frequency across CPUs sharing common P-state
>
>On Thu, Sep 01, 2005 at 01:29:03AM -0400, Dave Jones wrote:
>> On Wed, Aug 31, 2005 at 02:09:33PM -0700, Venkatesh Pallipadi wrote:
>>=20
>>  > ACPI 3.0 (http://www.acpi.info) adds new methods with=20
>which BIOS can communicate
>>  > P-state dependency domains (List of CPUs that share a=20
>common P-state) to
>>  > the OS. This can be used in conjunction with the existing=20
>"cpu group awareness"
>>  > in cpufreq infrastructure, to manage the group of CPUs=20
>sharing the common=20
>>  > P-state, in a better way.
>>  >=20
>>  > The patchset that follows adds this=20
>"software-coordination" feature in=20
>>  > acpi-perflib, and also changes acpi-cpufreq and=20
>speedstep-centrino drivers to
>>  > use this feature.=20
>>=20
>> Patch 1 rejects against the latest git tree, due to Len's=20
>latest ACPI changes.
>> That (and possibly patch 4) need redoing.
>>=20
>> From a first look, these patches look ok to me, so if you=20
>rediff these,
>> and Len is happy with the ACPI changes, I'm happy to merge=20
>them for 2.6.14
>
>Patches
>
>Acked-by: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
>
>Nice work!
>

I had rebased my patch over Len's acpi-20050815-2.6.13 . Probably=20
some part of it is still not in git that is causing the conflict.=20
I will rebase the patch with latest git, before I resend the patch.

I have few minor comments from our internal review. I will respin=20
the patch, do some more testing and send it sometime next week.

Thanks,
Venki


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
