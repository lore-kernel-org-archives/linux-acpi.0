From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] hmat: Register attributes for memory hot add
Date: Thu, 11 Apr 2019 16:42:45 +0200
Message-ID: <CAJZ5v0gOuHSoMd6dnGKN5fW1xKF89b2ak0F4mo+07FBpFUCP6A@mail.gmail.com>
References: <20190409214415.3722-1-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409214415.3722-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Brice Goglin <Brice.Goglin@inria.fr>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 9, 2019 at 11:42 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Some types of memory nodes that HMAT describes may not be online at the
> time we initially parse their nodes' tables. If the node should be set
> to online later, as can happen when using PMEM as RAM after boot, the
> node's attributes will be missing their initiator links and performance.
>
> Regsiter a memory notifier callback and set the memory attributes when
> a node is initially brought online with hot added memory, and don't try
> to register node attributes if the node is not online during initial
> scanning.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/hmat/hmat.c | 63 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 50 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b275016ff648..cf24b885feb5 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -14,14 +14,15 @@
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/list_sort.h>
> +#include <linux/memory.h>
>  #include <linux/node.h>
>  #include <linux/sysfs.h>
>
> -static __initdata u8 hmat_revision;
> +static u8 hmat_revision;
>
> -static __initdata LIST_HEAD(targets);
> -static __initdata LIST_HEAD(initiators);
> -static __initdata LIST_HEAD(localities);
> +static LIST_HEAD(targets);
> +static LIST_HEAD(initiators);
> +static LIST_HEAD(localities);
>
>  /*
>   * The defined enum order is used to prioritize attributes to break ties when
> @@ -41,6 +42,7 @@ struct memory_target {
>         unsigned int memory_pxm;
>         unsigned int processor_pxm;
>         struct node_hmem_attrs hmem_attrs;
> +       bool registered;
>  };
>
>  struct memory_initiator {
> @@ -53,7 +55,7 @@ struct memory_locality {
>         struct acpi_hmat_locality *hmat_loc;
>  };
>
> -static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
> +static struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
>  {
>         struct memory_initiator *initiator;
>
> @@ -63,7 +65,7 @@ static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
>         return NULL;
>  }
>
> -static __init struct memory_target *find_mem_target(unsigned int mem_pxm)
> +static struct memory_target *find_mem_target(unsigned int mem_pxm)
>  {
>         struct memory_target *target;
>
> @@ -148,7 +150,7 @@ static __init const char *hmat_data_type_suffix(u8 type)
>         }
>  }
>
> -static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
> +static u32 hmat_normalize(u16 entry, u64 base, u8 type)
>  {
>         u32 value;
>
> @@ -183,7 +185,7 @@ static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
>         return value;
>  }
>
> -static __init void hmat_update_target_access(struct memory_target *target,
> +static void hmat_update_target_access(struct memory_target *target,
>                                              u8 type, u32 value)
>  {
>         switch (type) {
> @@ -435,7 +437,7 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
>         return 0;
>  }
>
> -static __init u32 hmat_initiator_perf(struct memory_target *target,
> +static u32 hmat_initiator_perf(struct memory_target *target,
>                                struct memory_initiator *initiator,
>                                struct acpi_hmat_locality *hmat_loc)
>  {
> @@ -473,7 +475,7 @@ static __init u32 hmat_initiator_perf(struct memory_target *target,
>                               hmat_loc->data_type);
>  }
>
> -static __init bool hmat_update_best(u8 type, u32 value, u32 *best)
> +static bool hmat_update_best(u8 type, u32 value, u32 *best)
>  {
>         bool updated = false;
>
> @@ -517,7 +519,7 @@ static int initiator_cmp(void *priv, struct list_head *a, struct list_head *b)
>         return ia->processor_pxm - ib->processor_pxm;
>  }
>
> -static __init void hmat_register_target_initiators(struct memory_target *target)
> +static void hmat_register_target_initiators(struct memory_target *target)
>  {
>         static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
>         struct memory_initiator *initiator;
> @@ -577,22 +579,53 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
>         }
>  }
>
> -static __init void hmat_register_target_perf(struct memory_target *target)
> +static void hmat_register_target_perf(struct memory_target *target)
>  {
>         unsigned mem_nid = pxm_to_node(target->memory_pxm);
>         node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
>  }
>
> -static __init void hmat_register_targets(void)
> +static void hmat_register_targets(void)
>  {
>         struct memory_target *target;
>
>         list_for_each_entry(target, &targets, node) {
> +               if (!node_online(pxm_to_node(target->memory_pxm)))
> +                       continue;
> +
>                 hmat_register_target_initiators(target);
>                 hmat_register_target_perf(target);
> +               target->registered = true;
>         }
>  }
>
> +static int hmat_callback(struct notifier_block *self,
> +                        unsigned long action, void *arg)
> +{
> +       struct memory_notify *mnb = arg;
> +       int pxm, nid = mnb->status_change_nid;
> +       struct memory_target *target;
> +
> +       if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> +               return NOTIFY_OK;
> +
> +       pxm = node_to_pxm(nid);
> +       target = find_mem_target(pxm);
> +       if (!target || target->registered)
> +               return NOTIFY_OK;
> +
> +       hmat_register_target_initiators(target);
> +       hmat_register_target_perf(target);
> +       target->registered = true;
> +
> +       return NOTIFY_OK;
> +}

This appears to assume that there will never be any races between the
two functions above.

It this guaranteed to be the case?

> +
> +static struct notifier_block hmat_callback_nb = {
> +       .notifier_call = hmat_callback,
> +       .priority = 2,
> +};
> +
>  static __init void hmat_free_structures(void)
>  {
>         struct memory_target *target, *tnext;
> @@ -658,6 +691,10 @@ static __init int hmat_init(void)
>                 }
>         }
>         hmat_register_targets();
> +
> +       /* Keep the table and structures if the notifier may use them */
> +       if (!register_hotmemory_notifier(&hmat_callback_nb))
> +               return 0;
>  out_put:
>         hmat_free_structures();
>         acpi_put_table(tbl);
> --
