From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Suggestion for improving the handling of GPE enabling.
Date: Fri, 11 Mar 2005 10:30:32 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575015B5546@pdsmsx402.ccr.corp.intel.com>
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
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> > > an ACPI bus, we possibly can't show the bus hierarchy.
>> >
>> > Maybe ACPI device should be "under" real hardware one?
>>
>> I suspect that the current sysfs device tree hierarchy is largely
>> fiction and that Linux would be better served by taking advantage of
the
>> hierarchy embodied in the DSDT.
>>
>> The "ACPI devices" such as power, sleep, lid as well as the battery
are
>> represented at the root level in the DSDT.
>
>Are the ACPI HID names exposed to userspace yet? At the moment
userspace
>tools need to try loading every ACPI module. If the HIDs were exported
>via sysfs and the ACPI drivers exported the devices they could bind to,
>we could use hotplug to autoload the correct drivers.
Sure, after we add ACPI bus support, the ACPI module should be loaded
dynamically.=20
This makes me think another issue. You know PNPACPI also could export
the HIDs to user space. We plan to add the hotplug in PNPACPI. So the
question is who (PNP layer or ACPI) should export the HID?

Thanks,
Shaohua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
