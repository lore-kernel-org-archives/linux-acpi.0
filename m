From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Suggestion for improving the handling of GPE enabling.
Date: Fri, 11 Mar 2005 12:50:20 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575015B5678@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Len,
>On Wed, 2005-03-09 at 17:21, Pavel Machek wrote:
>
>> > 4. ACPI devices are in many different physical buses. If we just
define
>> > an ACPI bus, we possibly can't show the bus hierarchy.
>>
>> Maybe ACPI device should be "under" real hardware one?
>
>I suspect that the current sysfs device tree hierarchy is largely
>fiction and that Linux would be better served by taking advantage of
the
>hierarchy embodied in the DSDT.
>
>The "ACPI devices" such as power, sleep, lid as well as the battery are
>represented at the root level in the DSDT.
Do you mean the ACPI bus should only include the devices at the root
level of DSDT? I agree we should not include all devices defined in DSDT
on ACPI bus, since apparently many devices aren't in ACPI bus. But there
is a dilemma. We add ACPI bus to device tree, then we can use device
core routines such as '.probe, .match'. To me, this should replace
current ACPI device/driver register mechanism and use standard. But if
only part of devices defined in DSDT is in ACPI bus, some devices can't
use the mechanism. What's up? Maintain two mechanisms?

Thanks,
Shaohua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
