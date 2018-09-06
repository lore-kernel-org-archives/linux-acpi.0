From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Thu, 6 Sep 2018 13:58:43 +0100
Message-ID: <20180906125843.GC1719@techsingularity.net>
References: <CAE4VaGA9KzX05rdfw2PhEATLisV-NVMc9rOyjzSg-rX1rug9Dw@mail.gmail.com>
 <CABuKy6MUNX85PBVchz_hqXy+FxXU2x0U9ZEZB13rVSLGpWOWvQ@mail.gmail.com>
 <CAE4VaGD12BLS_kk=pRwgTKL8YOU63Nowwa42cEdZObQ=P1MFnA@mail.gmail.com>
 <CAE4VaGArxDYHzg8G203yKjgkuw3mULFSw8yCYbCcqvAUSUxy+A@mail.gmail.com>
 <20180717100329.yfy7igdsrpk5ujf4@techsingularity.net>
 <CAE4VaGA_L1AEj+Un0oQEEqZp_jgaFLk+Z=vNoad08oXnU2T1nw@mail.gmail.com>
 <CAE4VaGDTNgu=JX=N7=uZu0Bz_vUdHszZQ9_SQuwrbjRvFjCwZw@mail.gmail.com>
 <20180904090053.GB1719@techsingularity.net>
 <CAE4VaGB-mFfAR_rKUbGx01HLDQtyjHQLNOrm3fc+aSq2D2O2Dg@mail.gmail.com>
 <CAE4VaGATB4M7-osmi0wqovGbZb7os+ukMHi+Lbum3tegpHxGNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE4VaGATB4M7-osmi0wqovGbZb7os+ukMHi+Lbum3tegpHxGNw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jirka Hladky <jhladky@redhat.com>
Cc: Kamil Kolakowski <kkolakow@redhat.com>, Jakub Racek <jracek@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 06, 2018 at 10:16:28AM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> we have results with 2d4056fafa196e1ab4e7161bae4df76f9602d56d reverted.
> 
>   * Compared to 4.18, there is still performance regression -
> especially with NAS (sp_C_x subtest) and SPECjvm2008. On 4 NUMA
> systems, regression is around 10-15%
>   * Compared to 4.19rc1 there is a clear gain across all benchmarks around 20%
> 

Ok.

> While reverting 2d4056fafa196e1ab4e7161bae4df76f9602d56d has helped a
> lot there is another issue as well. Could you please recommend some
> commit prior to 2d4056fafa196e1ab4e7161bae4df76f9602d56d to try?
> 

Maybe 305c1fac3225dfa7eeb89bfe91b7335a6edd5172. That introduces a weird
condition in terms of idle CPU handling that has been problematic.

> Regarding the current results, how do we proceed? Could you please
> contact Srikar and ask for the advice or should we contact him
> directly?
> 

I would suggest contacting Srikar directly. While I'm working on a
series that touches off some similar areas, there is no guarantee it'll
be a success as I'm not primarily upstream focused at the moment.

Restarting the thread would also end up with a much more sensible cc
list.

-- 
Mel Gorman
SUSE Labs
