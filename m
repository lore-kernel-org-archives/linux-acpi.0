From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] ACPICA: disable ACPI 2.0 _GTS/_BFS support
Date: Fri, 19 Dec 2008 18:48:49 +0100
Message-ID: <200812191848.49928.rjw@sisk.pl>
References: <alpine.LFD.2.00.0812190421140.1988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46158 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbYLSRtQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 12:49:16 -0500
In-Reply-To: <alpine.LFD.2.00.0812190421140.1988@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Friday, 19 of December 2008, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> Organization: Intel Open Source Technology Center
> 
> ACPI 2.0 defined two new methods in the suspend/resume sequence,
> _GTS (Going to Sleep) and _BFS (Back from Sleep)
> 
> They are optional methods, but if the BIOS supplies them,
> the OS is supposed to evaluate them immediately before
> writing the register to sleep, and immediately after waking up --
> a time when interrupts are disabled.
> 
> The spec says that they must be self-contained
> methods, not calling any other methods, perhaps
> because that they are run under unique conditions?
> 
> These methodds are evaluated in Linux by
> acpi_evaluate_object(), which always kmalloc's
> a return structure to conserve stack space.
> But kmalloc with interrupts off is problematic --
> do we really want to insist on GFP_ATOMIC here?

Well, I think we should.

Alternatively, we can keep a preallocated buffer for this purpose.

> Now, several years after ACPI 2.0 was released,
> we have yet to observe a single implementation of
> _GTS/_BFS in the field -- suggesting that they will
> never actually be deployed.
> 
> So lets keep Linux simple by removing this
> theoretical support for _GTS/_BFS, the only
> AML methods that mandated being evaluated
> with interrupts disabled.

I'm not sure if I agree with this approach.

My opinion is that we should be able to execute AML code with interrupts
disabled and there should be means to do that.

The entire irqrouter_resume() thing requires us to evaluate AML with interrupts
disabled and in that particular case it also really _makes_ _sense_.

So, IMO dropping _GTS/_BFS doesn't really buy us anything.

Thanks,
Rafael
