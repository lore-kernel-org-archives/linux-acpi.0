From: david@lang.hm
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Wed, 28 May 2008 02:19:05 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0805280217510.2373@asgard.lang.hm>
References: <1183030080.4249.172.camel@queen.suse.de> <Pine.LNX.4.64.0707292058040.6510@asgard.lang.hm> <200707300808.17934.bjorn.helgaas@hp.com> <200805271711.37254.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lang.hm ([64.81.33.126]:46904 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbYE1JTa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 May 2008 05:19:30 -0400
In-Reply-To: <200805271711.37254.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

On Tue, 27 May 2008, Bjorn Helgaas wrote:

>> On Sunday 29 July 2007 09:59:18 pm david@lang.hm wrote:
>>> On Sun, 29 Jul 2007, Bjorn Helgaas wrote:
>>>> This seems an awful lot like this bug report:
>>>>  http://bugzilla.kernel.org/show_bug.cgi?id=5832
>>>>
>>>> Can you take a look at 5832, and maybe we can combine your problem
>>>> with that one if you agree they look the same?
>>>
>>> yes, it definantly looks like the same thing.
>
> Hi David,
>
> I think 2.6.25 + the patch here:
>    http://marc.info/?l=linux-acpi&m=121190728701748&w=2
>
> should fix the parallel port problem you saw.  If you have a
> chance to confirm or disprove that, I'd appreciate hearing
> about it.  I'm trying to get this change in for 2.6.26.

I'll see what I can do. I've moved twice since running into this and at 
the moment the printer is hooked to a network dongle, I'll move it to the 
server and try a couple tests, probably not before thursday though.

David Lang
