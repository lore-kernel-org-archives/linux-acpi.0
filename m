From: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] [suspend/resume] wrong wakeup address
Date: Sun, 17 Oct 2004 17:24:29 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OF2CF4B186.1A9399E0-ON49256F30.002B9799-49256F30.002DBAC1@jp.ibm.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575546F8B@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575546F8B-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org





Shaohua-san,

>>I checked acpi_wakeup_address and
>>*acpi_gbl_common.fACS.firmware_waking_vector after virt_to_phys().
>>Both values are 0xC0002000 (width=32bit) on my ThinkPad. This means BIOS
>>must call the wakeup entry in big-real mode?
>The address with the patch is still 0xC0002000? How do you test it? The
>patch doesn't change the address of acpi_wakeup_address, but fACS..
>should be changed. The patch just tells BIOS a correct physical address.

I verified acpi_wakeup_address and
*acpi_gbl_common.fACS.firmware_waking_vector in
acpi_set_firmware_waking_vector().
(This is at suspend time.) The both values were 0xC0002000.

While I verified virt_to_phys(acpi_wakeup_address) in
acpi_reserve_bootmem() after calling alloc_bootmem_low().
(This is at boot time.) The value was correctly 0x00002000.

It is quite strange!!! Page tables have been changed until suspend?

Another thing I wonder:

I found u32 cast is used in acpi_set_firmware_waking_vector() in debugging.
It is natural for me to use u64 cast or substitute physical_address even if
the vector width is 32bit because
*acpi_gbl_common.fACS.firmware_waking_vector has 64bit width.
Len-san, this is a bug?

Regards, Hiro



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
