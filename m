From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Suggestion for improving the handling of GPE enabling.
Date: Fri, 11 Mar 2005 13:43:15 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575015B56E1@pdsmsx402.ccr.corp.intel.com>
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

>I belive that on an ACPI-enabled sytem, the "root bus" and the "ACPI
bus"
>are synonymous.  The other busses hang off the root bus.
>
>/sys/devices on an ACPI-enabled system should be constructed
>with the aid of the ACPI sub-system, because the topology
>information is embodied in the DSDT.  It should include
>all devices enumerated in the DSDT/SSDT, whose drivers should
>use the "core" driver methods -- just like any other driver.
>
>I do not agree with suggestions that the linux device
>tree is God's truth and that it should have symbolic links into
>/sys/firmware/acpi.  I believe that /sys/devices should get it right in
the
>first place, should include all the devices, and /sys/firmware/acpi
should
>be deleted.
Maintain a bus tree just like the ACPI DSDT? This possibly isn't easy.
Linux device core model seems hasn't a mechanism to show the
relationship of two buses.=20

Thanks,
Shaohua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
