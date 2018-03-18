From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] acpi, numa: fix pxm to online numa node associations
Date: Sun, 18 Mar 2018 22:55:10 +0100
Message-ID: <CAJZ5v0hEnxFfH4cXqTXKqS+w2uGgiZze4TeS5FgqwrwuBb1R2w@mail.gmail.com>
References: <152116964416.8343.514895686858363582.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <152116964416.8343.514895686858363582.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 16, 2018 at 4:08 AM, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Commit 99759869faf1 "acpi: Add acpi_map_pxm_to_online_node()" added
> support for mapping a given proximity to its nearest, by SLIT distance,
> online node. However, it sometimes returns unexpected results due to the
> fact that it switches from comparing the PXM node to the last node that
> was closer than the current max.
>
>     for_each_online_node(n) {
>             dist = node_distance(node, n);
>             if (dist < min_dist) {
>                     min_dist = dist;
>                     node = n;   <---- from this point we're using the
>                                       wrong node for node_distance()
>
>
> Fixes: 99759869faf1 ("acpi: Add acpi_map_pxm_to_online_node()")
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Cc: Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>>
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> Rafael, I can take this through the nvdimm tree with your ack. I have a
> few other nvdimm fixes pending for 4.16.

OK

Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

>
>  drivers/acpi/numa.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 8ccaae3550d2..85167603b9c9 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -103,25 +103,27 @@ int acpi_map_pxm_to_node(int pxm)
>   */
>  int acpi_map_pxm_to_online_node(int pxm)
>  {
> -       int node, n, dist, min_dist;
> +       int node, min_node;
>
>         node = acpi_map_pxm_to_node(pxm);
>
>         if (node == NUMA_NO_NODE)
>                 node = 0;
>
> +       min_node = node;
>         if (!node_online(node)) {
> -               min_dist = INT_MAX;
> +               int min_dist = INT_MAX, dist, n;
> +
>                 for_each_online_node(n) {
>                         dist = node_distance(node, n);
>                         if (dist < min_dist) {
>                                 min_dist = dist;
> -                               node = n;
> +                               min_node = n;
>                         }
>                 }
>         }
>
> -       return node;
> +       return min_node;
>  }
>  EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
