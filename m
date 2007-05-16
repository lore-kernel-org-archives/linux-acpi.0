From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: [1/3] 2.6.22-rc1: known regressions v2
Date: Wed, 16 May 2007 15:08:44 -0700
Message-ID: <2c0942db0705161508jc53353ev8a2aa8c5f372d982@mail.gmail.com>
References: <464B6A22.905@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:4532 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359AbXEPWIq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 May 2007 18:08:46 -0400
Received: by ug-out-1314.google.com with SMTP id 44so209500uga
        for <linux-acpi@vger.kernel.org>; Wed, 16 May 2007 15:08:45 -0700 (PDT)
In-Reply-To: <464B6A22.905@googlemail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On 5/16/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> ACPI
>
> Subject    : nx6125 has lost fan control
> References : http://lkml.org/lkml/2007/5/16/249
> Submitter  : Ray Lee <ray-lk@madrabbit.org>
> Status     : Unknown

While it worked in 2.6.21, that was pretty much the only point-release
kernel where it did. In other words, I'm honestly not sure I'd
classify this as a regression given it worked exactly once :-/. So,
I'd suggest pulling this from the list for now unless Len decides
otherwise.

Ray
