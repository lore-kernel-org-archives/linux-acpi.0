From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFCv2 1/4] ACPI: NUMA: export pxm_to_node
Date: Thu, 24 May 2018 10:12:30 +0200
Message-ID: <CAJZ5v0jar8TqC5MGRPcAVZfM3LmmoSV3fT3Sgok=r6D9cDG0+w@mail.gmail.com>
References: <20180523182404.11433-1-david@redhat.com> <20180523182404.11433-2-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523182404.11433-2-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, May 23, 2018 at 8:24 PM, David Hildenbrand <david@redhat.com> wrote:
> Will be needed by paravirtualized memory devices.

That's a little information.

It would be good to see the entire series at least.

> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/acpi/numa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 85167603b9c9..7ffee2959350 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -50,6 +50,7 @@ int pxm_to_node(int pxm)
>                 return NUMA_NO_NODE;
>         return pxm_to_node_map[pxm];
>  }
> +EXPORT_SYMBOL(pxm_to_node);

EXPORT_SYMBOL_GPL(), please.

>
>  int node_to_pxm(int node)
>  {
> --
