From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: [1/5] 2.6.22-rc2: known regressions
Date: Mon, 21 May 2007 17:29:40 -0700
Message-ID: <2c0942db0705211729r185d7d77r2750d82f4a3b3e9c@mail.gmail.com>
References: <464F74BB.9070402@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:34340 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100AbXEVA3m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 May 2007 20:29:42 -0400
Received: by ug-out-1314.google.com with SMTP id 44so100376uga
        for <linux-acpi@vger.kernel.org>; Mon, 21 May 2007 17:29:40 -0700 (PDT)
In-Reply-To: <464F74BB.9070402@googlemail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Adrian McMenamin <adrian@newgolddream.dyndns.info>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Hey there,

On 5/19/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Here is a list of some known regressions in 2.6.22-rc2.
>
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
>
> Subject    : nx6125 has lost fan control
> References : http://lkml.org/lkml/2007/5/16/249
> Submitter  : Ray Lee <ray-lk@madrabbit.org>
> Status     : Unknown

I'm withdrawing this one. At boot, it wasn't controlling the fans, but
after a suspend-resume it started up fine. My subsequent boots have
also been okay, so I'm at a loss to explain what I saw.

Regardless, given that it's hard to reproduce, I have no evidence that
it's a regression, it could just be something that's really rare.

Thanks,

Ray
