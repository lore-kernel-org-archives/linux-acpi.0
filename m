From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 5/5] processor: jiffies-based bm_check
Date: Fri, 21 Jan 2005 13:03:29 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003D1BDB1@scsmsx403.amr.corp.intel.com>
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
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=20

>-----Original Message-----
>From: Dominik Brodowski [mailto:linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org]=20
>Sent: Friday, January 21, 2005 8:24 AM
>To: Brown, Len
>Cc: ACPI Developers; Pallipadi, Venkatesh; Moore, Robert
>Subject: Re: [PATCH 5/5] processor: jiffies-based bm_check
>
>On Thu, Jan 20, 2005 at 11:08:06PM -0500, Len Brown wrote:
>> On Thu, 2004-12-23 at 15:11, Len Brown wrote:
>>=20
>> > Didn't apply the jiffies part yet.
>>=20
>> I've applied it now. (attached as jiffy.patch)
>>=20
>> However, "threshold.bm =3D 0xF" was written when
>> HZ =3D 100 yielding 40ms, but this
>> becomes 4ms for HZ =3D 1000.
>>=20
>> While I don't know what the optimal value is for
>> the bus master history threshold, it seemed like
>> a good idea for it to default to about 40ms per
>> the original code until we know better.
>>=20
>> So I've also applied the attached bm_history.patch
>> to default this to 0xFFFFFFFF for HZ =3D 1000 (32ms)
>> and it is tunable via /sys/module/processor/parameters/bm_history
>>=20
>> what do you think?
>
>This sounds sensible to do. Note that the "diff" measured in=20
>idle() will
>become problematic once "tickless" systems are implemented --=20
>we'll sleep
>for multiple jiffies then, and there was _no_ bm activiy in=20
>between. We need
>to sort that out somehow...
>
>	Dominik


How about using gettimeofday here and using that in place of jiffies?

-Venki


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
