From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Fri, 10 Nov 2006 13:11:28 -0700
Message-ID: <m1u017hxjj.fsf@ebiederm.dsl.xmission.com>
References: <5986589C150B2F49A46483AC44C7BCA49071D9@ssvlexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31666 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1424423AbWKJUMq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Nov 2006 15:12:46 -0500
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA49071D9@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Fri, 10 Nov 2006 10:20:58 -0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: Andi Kleen <ak@suse.de>, Olivier Nicolas <olivn@trollprod.org>, Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>, Stephen Hemminger <shemminger@osdl.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> Andi,
>
> The two patches solve the problems that irq nobody care.
>
> They are already in your tree. But first one I wonder if you put correct
> one in your tree.

YH.  This is a completely different problem.  The irq is properly setup
and received but none of the drivers wanted it.

Eric
