From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 07/20] x86, ACPI: Make acpi_initrd_override_find work
 with 32bit flat mode
Date: Thu, 4 Apr 2013 13:22:57 -0700
Message-ID: <CAE9FiQUXULou9itoDDZzDFY8gu8p5j1iMfX7EGF_KMgpb6hL+Q@mail.gmail.com>
References: <1362897887-30808-1-git-send-email-yinghai@kernel.org>
	<1362897887-30808-8-git-send-email-yinghai@kernel.org>
	<20130404183555.GW9425@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130404183555.GW9425@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, Jacob Shin <jacob.shin@amd.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 4, 2013 at 11:35 AM, Tejun Heo <tj@kernel.org> wrote:
>
> It'd be nice if the error message can be stored somewhere and then
> printed out after the system is in proper address mode if that isn't
> too complex to achieve.  If it gets too messy, no need to bother.

Maybe not necessary. As later during coping, another print out
is added there for successful one.

@@ -670,6 +700,9 @@ void __init acpi_initrd_override_copy(vo
                        break;
                q = early_ioremap(addr, size);
                p = early_ioremap(acpi_tables_addr + total_offset, size);
+               pr_info("%4.4s ACPI table found in initrd
[%#010llx-%#010llx]\n",
+                               ((struct acpi_table_header *)q)->signature,
+                               (u64)addr, (u64)(addr + size - 1));

Thanks

Yinghai
