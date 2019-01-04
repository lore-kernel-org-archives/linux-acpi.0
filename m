From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv3 1/2] mm/memblock: extend the limit inferior of
 bottom-up after parsing hotplug attr
Date: Fri, 4 Jan 2019 17:09:29 +0200
Message-ID: <20190104150929.GA32252@rapoport-lnx>
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
 <1545966002-3075-2-git-send-email-kernelfans@gmail.com>
 <20181231084018.GA28478@rapoport-lnx>
 <CAFgQCTvQnj7zReFvH_gmfVJdPXE325o+z4Xx76fupvsLR_7H2A@mail.gmail.com>
 <20190102092749.GA22664@rapoport-lnx>
 <20190102101804.GD1990@MiWiFi-R3L-srv>
 <20190102170537.GA3591@rapoport-lnx>
 <20190103184706.GU2509588@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190103184706.GU2509588@devbig004.ftw2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, linux-acpi@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, Tang Chen <tangchen@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Nicholas Piggin <npiggin@gmail.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Daniel Vacek <neelx@redhat.com>, Mathieu Malaterre <malat@debian.org>, Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>, yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.o
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 03, 2019 at 10:47:06AM -0800, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jan 02, 2019 at 07:05:38PM +0200, Mike Rapoport wrote:
> > I agree that currently the bottom-up allocation after the kernel text has
> > issues with KASLR. But this issues are not necessarily related to the
> > memory hotplug. Even with a single memory node, a bottom-up allocation will
> > fail if KASLR would put the kernel near the end of node0.
> > 
> > What I am trying to understand is whether there is a fundamental reason to
> > prevent allocations from [0, kernel_start)?
> > 
> > Maybe Tejun can recall why he suggested to start bottom-up allocations from
> > kernel_end.
> 
> That's from 79442ed189ac ("mm/memblock.c: introduce bottom-up
> allocation mode").  I wasn't involved in that patch, so no idea why
> the restrictions were added, but FWIW it doesn't seem necessary to me.

I should have added the reference [1] at the first place :)
Thanks!

[1] https://lore.kernel.org/lkml/20130904192215.GG26609@mtj.dyndns.org/
 
> Thanks.
> 
> -- 
> tejun
> 

-- 
Sincerely yours,
Mike.
