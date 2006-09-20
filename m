From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: Re: A bug or not? No C states on Turion64 ML-34
Date: Wed, 20 Sep 2006 19:51:55 +0100
Message-ID: <200609201951.55684.tvrtko@ursulin.net>
References: <200609171646.46064.tvrtko@ursulin.net> <200609192316.26355.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outmail1.freedom2surf.net ([194.106.33.237]:8874 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S932247AbWITSv7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Sep 2006 14:51:59 -0400
In-Reply-To: <200609192316.26355.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org


[Resend: I think it didn't go through the last time, so this time I replaced 
attachments with links. I also updated my comments on temperature readings.]

On Wednesday 20 September 2006 04:16, Len Brown wrote:
> On Sunday 17 September 2006 11:46, Tvrtko A. Ursulin wrote:
> > On my new HP Pavilion s7510 PC I seem to be missing C states
>
> ...
>
> > tvrtko@astrid:~> cat /proc/acpi/processor/CPU0/power
> > active state:            C1
> > max_cstate:              C8
> > bus master activity:     00000000
> > states:
> >    *C1:                  type[C1] promotion[--] demotion[--] latency[000]
> > usage[00000000]
>
> Don't be bothered by the 0 usage, C1 always works.
>
> Dunno if this processor and BIOS support more C-states or not.
> Maybe somebody else who has one has checked it out?
>
> I have seen an ML-28 which support C1 and C3 -- though maybe
> an ML-28 is different from an ML-34...
>
> It is possible that an additional C-state will appear when you switch to
> battery mode. If you post the output from acpidump it will be easy to tell.

Hi Len,

It's a desktop box so it doesn't have a battery. In the meantime I was playing 
with DSDT which was producing many compile errors/warnings but after I 
"fixed" it nothing much happened except irq routing changed.

Basically, my main gripe is that the fan is always on (although slow spinning) 
and reported temperature is always 40degC, no matter is the CPU idle or busy. 
Which in combination with no C states makes me think if things could be 
better if everything was working correctly.

Links to original and my DSDT and acpi.dump:
http://www.ursulin.net/acpi.dump
http://www.ursulin.net/dsdt.orig
http://www.ursulin.net/dsdt.new

Thanks,

Tvrtko
