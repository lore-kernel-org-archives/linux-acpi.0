From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH] GDT table patch for resume only reboots problem
Date: Sat, 23 Oct 2004 12:13:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098530036.3996.18.camel@tyrosine>
References: <OF7ADC5954.7B192D8D-ON49256F36.003BC992-49256F36.003C1DA9@jp.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OF7ADC5954.7B192D8D-ON49256F36.003BC992-49256F36.003C1DA9-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-10-23 at 20:01 +0900, Hiroshi 2 Itoh wrote:
> On Sat, 2004-10-23 at 01:34 +0100, Matthew Garrett wrote:
> >
> > I've done some further digging - it seems that the wakeup_vector is
> > generally set to 0x1000, and that that's its value at the start of
> > acpi_pm_enter - that is, it doesn't appear to be overwritten by anything
> > during sleep preparation.
> 
> The vector means a physical address, not the offset of any kernel entry
> points.
> You confirmed virt_to_phys((void *)acpi_wakeup_address) was equal to
> 0x1000?

Sorry, yes - the virtual address is 0xc0001000, and after it's been
through virt_to_phys it's 0x00001000. This is the value that gets
written into the FACS, and reading it back immediately before the final
suspend call shows that it's still the value there.

Further digging - the machine claims that the FACS revision is 0, the
table length is 64 and that xfirmware_waking_vector is set to 0, As a
result of the first and last of these things, firmware_waking_vector is
used instead of xfirmware_waking_vector. This shouldn't be an issue,
right? 
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
