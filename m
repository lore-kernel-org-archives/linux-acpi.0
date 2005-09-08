From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [GIT PATCH] ACPI for 2.6.14
Date: Thu, 8 Sep 2005 04:55:13 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F06@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>>
>> I saw lots of transient battery issues from 2.6.13-rc3
>>  until 2.6.13-rc6, but the ones I followed went away
>>  as of 2.6.13 final.  Do you have your eye on others
>>  besides 4980?
>
>Not specifically, but then ACPI bugs are the one sort which I=20
>don't track.=20
>a) because there are so many and b) because the ACPI team use bugzilla
>well.

In the last 5 weeks we've reduced our unresolved bug count
to 160 from 196 -- even as 50 new sightings rolled in:

 9/8/05:	739	Resolved	160	Unresolved	899	Total
 8/31/05:	733	Resolved	161	Unresolved	894	Total
 8/24/05:	721	Resolved	166	Unresolved	887	Total
 8/17/05:	694	Resolved	181	Unresolved	875	Total
 8/10/05:	666	Resolved	194	Unresolved	860	Total
 8/3/05:	653	Resolved	196	Unresolved	849	Total

>Sticking "battery" into the bugzilla Summary field turns up a few.=20
><vague>There seem to have been four or five reports in recent weeks.

<specific:->
We have a bugzilla category for battery issues.
There are 12 open, 4 of them resolved -- 3 of those
fixes are included in the proposed patch:
http://bugzilla.kernel.org/show_bug.cgi?id=3D4892
through the ec_burst=3D1 fix is still optional:
http://bugzilla.kernel.org/show_bug.cgi?id=3D3851
http://bugzilla.kernel.org/show_bug.cgi?id=3D3974

I think it makes sense to proceed to get broader
testing on the latest code.  We're not getting
new failure reports from -mm.

Indeed, I'd like to try enabling the new ec_burst=3D1
by default in -mm.  It is not perfect, but it works
for me, so it should do much better than the 2.6.13-rc3 attempt.

We'll keep ec_burst=3D0 as the default in Linus' tree
for now.  The systems that require ec_burst=3D1 will
have to supply it manually for now, which is better
than not having it all per 2.6.12.

thanks,
-Len


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
