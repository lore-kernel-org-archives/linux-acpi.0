From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: s4bios: does anyone use it?
Date: Tue, 8 Mar 2005 13:24:13 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305750155EBB0@pdsmsx402.ccr.corp.intel.com>
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
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
>> >
>> > Is there single user of s4bios? It used to work for me 4 notebooks
>> > ago, but I never really used it.
>>
>> I don't have anymore my toshiba laptop where S4 bios was first
>> implemented.
>>
>> > I think I'm the only person that ever
>> > seen it working, but I could be wrong.
>>
>> You are indeed wrong.
>
>Okay, so we had 2 users in past but have 0 users now? :-).
I wonder how could anyone use S4BIOS in 2.6.11. S4 and S4b all came into
'enter_state'. and in acpi_sleep_init:

		if (i =3D=3D ACPI_STATE_S4) {
			if (acpi_gbl_FACS->S4bios_f) {
				sleep_states[i] =3D 1;
				printk(" S4bios");
				acpi_pm_ops.pm_disk_mode =3D
PM_DISK_FIRMWARE;
			}
			if (sleep_states[i])
				acpi_pm_ops.pm_disk_mode =3D
PM_DISK_PLATFORM;
		}
That means we actually can't set PM_DISK_FIRMWARE (always set
PM_DISK_PLATFORM). Is this intended? If no, .pm_disk_mode should be a
mask.

Thanks,
Shaohua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
