From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Suggestion for improving the handling of GPE enabling.
Date: Fri, 11 Mar 2005 00:05:21 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3002F68129@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>Hi Len,
>>On Wed, 2005-03-09 at 17:21, Pavel Machek wrote:
>>
>>> > 4. ACPI devices are in many different physical buses. If=20
>we just define
>>> > an ACPI bus, we possibly can't show the bus hierarchy.
>>>
>>> Maybe ACPI device should be "under" real hardware one?
>>
>>I suspect that the current sysfs device tree hierarchy is largely
>>fiction and that Linux would be better served by taking=20
>advantage of the
>>hierarchy embodied in the DSDT.
>>
>>The "ACPI devices" such as power, sleep, lid as well as the=20
>battery are
>>represented at the root level in the DSDT.

>Do you mean the ACPI bus should only include the devices at=20
>the root level of DSDT? I agree we should not include all=20
>devices defined in DSDT on ACPI bus, since apparently many=20
>devices aren't in ACPI bus. But there is a dilemma. We add=20
>ACPI bus to device tree, then we can use device core routines=20
>such as '.probe, .match'. To me, this should replace current=20
>ACPI device/driver register mechanism and use standard. But if=20
>only part of devices defined in DSDT is in ACPI bus, some=20
>devices can't use the mechanism. What's up? Maintain two mechanisms?

I belive that on an ACPI-enabled sytem, the "root bus" and the "ACPI
bus" are synonymous.  The other busses hang off the root bus.

/sys/devices on an ACPI-enabled system should be constructed
with the aid of the ACPI sub-system, because the topology
information is embodied in the DSDT.  It should include
all devices enumerated in the DSDT/SSDT, whose drivers should
use the "core" driver methods -- just like any other driver.

I do not agree with suggestions that the linux device
tree is God's truth and that it should have symbolic links into
/sys/firmware/acpi.  I believe that /sys/devices should get it right in
the first place, should include all the devices, and /sys/firmware/acpi
should be deleted.

thanks,
-Len


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
