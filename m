From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: "irq 11: nobody cared" after S3
Date: Tue, 3 Aug 2004 09:43:22 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F03768C25@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: stefandoesinger-RbZlAiThDcE@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Actually current ACPI drivers don't support resume/suspend. :(. I also
consider adding a workaround to support Link device suspend/resume, but
you know it's just a workaround. Some guys may not agree to add a
workaround for the special case. For long term, LPC bridge driver should
do this.

Thanks,
Shaohua

>-----Original Message-----
>From: Nathan Bryant [mailto:nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org]
>Sent: Tuesday, August 03, 2004 9:28 AM
>To: Li, Shaohua
>Cc: stefandoesinger-RbZlAiThDcE@public.gmane.org; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] "irq 11: nobody cared" after S3
>
>Li, Shaohua wrote:
>
>>I don't think your patch works, and even it works for your system, it
>>will break other systems. The goal of 'setonboot' is to prevent
setting
>>LINK device's IRQ every time, which we added last year. Without it,
many
>>systems will break. IIRC, its goal is to resolve a bug in bugzilla.
But
>>currently I don't remember the exact bug number.
>>
>>
>Thanks for the feedback. It works for my system--but only for devices
>that call pci_device_enable(). Therefore I am currently reinstating the
>"setonboot" flag and reworking the patch along the lines of the
attached:


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
