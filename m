From: "Aaron Durbin" <adurbin@google.com>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Tue, 17 Jul 2007 08:47:56 -0700
Message-ID: <8f95bb250707170847t5b3aded3hb6d08f825362f76c@mail.gmail.com>
References: <20070716180019.GA5112@google.com>
	 <86802c440707170740i30ed2110l130dafbec8e4d4a5@mail.gmail.com>
	 <8f95bb250707170808n19799ba5l3acd13e2ee7e0f08@mail.gmail.com>
	 <200707171742.39067.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:12124 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935151AbXGQPsN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 11:48:13 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id l6HFm43v031610
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 16:48:05 +0100
Received: from nz-out-0506.google.com (nzfl1.prod.google.com [10.36.188.1])
	by zps38.corp.google.com with ESMTP id l6HFlu1l017803
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 08:47:56 -0700
Received: by nz-out-0506.google.com with SMTP id l1so1075096nzf
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 08:47:56 -0700 (PDT)
In-Reply-To: <200707171742.39067.ak@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org

On 7/17/07, Andi Kleen <ak@suse.de> wrote:
> On Tuesday 17 July 2007 17:08:19 Aaron Durbin wrote:
>
> > This is true if SMIs are still flowing, and the SMI handler correctly handles
> > the reset properly. I have seen cases where the SMI handler is broken which
> > causes the system to perpetually hang.
>
> Ah, that is the rationale that was missing in the first mail ...
> Ok that makes some sense. Is it a common issue?
>

I am not sure in how common it is, but I have access to some machines around
here that are displaying this issue.

-Aaron
