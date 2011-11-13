From: Keir Fraser <keir.xen@gmail.com>
Subject: Re: [Xen-devel] Re: Regression in 3.1 causes Xen to use wrong idle
 routine
Date: Sun, 13 Nov 2011 16:59:10 +0000
Message-ID: <CAE5A7DE.24C94%keir.xen@gmail.com>
References: <CAJvTdK=yAek4sJFXUp=kQSmnuE=HpgefN5Q-GLWhMXo=LhJ-2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54368 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab1KMQ7W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Nov 2011 11:59:22 -0500
Received: by wyh15 with SMTP id 15so5203924wyh.19
        for <linux-acpi@vger.kernel.org>; Sun, 13 Nov 2011 08:59:21 -0800 (PST)
In-Reply-To: <CAJvTdK=yAek4sJFXUp=kQSmnuE=HpgefN5Q-GLWhMXo=LhJ-2A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Stefan Bader <stefan.bader@canonical.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

On 13/11/2011 03:46, "Len Brown" <lenb@kernel.org> wrote:

>> The problem I see is that select_idle_routine() is called from
>> arch/x86/kernel/cpu/common.c and since Xen setup does not set pm_idle
>> anymore, it can cause mwait_idle or amd_e400_idle functions to be selected.
>> In testing it seem amd_e400_idle in PVM domU at least does not immediately
>> cause
>> problems, but mwait_idle just causes crashes. From the reports I have
>> this may be related to older hypervisors (3.1 and older) not clearing the
>> mwait
>> capability. But overall there seems something wrong in the interaction.
> 
> Why is Xen advertising X86_FEATURE_MWAIT and then crashing
> when the dom0 (or other guests) use what it advertises?
> 
> What versions of Xen have this bug?

Xen doesn't advertise MWAIT. Possibly Xen-pv_ops is lying to the rest of the
kernel via the cpuid pv_ops hook. This would probably be because Xen is
relying on the OSPM in dom0 kernel to parse out Cx/Px info which Xen itself
*can* use.

 -- Keir


