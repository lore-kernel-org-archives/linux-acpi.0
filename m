From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH] GDT table patch for resume only reboots problem
Date: Wed, 20 Oct 2004 01:58:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098233908.4032.12.camel@tyrosine>
References: <OFD3267728.221C77BC-ON49256F31.006D2ECA-49256F31.0070E4AF@jp.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OFD3267728.221C77BC-ON49256F31.006D2ECA-49256F31.0070E4AF-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-10-19 at 05:38 +0900, Hiroshi 2 Itoh wrote:

> You are right and I agree gdtr save area can be modified via
> acpi_copy_wakeup_routine() with its FASTCALL argument added. This is the
> second version of gdt table patch. Also I changed temp_gdt... to
> real_gdt... because temp_gdt... looks like temporary fix.

I'm testing this patch plus the wakeup address one on an EiSystem 3001
(some random cheap VIA-based system). Suspend appears to work correctly
- if I use Pavel's BEEP code in do_suspend_lowevel I get a tone
immediately before the machine shuts down. The sleep light then comes
on. Hitting the power button results in the machine rebooting
immediately - putting a BEEP at the start of wakeup_start doesn't result
in any tone. Are there any further useful details I can send?

(This machine is of sufficiently poor quality that its DMI table claims
it's a desktop, but it suspends correctly under Windows XP...)
-- 
Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
