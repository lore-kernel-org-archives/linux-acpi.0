From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fixed buffered ACPI events for a lot ASUS machines
Date: Tue, 13 Sep 2005 10:31:43 +0800
Message-ID: <200509131031.43570.luming.yu@intel.com>
References: <432568E3.6040401@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <432568E3.6040401-l3A5Bk7waGM@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, jfvasconcelos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 12 September 2005 19:39, Thomas Renninger wrote:
> Hi,
>
>  I finally could resolve the buffering of ACPI events on
>  some ASUS (M6N, M6000, A3500N, A6000G, maybe more...)
>  when battery module is loaded.
>
>  After hours of hopeless debugging I could track it down by comparing
>  with Yu Luming's previously patch posted on bugzilla.kernel.org.
Do you mean the patch at http://bugzilla.kernel.org/show_bug.cgi?id=3851#c75?
or http://bugzilla.kernel.org/show_bug.cgi?id=3851#c74
>
>  Yu, could you confirm that this is really fixing a bug and totally safe?
>
Now ec->burst.pending_gpe is useless. it will be cleaned up.

>  Or was this intended and could possibly lead to problems on other
> machines?

If the attached patch fixs the bug, I guess you are using old code.

Thanks,
Luming


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
