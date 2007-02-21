From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH - 2.6.19 -0/2] Backport of psmouse suspend/shutdown cleanups
Date: Wed, 21 Feb 2007 12:26:06 -0500
Message-ID: <d120d5000702210926j7e7f1ccjb8c2689640b870e8@mail.gmail.com>
References: <1172077685.10619.101.camel@d36.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:46816 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030385AbXBUR0J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Feb 2007 12:26:09 -0500
Received: by an-out-0708.google.com with SMTP id b33so627445ana
        for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2007 09:26:08 -0800 (PST)
In-Reply-To: <1172077685.10619.101.camel@d36.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Stable <Stable@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-acpi <linux-acpi@vger.kernel.org>

On 2/21/07, Thomas Renninger <trenn@suse.de> wrote:
> Hi,
>
> I like to ask for inclusion into stable series for these.
>
> The original patch from Dmitry can be found here:
> http://bugzilla.kernel.org/show_bug.cgi?id=7689
> comment #64, #65.
>
> The reason is:
>  - These patches fix a lot weird stuff on all recent
>   HP nc/nx series laptop models.
>
>  - The problem with the psmouse thing is, if you booted
>   a broken kernel, rebooting a fixed one will still result
>   in a broken system (things break (or get fixed) on shutdown
>   and survive the reboot).
>   Therefore the patch(es) should get into as much kernels
>   as possible to avoid further confusions on bug reports...
>
> This test report shows the behavior nicely:
> http://bugzilla.kernel.org/show_bug.cgi?id=7689#c45:
> 1-Boot   in good state with original kernel
> 2-Reboot going in bad state with original kernel
> 3-Reboot with 2.6.20 patched kernel->still in bad state
> 4-Reboot with 2.6.20 patched kernel->going in good
>         state: battery reporting ok,
>         cpufreq working and go to full speed.
> 5-reboot with original Fedora kernel->still in *good* state
> 6-reboot going in bad state
>
> The symptoms of breakages are (because of wrong EC reads/writes)
> very different, depending on the laptop model:
>
>  - Cannot reach highest freq on (all?) HP Intel Dual core machines
>    This is the only 100% reproducable bug I saw...
>
>  - Shutdowns because of critical temperature (e.g. showing 1200 C)
>    HP NX 9420 shutting down on huge, bogus thermal temperature values
>    https://bugzilla.novell.com/show_bug.cgi?id=234475
>
>  - There are probably a lot other bug reports out there that
>    will lead to this problem...
>
>
> These are patches against the plain 2.6.19 kernel (not stable .X,
> I hope nothing changed at these specific files..., if there
> changed something I can resubmit).
>
> As we are using these in SLE10 SP1, I did the backports back to
> 2.6.16 and will send more if I get your ok for that.
>
> Dmitry (or others), can you please review. I had to fiddle a bit on
> each kernel version. I did a compile test on x86_64 (CONFIG_PM on)
> and powerpc (CONFIG_PM off). And I verified 2.6.20 (original) and
> 2.6.16 working with s2disk and s2ram. Still I could have done a
> little typo/mistake somewhere...
>

Hi Thomas,

The patches look good, however I believe that only psmouse patch is
enough to fix the issues you referring to in your mail (I don't have a
box that exibits these symptoms so I can't verify). The second patch,
while useful, should not be included in stable series unless the first
patch alone does not work.

-- 
Dmitry
