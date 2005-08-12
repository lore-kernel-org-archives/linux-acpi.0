From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Touchpad problem on 15XX Acer Aspire laptops.
Date: Fri, 12 Aug 2005 15:52:52 +0800
Message-ID: <20050812075251.GA14465@linux.sh.intel.com>
References: <2ac89c700508021812208f23d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2ac89c700508021812208f23d6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitrij Bogush <dmitrij.bogush-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2005.08.03 05:12:35 +0400, Dmitrij Bogush wrote:
> Hi.
> 
> Someone Dmitry Torokhov on LKML told me to contact ACPI mailing list
> with this problem.
>  
> Touchpad goes crazy then programs like Kpowersave or Gkrellm check
> battery state or current cpu frequency.
> 
>  With 2.6.11.4 in dmesg I see this:
> 
> psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
>  
> With latest 2.6.13-rc5 kernel I get this:
>  
> warning: many lost ticks.
> Your time source seems to be instable or some driver is hogging interupts
> rip handler_IRQ_event+0x20/0x60
>  
> With 2.6.13-rc5 touchpad freezes for a second, do not goese crazy like
> with 2.6.11.
> 
> Thanks.
> 
Please test linux-2.6.13-rc6 with patch filed at bug 3851 , Please try both
ec_burst=0 and ec_burst=1.
Thanks,
Luming


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
