From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Subject: Re: fd3e45436660 ("ACPI / NUMA: ia64: Parse all entries of SRAT
 memory affinity table")
Date: Thu, 10 May 2018 13:36:11 +0530
Message-ID: <CAKTKpr6u2+KA_MJRWnH6x_Uc-HgFRdBYL7P3ZJCwQri4TL8vrA@mail.gmail.com>
References: <20180411104832.GF23400@dhcp22.suse.cz> <20180509122454.GR32366@dhcp22.suse.cz>
 <CAKTKpr5uPuZUHBnQtDwpGA_d=WTx_5O2SF_+WStO6OMVNe77QQ@mail.gmail.com>
 <20180509125611.GT32366@dhcp22.suse.cz> <CAKTKpr59axOTxFL1eGCR7nvmERYuxKS=DmVX0jTmt53EobmeGw@mail.gmail.com>
 <20180510073054.GD32366@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510073054.GD32366@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, tiantao6@huawei.com, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, May 10, 2018 at 1:00 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 10-05-18 08:27:35, Ganapatrao Kulkarni wrote:
>> On Wed, May 9, 2018 at 6:26 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> > On Wed 09-05-18 18:07:16, Ganapatrao Kulkarni wrote:
>> >> Hi Michal
>> >>
>> >>
>> >> On Wed, May 9, 2018 at 5:54 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> >> > On Wed 11-04-18 12:48:32, Michal Hocko wrote:
>> >> >> Hi,
>> >> >> my attention was brought to the %subj commit and either I am missing
>> >> >> something or the patch is quite dubious. What is it actually trying to
>> >> >> fix? If a BIOS/FW provides more memblocks than the limit then we would
>> >> >> get misleading numa topology (numactl -H output) but is the situation
>> >> >> much better with it applied? Numa init code will refuse to init more
>> >> >> memblocks than the limit and falls back to dummy_numa_init (AFAICS)
>> >> >> which will break the topology again and numactl -H will have a
>> >> >> misleading output anyway.
>> >>
>> >> IIRC, the MEMBLOCK beyond max limit getting dropped from visible
>> >> memory(partial drop from a node).
>> >> this patch removed any upper limit on memblocks and allowed to parse
>> >> all entries of SRAT.
>> >
>> > Yeah I've understood that much. My question is, however, why do we care
>> > about parsing the NUMA topology when we fallback into a single NUMA node
>> > anyway? Or do I misunderstand the code? I do not have any platform with
>> > that many memblocks.
>>
>> IMHO, this fix is very much logical by removing the SRAT parsing restriction.
>> below is the crash log which made us to debug and eventually fix with
>> this patch.
>
> Ohh, I am not saying that the current code handles too many memblocks
> correctly. I just think that your fix is not correct or incomplete at
> least. Assuming that my understanding is correct which you haven't
> disputed yet. So can we focus on the proper solution now? Do we actually
> need the memblock restrictions? We do not need those for reserved
> memblocks so I do not see any real reason to simply remove the
> restriction altogether. Have you explored that option?

my logic was simple, when i added this patch, when the cap on max
memblocks is arch specific, why to restrict SRAT parsing which is not
arch specific.
other way around argument is, why the restriction added in the first
place itself!

> --
> Michal Hocko
> SUSE Labs

thanks
Ganapat
