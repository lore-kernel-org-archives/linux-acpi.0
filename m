From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: "irq 11: nobody cared" after S3
Date: Tue, 3 Aug 2004 09:12:57 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F03768BD0@pdsmsx401.ccr.corp.intel.com>
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

I don't think your patch works, and even it works for your system, it
will break other systems. The goal of 'setonboot' is to prevent setting
LINK device's IRQ every time, which we added last year. Without it, many
systems will break. IIRC, its goal is to resolve a bug in bugzilla. But
currently I don't remember the exact bug number.

Thanks,
Shaohua
>-----Original Message-----
>From: Nathan Bryant [mailto:nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org]
>Sent: Monday, August 02, 2004 10:18 PM
>To: Li, Shaohua
>Cc: stefandoesinger-RbZlAiThDcE@public.gmane.org; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] "irq 11: nobody cared" after S3
>
>Li, Shaohua wrote:
>> I guess the bug is: ACPI sets LNKE's IRQ from 10 to 11 in boot time.
>> LNKE's register is at LPC bridge offset 0x68, but current PCI config
>> space save/restore code only handles first 0x40 bytes. After resume,
>> LNKE's register doesn't recover. So LNKE will actually route to 10,
but
>> ACPI still thinks it routes to 11. Then you will get such error. I
guess
>> such error is unavoidable unless LPC bridge driver exists (it can
>> save/restore all affected config space instead of first 0x40 bytes).
>
>Hi,
>
>I agree with you, but I suspect a better fix is something like the
>attached diff, from my local tree. (My machine has similar problems,
but
>this is not tested yet. Will test tonight and then send a patch to Len
>if it works out.)


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
