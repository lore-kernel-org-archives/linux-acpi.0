From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] GDT table patch for resume only reboots problem
Date: Sun, 17 Oct 2004 22:42:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041017204237.GA23733@elf.ucw.cz>
References: <OFC0526CFC.7FFB98D1-ON49256F30.0068372D-49256F30.006EF530@jp.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <OFC0526CFC.7FFB98D1-ON49256F30.0068372D-49256F30.006EF530-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Using 2.6.9 RC4 kernel + Shaohua-san's wakeup patch, my test machine
> resumes just before
> ljmpl $__KERNEL_CS,$wakeup_pmode_return in wakeup.S.
> (This is confirmed by parallel port(0x3bc) out like BIOS steping number.)
> 
> The code would not come back to wakeup_pmode_return entry and goes to
> reboot. After fairly tough debugging, it is found that the original GDT
> pointed by GDTR cannot be accessed from real mode. (This may occurr
> especially when CR4 PSE bit is on.)
> 
> The following patch will partially copy the GDT into low memory to be
> addressable.
> (See attached file: wakeup_gdt.patch)
> 
> I hope most of machines can resume with;
> 
> Kernel 2.6.9 RC4
> +wakeup_addr.patch
> +wakeup_gdt.patch
> 
> If you cannot see the screen normally after resume, "acpi_sleep=s3_bios"
> boot option is available to reset the video mode.
> (My ThinkPad is still in trouble with HDD access after resume because of
> unknown reason. :-)

(Please inline patches to make commenting on them easier)

--- a/arch/i386/kernel/acpi/wakeup.S    2004-08-14 14:36:31.000000000
+0900
+++ b/arch/i386/kernel/acpi/wakeup.S    2004-10-18 04:30:53.684987016
+0900
@@ -67,6 +67,13 @@
        movw    $0x0e00 + 'i', %fs:(0x12)

        # need a gdt
+       # use the gdt copied in this low mem
+       lea     temp_gdt_table - wakeup_code, %eax
+       xor     %ebx, %ebx
+       movw    %ds, %bx
+       shll    $4, %ebx
+       addl    %ebx, %eax
+       movl    %eax, real_save_gdt + 2 - wakeup_code
        lgdt    real_save_gdt - wakeup_code

        movl    real_save_cr0 - wakeup_code, %eax

It is ugly to do this kind of computation during resume time (where it
is impossible to debug). It could be done in suspend time and resume
path could stay the same, right?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
