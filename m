From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ACPI based cpu hotplug
Date: 28 Oct 2004 04:12:53 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098951173.5402.96.camel@d845pe>
References: <20041027193118.B6002@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041027193118.B6002-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developer <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Anil.

I applied all 6 patches to
http://linux-acpi.bkbits.net/26-latest-mm
(even though one was technically IA64
 rather than ACPI specific)

Please pull from this repo and test to verify
that I did the merges properly and that bk
did the subsequent merges properly too.
All I can do is read and build-test this patch series.

Also, when you have updates, please make
them relative to this baseline.

thanks,
-Len


On Wed, 2004-10-27 at 22:31, Keshavamurthy Anil S wrote:
> Hi Len,
>         Couple of weeks back I had posted the ACPI based Physical CPU
> hotplug patches onto the above mailing-list and I had resolved all the
> issues that people on the mailing list had brough out. I was hoping to
> see that patches on 2.6.10-rc1-mm1 and since I did not see them there,
> just checking to see whats your idea on this. I guess other companies
> are working on this acpi based hotplug technologies and are dependent
> on my patches which enhances core acpi and introduces the first
> version
> of the container driver.
> 
> I had tested those patches in an emulation environment by overiding
> DSDT.
> I am attaching the links of those patches again for your refernece.
> 
> http://marc.theaimsgroup.com/?l=acpi4linux&m=109606894724606&w=2
> http://marc.theaimsgroup.com/?l=acpi4linux&m=109606922621045&w=2
> http://marc.theaimsgroup.com/?l=acpi4linux&m=109632034413133&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109606961524691&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109607023225373&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109607042100294&w=2
> 
> 
> Please let me know if you would like to receive the patches rediffed
> to the latest bits and I would be happy to resend it to you again.
> 
> Thanks,
> 
> -Anil Keshavamurthy
> Sr. Software Engineer
> Linux OS Technology Team
> Intel Corp.
> (w) 503-712-4476
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
