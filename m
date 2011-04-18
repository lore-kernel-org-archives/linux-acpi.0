From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH -v3 3/4] lib, Make gen_pool memory allocator lockless
Date: Mon, 18 Apr 2011 19:42:16 +0800
Message-ID: <BANLkTimfHARu=N_5izaNfZpGH78MPT7uDA@mail.gmail.com>
References: <1302684835-14133-1-git-send-email-ying.huang@intel.com>
	<1302684835-14133-4-git-send-email-ying.huang@intel.com>
	<20110413210757.GA11683@Krystal>
	<4DA7903B.5030508@intel.com>
	<20110415164629.GA13983@Krystal>
	<20110415174320.GA2283@linux.vnet.ibm.com>
	<20110415174451.GB19644@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48701 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab1DRLmS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Apr 2011 07:42:18 -0400
In-Reply-To: <20110415174451.GB19644@Krystal>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Hi, Paul,

On Sat, Apr 16, 2011 at 1:44 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
>> On Fri, Apr 15, 2011 at 12:46:29PM -0400, Mathieu Desnoyers wrote:
>> > * Huang Ying (ying.huang@intel.com) wrote:
>> > > On 04/14/2011 05:07 AM, Mathieu Desnoyers wrote:
>> > > > * Huang Ying (ying.huang@intel.com) wrote:
>> > > > [...]
>> > > >> + * rcu_read_lock and rcu_read_unlock is not used int gen_poo=
l_alloc,
>> > > >> + * gen_pool_free, gen_pool_avail and gen_pool_size etc, beca=
use chunks
>> > > >> + * are only added into pool, not deleted from pool unless th=
e pool
>> > > >> + * itself is destroyed. =C2=A0If chunk will be deleted from =
pool,
>> > > >> + * rcu_read_lock and rcu_read_unlock should be uses in these
>> > > >> + * functions.
>> > > >
>> > > > So how do you protect between pool destruction and adding chun=
ks into
>> > > > the pool ?
>> > >
>> > > Because the pool itself will be freed when destruction, we need =
some
>> > > mechanism outside of pool. =C2=A0For example, if gen_pool_add() =
is called via
>> > > device file IOCTL, we must un-register the device file first, an=
d
>> > > destroy the pool after the last reference to device has gone.
>> >
>> > I am concerned about the list_for_each_entry_rcu() (and thus
>> > rcu_dereference_raw()) used outside of rcu_read_lock/unlock pairs.
>> > Validation infrastructure as recently been added to RCU: it trigge=
rs
>> > warnings when these situations are encountered in some RCU debuggi=
ng
>> > configurations. The case of RCU list iteration is not covered by t=
he
>> > checks, but it would make sense to be aware of it.
>> >
>> > So although it seems like your code does not require rcu read lock
>> > critical sections, I'd prefer to let Paul McKenney have a look.
>>
>> As long as you add elements and never remove them, then you can get
>> away with using list_for_each_entry_rcu() outside of an RCU read-sid=
e
>> critical section. =C2=A0But please comment this -- it is all too eas=
y
>> for someone to decide later to start deleting elements without also
>> inserting the needed rcu_read_lock() and rcu_read_unlock() pairs.
>>
>> But I have lost the thread -- what code am I supposed to look at?
>
> You can have a look at https://lkml.org/lkml/2011/4/13/56

What do you think about this patch and its usage of RCU?

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
