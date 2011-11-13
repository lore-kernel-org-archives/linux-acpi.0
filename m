From: Len Brown <lenb@kernel.org>
Subject: Re: Regression in 3.1 causes Xen to use wrong idle routine
Date: Sat, 12 Nov 2011 22:46:36 -0500
Message-ID: <CAJvTdK=yAek4sJFXUp=kQSmnuE=HpgefN5Q-GLWhMXo=LhJ-2A@mail.gmail.com>
References: <4EA7DFD1.9060608@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f66.google.com ([209.85.214.66]:56713 "EHLO
	mail-bw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab1KMDqi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Nov 2011 22:46:38 -0500
Received: by bkbzt12 with SMTP id zt12so1162436bkb.1
        for <linux-acpi@vger.kernel.org>; Sat, 12 Nov 2011 19:46:37 -0800 (PST)
In-Reply-To: <4EA7DFD1.9060608@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

On Wed, Oct 26, 2011 at 6:24 AM, Stefan Bader
<stefan.bader@canonical.com> wrote:
> The following commit changes calls to pm_idle into first trying
> cpuidle_call_idle() and if that returns non-zero to fall back to
> call pm_idle().
>
> commit a0bfa1373859e9d11dc92561a8667588803e42d8
> Author: Len Brown <len.brown@intel.com>
> Date: =A0 Fri Apr 1 19:34:59 2011 -0400
>
> =A0 =A0cpuidle: stop depending on pm_idle
>
> However cpuidle_call_idle() will return -ENODEV if it is supposed to =
be disabled
> by cpuidle.off. Which then causes pm_idle() to be called.
>
> This has some bad interaction with the following change that tries to
> make use of disabling cpuidle in Xen to fall back to hlt.
>
> commit d91ee5863b71e8c90eaf6035bff3078a85e2e7b5
> Author: Len Brown <len.brown@intel.com>
> Date: =A0 Fri Apr 1 18:28:35 2011 -0400
>
> =A0 =A0cpuidle: replace xen access to x86 pm_idle and default_idle
>
> The problem I see is that select_idle_routine() is called from
> arch/x86/kernel/cpu/common.c and since Xen setup does not set pm_idle
> anymore, it can cause mwait_idle or amd_e400_idle functions to be sel=
ected.
> In testing it seem amd_e400_idle in PVM domU at least does not immedi=
ately cause
> problems, but mwait_idle just causes crashes. From the reports I have
> this may be related to older hypervisors (3.1 and older) not clearing=
 the mwait
> capability. But overall there seems something wrong in the interactio=
n.

Why is Xen advertising X86_FEATURE_MWAIT and then crashing
when the dom0 (or other guests) use what it advertises?

What versions of Xen have this bug?

> I am not really sure whether the logic of calling pm_idle() on all er=
rors from
> cpuidle_call_idle() is already flawed or the assumption in the Xen pa=
tch about
> being able to prevent the wrong idle function by turning cpuidle off =
is incorrect.

The patches above appear to be operating as intended.
What wasn't expected, was that some version of Xen is deployed that
advertises the MWAIT feature, but crashes when it is used.

> One quick fix could be to add some Xen case into select_idle_routine(=
) which
> picks default_idle...

No.

Working around this Xen bug for a newly compiled Dom0 is insufficient.

All guests that also look for MWAIT support w/o asking ACPI
(ie. all versions of Linux that use intel_idle, such as the last few
=46edora's, RHEL, SLES etc.)
will trip over the same Xen bug, even if Dom0 doesn't.

Xen must not advertises MWAIT support if it doesn't have MWAIT support.

thanks,
Len Brown, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
