From: "Aaron Durbin" <adurbin@google.com>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Tue, 17 Jul 2007 08:08:19 -0700
Message-ID: <8f95bb250707170808n19799ba5l3acd13e2ee7e0f08@mail.gmail.com>
References: <20070716180019.GA5112@google.com> <200707171331.59414.ak@suse.de>
	 <86802c440707170740i30ed2110l130dafbec8e4d4a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:22975 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933907AbXGQPIY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 11:08:24 -0400
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id l6HF8LRH004668
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 08:08:21 -0700
Received: from wa-out-1112.google.com (wafj32.prod.google.com [10.114.186.32])
	by zps36.corp.google.com with ESMTP id l6HF8Cea019028
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 08:08:19 -0700
Received: by wa-out-1112.google.com with SMTP id j32so1959151waf
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 08:08:19 -0700 (PDT)
In-Reply-To: <86802c440707170740i30ed2110l130dafbec8e4d4a5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org

On 7/17/07, Yinghai Lu <yhlu.kernel@gmail.com> wrote:
> On 7/17/07, Andi Kleen <ak@suse.de> wrote:
> > On Monday 16 July 2007 20:00:19 Aaron Durbin wrote:
> > >
> > > Add the ability to reset the machine using the RESET_REG in ACPI's FADT table.
> >
> > Why? I had such a patch at some point as experiment, but it never
> > helped actually fix a box.
> >
> system without superio, should still have SMI to simulate one keyboard
> controller. So the key board reset still works.

This is true if SMIs are still flowing, and the SMI handler correctly handles
the reset properly. I have seen cases where the SMI handler is broken which
causes the system to perpetually hang. Utilizing the exposed reset mechanism
in ACPI should reset the system every time. However, if the reset fails it
will fall back to the keyboard controller.

-Aaron
