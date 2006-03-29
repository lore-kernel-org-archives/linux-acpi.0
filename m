From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [Patch:001/004]Unify pxm_to_node id ver.3.(generic code)
Date: Wed, 29 Mar 2006 10:28:05 +0900
Message-ID: <20060329100729.23C3.Y-GOTO@jp.fujitsu.com>
References: <20060328191250.CC48.Y-GOTO@jp.fujitsu.com> <20060328130736.5a4273d9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20060328130736.5a4273d9.akpm@osdl.org>
Sender: linux-ia64-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: tony.luck@intel.com, ak@suse.de, len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, discuss@x86-64.org
List-Id: linux-acpi@vger.kernel.org

> Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> >
> > +/* Proximity bitmap length */
> >  +#ifdef CONFIG_NR_NODES_CHANGABLE
> >  +#define MAX_PXM_DOMAINS CONFIG_NR_NODES
> >  +#else
> >  +#define MAX_PXM_DOMAINS (256)
> >  +#endif
> 
> I don't think we need CONFIG_NR_NODES_CHANGABLE (it is spelled
> "changeable", btw).
> 
> If the architecture wants to support changing of CONFIG_NR_NODES then it
> can permit CONFIG_NR_NODES to be changed in its Kconfig implementation.
> 
> If the architecture doesn't want to permit changing of CONFIG_NR_NODES
> then it should simply hardwire CONFIG_NR_NODES to the chosen value in
> its Kconfig.
> 
> So all architectures which use acpi_numa must implement CONFIG_NR_NODES.
> 
> In fact, it would probably make sense to require that all NUMA-supporting
> archtectures implement CONFIG_NR_NODES.
> 
> Also, we already have NODES_SHIFT defined in include/asm-*/numnodes.h. 
> What's the relationship between that and CONFIG_NR_NODES?  It seems that we
> want to derive NODES_SHIFT from CONFIG_NR_NODES.
> 
> Was ia64's CONFIG_IA64_NR_NODES the best choice?  Should ia64 instead have
> made NODES_SHIFT Kconfigurable, and derived its max-nr_nodes from that?
> 
> It's all a bit of a pickle.
> 
> 
> I guess for now a suitable approach would be to make all numa-using
> architectures define CONFIG_NR_NODES, and to leave that rather
> unpleasant-looking code in include/asm-ia64/numnodes.h as it is.
> 

Ahhh.
I understand what you wish at last.

I thought relationship between pxm and nid is just acpi-using
architecture's issue.
But, it becomes for all numa-using architecture's issue.

Ok. I'll change it.

Thanks.

-- 
Yasunori Goto 


