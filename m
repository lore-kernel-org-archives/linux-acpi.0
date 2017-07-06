From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 1/5] acpi: add missing include in acpi_numa.h
Date: Fri, 7 Jul 2017 00:08:36 +0200
Message-ID: <CAJZ5v0hsNT6VzgxsC7KG2+N1wv0Yc54qQEG3WWt2Lro+ij8ZEA@mail.gmail.com>
References: <20170706215233.11329-1-ross.zwisler@linux.intel.com>
 <20170706215233.11329-2-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20170706215233.11329-2-ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Box, David E" <david.e.box-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Anaczkowski,
 Lukasz" <lukasz.anaczkowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore,
 Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Odzioba,
 Lukasz" <lukasz.odzioba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Schmauss, Erik" <erik.schmauss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>, "Kogut,
 Jaroslaw" <Jaroslaw.Kogut-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Nachimuthu,
 Murugasamy" <murugasamy.nachimuthu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lahtinen,
 Joo
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 6, 2017 at 11:52 PM, Ross Zwisler
<ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Right now if a file includes acpi_numa.h and they don't happen to include
> linux/numa.h before it, they get the following warning:
>
> ./include/acpi/acpi_numa.h:9:5: warning: "MAX_NUMNODES" is not defined [-Wundef]
>  #if MAX_NUMNODES > 256
>      ^~~~~~~~~~~~
>
> Signed-off-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  include/acpi/acpi_numa.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> index d4b7294..1e3a74f 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -3,6 +3,7 @@
>
>  #ifdef CONFIG_ACPI_NUMA
>  #include <linux/kernel.h>
> +#include <linux/numa.h>
>
>  /* Proximity bitmap length */
>  #if MAX_NUMNODES > 256
> --
> 2.9.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
