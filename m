From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [BKPATCH] ACPI for 2.6.12-rc1
Date: Wed, 30 Mar 2005 14:09:00 +0800
Message-ID: <200503301409.00785.luming.yu@intel.com>
References: <1111127024.9332.157.camel@d845pe> <20050319215239.GA5105@rukbat.dea.icai.upco.es> <20050329081321.GA4133@pern.dea.icai.upco.es>
Reply-To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050329081321.GA4133-NfIQswJzSEaq9fEpoSJUslHdEuJhDOxL@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 29 March 2005 16:13, Romano Giannetti wrote:
>  This is to report an issue with 2.6.11 and ACPI battery/ac. The resume is:
>  acpi battery with preemptive kernel do not work, while the same kernel
> with no preempt works ok. I have tried to collect all the possible info;
> tell me if you need something more.
>
>  The details:
>
>  The working kernel is 2.6.11 with the patch from the acpi-devel list to
> fix acpi keys (not working otherwise). See for a description
>  http://bugme.osdl.org/show_bug.cgi?id=4124

If you can find AE_AML_BUFFER_LIMIT in your long, then, it should be 
interpreter bug.  please see http://bugzilla.kernel.org/show_bug.cgi?id=4150
Otherwise, maybe it is related to EC driver.
-- 
Thanks,
Luming


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
