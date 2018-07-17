From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Tue, 17 Jul 2018 11:03:30 +0100
Message-ID: <20180717100329.yfy7igdsrpk5ujf4@techsingularity.net>
References: <CAE4VaGAPOfy0RtQehKoe+443C1GRrJXCveBFgcAZ1nChVavp1g@mail.gmail.com>
 <CAE4VaGBMeL82SJK53gtcWkor-9eXeLX6VP9juw=FW=BOyp+hMA@mail.gmail.com>
 <20180621092331.p2pmaiu6563kp5u2@techsingularity.net>
 <CAE4VaGCQV+cS-vhdLyMwzftbB-xBHPt4Y4chg_0ykLHTE9cRfw@mail.gmail.com>
 <CAE4VaGDHcZbnDpJ+FiQLfA1DRftY0j_GJSnh3FDRi34OztVH6Q@mail.gmail.com>
 <20180627084954.73ucqvac62v5gje4@techsingularity.net>
 <CAE4VaGA9KzX05rdfw2PhEATLisV-NVMc9rOyjzSg-rX1rug9Dw@mail.gmail.com>
 <CABuKy6MUNX85PBVchz_hqXy+FxXU2x0U9ZEZB13rVSLGpWOWvQ@mail.gmail.com>
 <CAE4VaGD12BLS_kk=pRwgTKL8YOU63Nowwa42cEdZObQ=P1MFnA@mail.gmail.com>
 <CAE4VaGArxDYHzg8G203yKjgkuw3mULFSw8yCYbCcqvAUSUxy+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE4VaGArxDYHzg8G203yKjgkuw3mULFSw8yCYbCcqvAUSUxy+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jirka Hladky <jhladky@redhat.com>
Cc: Kamil Kolakowski <kkolakow@redhat.com>, Jakub Racek <jracek@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 17, 2018 at 10:45:51AM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> we have compared 4.18 + git://
> git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
> sched-numa-fast-crossnode-v1r12 against 4.16 kernel and performance results
> look very good!
> 

Excellent, thanks to both Kamil and yourself for collecting the data.
It's helpful to have independent verification.

> We see performance gains about 10-20% for SPECjbb2005. NAS results are a
> little bit noisy but show overall performance gains as well (total runtime
> for reduced from 6 hours 34 minutes to 6 hours 26 minutes to give you a
> specific example).

Great.

> The only benchmark showing a slight regression is stream
> - but the regression is just a few percents ( upto 10%) and I think it's
> not a real concern given that it's an artificial benchmark.
> 

Agreed.

> How is your testing going? Do you think
> that sched-numa-fast-crossnode-v1r12 series can make it into the 4.18?
> 

My own testing completed and the results are within expectations and I
saw no red flags. Unfortunately, I consider it unlikely they'll be merged
for 4.18. Srikar Dronamraju's series is likely to need another update
and I would need to rebase my patches on top of that. Given the scope
and complexity, I find it unlikely they would be accepted for an -rc,
particularly this late of an rc. Whether we hit the 4.19 merge window or
not will depend on when Srikar's series gets updated.

> Thanks a lot for your efforts to improve the performance!

My pleasure.

-- 
Mel Gorman
SUSE Labs
