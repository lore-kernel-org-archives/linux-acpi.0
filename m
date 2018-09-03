From: Jirka Hladky <jhladky@redhat.com>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Mon, 3 Sep 2018 17:07:15 +0200
Message-ID: <CAE4VaGDTNgu=JX=N7=uZu0Bz_vUdHszZQ9_SQuwrbjRvFjCwZw@mail.gmail.com>
References: <CAE4VaGAPOfy0RtQehKoe+443C1GRrJXCveBFgcAZ1nChVavp1g@mail.gmail.com>
 <CAE4VaGBMeL82SJK53gtcWkor-9eXeLX6VP9juw=FW=BOyp+hMA@mail.gmail.com>
 <20180621092331.p2pmaiu6563kp5u2@techsingularity.net> <CAE4VaGCQV+cS-vhdLyMwzftbB-xBHPt4Y4chg_0ykLHTE9cRfw@mail.gmail.com>
 <CAE4VaGDHcZbnDpJ+FiQLfA1DRftY0j_GJSnh3FDRi34OztVH6Q@mail.gmail.com>
 <20180627084954.73ucqvac62v5gje4@techsingularity.net> <CAE4VaGA9KzX05rdfw2PhEATLisV-NVMc9rOyjzSg-rX1rug9Dw@mail.gmail.com>
 <CABuKy6MUNX85PBVchz_hqXy+FxXU2x0U9ZEZB13rVSLGpWOWvQ@mail.gmail.com>
 <CAE4VaGD12BLS_kk=pRwgTKL8YOU63Nowwa42cEdZObQ=P1MFnA@mail.gmail.com>
 <CAE4VaGArxDYHzg8G203yKjgkuw3mULFSw8yCYbCcqvAUSUxy+A@mail.gmail.com>
 <20180717100329.yfy7igdsrpk5ujf4@techsingularity.net> <CAE4VaGA_L1AEj+Un0oQEEqZp_jgaFLk+Z=vNoad08oXnU2T1nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE4VaGA_L1AEj+Un0oQEEqZp_jgaFLk+Z=vNoad08oXnU2T1nw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Kamil Kolakowski <kkolakow@redhat.com>, Jakub Racek <jracek@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Resending in the plain text mode.

> My own testing completed and the results are within expectations and I
> saw no red flags. Unfortunately, I consider it unlikely they'll be merged
> for 4.18. Srikar Dronamraju's series is likely to need another update
> and I would need to rebase my patches on top of that. Given the scope
> and complexity, I find it unlikely they would be accepted for an -rc,
> particularly this late of an rc. Whether we hit the 4.19 merge window or
> not will depend on when Srikar's series gets updated.


Hi Mel,

we have collaborated back in July on the scheduler patch, improving
the performance by allowing faster memory migration. You came up with
the "sched-numa-fast-crossnode-v1r12" series here:

https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git

which has shown good performance results both in your and our testing.

Do you have some update on the latest status? Is there any plan to
merge this series into 4.19 kernel? We have just tested 4.19.0-0.rc1.1
and based on the results it seems that the patch is not included (and
I don't see it listed in  git shortlog v4.18..v4.19-rc1
./kernel/sched)

With 4.19rc1 we see performance drop
  * up to 40% (NAS bench) relatively to  4.18 + sched-numa-fast-crossnode-v1r12
  * up to 20% (NAS, Stream, SPECjbb2005, SPECjvm2008) relatively to 4.18 vanilla
The performance is dropping. It's quite unclear what are the next
steps - should we wait for "sched-numa-fast-crossnode-v1r12" to be
merged or should we start looking at what has caused the drop in
performance going from 4.19rc1 to 4.18?

We would appreciate any guidance on how to proceed.

Thanks a lot!
Jirka

On Mon, Sep 3, 2018 at 5:04 PM, Jirka Hladky <jhladky@redhat.com> wrote:
>> My own testing completed and the results are within expectations and I
>> saw no red flags. Unfortunately, I consider it unlikely they'll be merged
>> for 4.18. Srikar Dronamraju's series is likely to need another update
>> and I would need to rebase my patches on top of that. Given the scope
>> and complexity, I find it unlikely they would be accepted for an -rc,
>> particularly this late of an rc. Whether we hit the 4.19 merge window or
>> not will depend on when Srikar's series gets updated.
>
>
> Hi Mel,
>
> we have collaborated back in July on the scheduler patch, improving the
> performance by allowing faster memory migration. You came up with the
> "sched-numa-fast-crossnode-v1r12" series here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
>
> which has shown good performance results both in your and our testing.
>
> Do you have some update on the latest status? Is there any plan to merge
> this series into 4.19 kernel? We have just tested 4.19.0-0.rc1.1 and based
> on the results it seems that the patch is not included (and I don't see it
> listed in  git shortlog v4.18..v4.19-rc1 ./kernel/sched)
>
> With 4.19rc1 we see performance drop
>
> up to 40% (NAS bench) relatively to  4.18 + sched-numa-fast-crossnode-v1r12
> up to 20% (NAS, Stream, SPECjbb2005, SPECjvm2008) relatively to 4.18 vanilla
>
> The performance is dropping. It's quite unclear what are the next steps -
> should we wait for "sched-numa-fast-crossnode-v1r12" to be merged or should
> we start looking at what has caused the drop in performance going from
> 4.19rc1 to 4.18?
>
> We would appreciate any guidance on how to proceed.
>
> Thanks a lot!
> Jirka
>
>
>
>
> On Tue, Jul 17, 2018 at 12:03 PM, Mel Gorman <mgorman@techsingularity.net>
> wrote:
>>
>> On Tue, Jul 17, 2018 at 10:45:51AM +0200, Jirka Hladky wrote:
>> > Hi Mel,
>> >
>> > we have compared 4.18 + git://
>> > git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
>> > sched-numa-fast-crossnode-v1r12 against 4.16 kernel and performance
>> > results
>> > look very good!
>> >
>>
>> Excellent, thanks to both Kamil and yourself for collecting the data.
>> It's helpful to have independent verification.
>>
>> > We see performance gains about 10-20% for SPECjbb2005. NAS results are a
>> > little bit noisy but show overall performance gains as well (total
>> > runtime
>> > for reduced from 6 hours 34 minutes to 6 hours 26 minutes to give you a
>> > specific example).
>>
>> Great.
>>
>> > The only benchmark showing a slight regression is stream
>> > - but the regression is just a few percents ( upto 10%) and I think it's
>> > not a real concern given that it's an artificial benchmark.
>> >
>>
>> Agreed.
>>
>> > How is your testing going? Do you think
>> > that sched-numa-fast-crossnode-v1r12 series can make it into the 4.18?
>> >
>>
>> My own testing completed and the results are within expectations and I
>> saw no red flags. Unfortunately, I consider it unlikely they'll be merged
>> for 4.18. Srikar Dronamraju's series is likely to need another update
>> and I would need to rebase my patches on top of that. Given the scope
>> and complexity, I find it unlikely they would be accepted for an -rc,
>> particularly this late of an rc. Whether we hit the 4.19 merge window or
>> not will depend on when Srikar's series gets updated.
>>
>> > Thanks a lot for your efforts to improve the performance!
>>
>> My pleasure.
>>
>> --
>> Mel Gorman
>> SUSE Labs
>
>
