From: "Aaron Durbin" <adurbin@google.com>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Tue, 17 Jul 2007 08:08:24 -0700
Message-ID: <8f95bb250707170808u5afee515y592c0a0ccafa95b2@mail.gmail.com>
References: <20070716180019.GA5112@google.com> <200707171331.59414.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:8533 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934121AbXGQPIa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 11:08:30 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id l6HF8REH027710
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 16:08:27 +0100
Received: from wa-out-1112.google.com (wagn7.prod.google.com [10.114.215.7])
	by zps35.corp.google.com with ESMTP id l6HF7Zmp027882
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 08:08:24 -0700
Received: by wa-out-1112.google.com with SMTP id n7so2260062wag
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 08:08:24 -0700 (PDT)
In-Reply-To: <200707171331.59414.ak@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org

On 7/17/07, Andi Kleen <ak@suse.de> wrote:
> On Monday 16 July 2007 20:00:19 Aaron Durbin wrote:
> >
> > Add the ability to reset the machine using the RESET_REG in ACPI's FADT table.
>
> Why? I had such a patch at some point as experiment, but it never
> helped actually fix a box.

I have a box here that it fixes, but I also don't see what it hurts. How much
are you against the patch? If the keyboard controller won't work and there are
issues using the triple fault, but if the RESET_REG is setup properly it will
definitely reboot the machine as intended with no ill side effects.

-Aaron
