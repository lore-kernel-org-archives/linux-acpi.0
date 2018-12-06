From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Date: Thu, 6 Dec 2018 08:23:57 +0100
Message-ID: <20181206072357.GA1286@dhcp22.suse.cz>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204072251.GT31738@dhcp22.suse.cz>
 <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
 <20181204085601.GC1286@dhcp22.suse.cz>
 <CAFgQCTuyKBZdwWG=fOECE6J8DbZJsErJOyXTrLT0Kog3ec7vhw@mail.gmail.com>
 <20181205092148.GA1286@dhcp22.suse.cz>
 <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <20181205094327.GD1286@dhcp22.suse.cz>
 <CAFgQCTu40HNsFVDVp+iXpPDoQ7VvGdTs8HLVy8=qTU77Bywt3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFgQCTu40HNsFVDVp+iXpPDoQ7VvGdTs8HLVy8=qTU77Bywt3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu 06-12-18 11:34:30, Pingfan Liu wrote:
[...]
> > I suspect we are looking at two issues here. The first one, and a more
> > important one is that there is a NUMA affinity configured for the device
> > to a non-existing node. The second one is that nr_cpus affects
> > initialization of possible nodes.
> 
> The dev->numa_node info is extracted from acpi table, not depends on
> the instance of numa-node, which may be limited by nr_cpus. Hence the
> node is existing, just not instanced.

Hmm, binding to memory less node is quite dubious. But OK. I am not sure
how much sanitization can we do. We need to fallback anyway so we should
better make sure that all possible nodes are initialized regardless of
nr_cpus. I will look into that.

-- 
Michal Hocko
SUSE Labs
