From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi problem -- Error: Handler for [EmbeddedControl] returned AE_TIME
Date: Mon, 5 Sep 2005 13:29:16 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30047FA172@hdsmsx401.amr.corp.intel.com>
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
To: u15119-4pcC6BA0Z1GELgA04lAiVw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>> Sounds like you are running the latest.
>Right.
>
>> What is the most recent kernel or patch where the battery
>> worked and you didn't get these messages?
>No idea yet but I guess 2.6.11.

It would be really helpful if you can revert the ACPI
patch from your 2.6.13 kernel and report how vanilla
2.6.13 does.

If 2.6.13 works, then we need to find out
why the latest ACPI patch breaks the default ec_burst=3D0
mode -- because we're not ready to deploy ec_burst=3D1 by default.

If 2.6.13 fails, then we need to go back and try 2.6.12.
If 2.6.12 works then we a need a fix for 2.6.13.1.

If 2.6.13 fails, and 2.6.12 fails, it would be helpful
if you can confirm if 2.6.11 works or not -- ie has this
box always been broken, or did we regress someplace?

Note that some of this may depend on the version
of your BIOS, so it would be good to verify that you're
running the latest.

>> Any difference if you boot the latest with "ec_burst=3D1"?
>Now I got no errors and battery status, ac power and sleep=20
>states are shown.
>
>What this option does?

ec_burst=3D1 enables the Embedded Controller Burst Mode.
We tried to deploy this as default in 2.6.13, but it
broke a lot of systems, so it is disabled by default
until we can fix it.

thanks,
-Len

ps. it might be good to record the results of your multiple
experiments in a bug report:
http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
Power-battery is as good a component as any.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
