From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [RFC][PATCH] Generic Hotkey driver interface
Date: Tue, 09 Nov 2004 09:13:04 -0700
Message-ID: <1100016784.12984.7.camel@tdi>
References: <3ACA40606221794F80A5670F0AF15F84041AC040@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC040@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>, Julien Lerouge <julien.lerouge-GANU6spQydw@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Luming,

   Have you considered trying to implement this as a userspace daemon on
top of dev_acpi?  I believe I'm exporting all the of the ACPI interfaces
you'd need to do this.  The acpivideo tool (available along w/ the
latest dev_acpi) does something similar in setting up a notify handler
on the graphics device, and receiving hotkey events.  The hooks are
already there to allow userspace to generate an ACPI event as well.  I'd
be interested in any feedback you have on dev_acpi should you
investigate this approach.  Thanks,

	Alex

On Tue, 2004-11-09 at 23:25 +0800, Yu, Luming wrote:
>   To consolidate the hotkey implementation in ACPI subsystem, 
> I tried to implement a generic hotkey driver under ACPI.
> I hope you can give it a review. Thanks in advances for any
> comments.
> 
>   The basic idea is to supply configurable interface
> to userspace, thus user can configure the generic
> hotkey driver to work for their specific laptop model.
> 
>   Please note, the code is trying to prove the concept
> is feasible. So there are large room to improve, including
> bugs need to be fixed, redundant code need to be clean up,
> critical section need to be protected by lock or semaphore,
> memory leak need to be fix up, interfaces need to be revised.
> 
>   The code is inspired by Karol Kozimor, Borislav Deianov,
> Hiroshi Miura, Julien Lerouge, Alex Williamson,  and Len.
> 
> Thanks,
> Luming

-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
