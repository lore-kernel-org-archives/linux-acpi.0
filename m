From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: Linux v2.6.13-rc3
Date: Sat, 23 Jul 2005 19:14:59 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC1E5@pdsmsx403>
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
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I just uploaded a patch that can fall back to polling mode which suppose =
to=20
work for some system like L5D. Please give it a test.
The real fix is on-going.=20

Patch is filed at http://bugzilla.kernel.org/show_bug.cgi?id=3D4665

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Pavel Troller
>Sent: 2005=C4=EA7=D4=C221=C8=D5 15:50
>To: Brown, Len
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] RE: Linux v2.6.13-rc3
>
>Hello there,
>> Re: the EC burst mode regression.
>> This is an extremely important fix that has been nagging
>> many systems for years.  It has been reported to us by
>> distros as well as on kernel.org:
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D3851
>> There has been a lot of discussion about this on the
>> mailing list and there have been several generations
>> of patches.  We are confident that this approach
>> is the correct solution, but clearly there are
>> some snags.  It is probable that the snags are
>> model specific.
>
>I don't know whether this regression is related to the message
>
>Jul 20 21:00:45 miro kernel:  acpi_ec-0217 [22]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:00:45 miro last message repeated 26 times
>Jul 20 21:00:45 miro kernel:  acpi_ec-0217 [23]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:00:45 miro last message repeated 3 times
>Jul 20 21:00:45 miro kernel:  acpi_ec-0217 [22]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:00:45 miro kernel:  acpi_ec-0217 [22]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:23 miro kernel:  acpi_ec-0217 [22]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:23 miro last message repeated 26 times
>Jul 20 21:05:23 miro kernel:  acpi_ec-0217 [23]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:23 miro last message repeated 3 times
>Jul 20 21:05:23 miro kernel:  acpi_ec-0217 [22]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:32 miro last message repeated 29 times
>Jul 20 21:05:32 miro kernel:  acpi_ec-0217 [23]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:32 miro last message repeated 3 times
>Jul 20 21:05:32 miro kernel:  acpi_ec-0217 [22]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:33 miro last message repeated 27 times
>Jul 20 21:05:33 miro kernel:  acpi_ec-0217 [23]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:33 miro last message repeated 3 times
>Jul 20 21:05:33 miro kernel:  acpi_ec-0217 [22]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:34 miro last message repeated 25 times
>Jul 20 21:05:34 miro kernel:  acpi_ec-0217 [23]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:34 miro last message repeated 3 times
>Jul 20 21:05:34 miro kernel:  acpi_ec-0217 [22]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:41 miro last message repeated 27 times
>Jul 20 21:05:41 miro kernel:  acpi_ec-0217 [23]=20
>acpi_ec_leave_burst_mo: ------->status fail
>Jul 20 21:05:41 miro last message repeated 2 times
>Jul 20 21:05:41 miro kernel:  acpi_ec-0217 [22]=20
>acpi_ec_leave_burst_mo: ------->status fail
>
>As You can see, this message is generated really many times=20
>when trying regular
>2.6.13-rc3. I'm reporting it for sure, to let You know that=20
>there are more
>models which experience this.
>
>The problem occurs on Clevo D610SU, a P4/SiS chipset notebook.
>When I saw such a bunch of messages, I reverted back to -rc2=20
>kernel, which is
>fine.
>
>If You would like to see anything more detailed (dmesg, DSDT=20
>etc.) from the
>affected system, let me know.
>
>                       With regards, Pavel Troller
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>from IBM. Find simple to follow Roadmaps, straightforward articles,
>informative Webcasts and more! Get everything you need to get up to
>speed, fast. =
http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
