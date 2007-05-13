From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: ACPI Power Down is broken in 2.6.21.1
Date: Sun, 13 May 2007 16:29:25 +0200
Message-ID: <6bffcb0e0705130729n2c47f0f4h6791ac4b74b9bb62@mail.gmail.com>
References: <loom.20070508T175303-27@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:10605 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781AbXEMO30 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 May 2007 10:29:26 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1545568nzf
        for <linux-acpi@vger.kernel.org>; Sun, 13 May 2007 07:29:25 -0700 (PDT)
In-Reply-To: <loom.20070508T175303-27@post.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vladimir Pouzanov <farcaller@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Vladimir,

[adding Len and ACPI gurus to CC]

On 08/05/07, Vladimir Pouzanov <farcaller@gmail.com> wrote:
> Hi all,
>
> I have got a problem with Asus F3T notebook and 2.6.21.1 kernel. When I
> perform powerdown (with user-space app or alt+sysrq+o) I get "Power Down."
> message, but the notebook doesn't turn off. Everything is ok on 2.6.20.
>
> There seem to be no changes in acpi/sleep/poweroff.c so I don't know where
> should I start looking for a bug.
>
> F3T is based on Thrion64 X2 CPU (I'm running it in x86 mode with SMP and
> PREEMPT).
>
> Sincerely,
> Vladimir "Farcaller" Pouzanov
> http://hackndev.com
>

I added this bug to the list of known regressions.
(http://kernelnewbies.org/known_regressions)

Regards,
Michal

-- 
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
