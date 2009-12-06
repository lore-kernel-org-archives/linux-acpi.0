From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 14:54:48 -0800
Message-ID: <7AB497C7-8495-4535-9E83-81307E008BF4@gmail.com>
References: <200912052216.19540.rjw@sisk.pl> <200912060055.36130.rjw@sisk.pl> <alpine.LFD.2.00.0912051635330.3560@localhost.localdomain> <200912060254.10081.rjw@sisk.pl> <alpine.LFD.2.00.0912051758190.3560@localhost.localdomain> <20091206113555.5a646713@infradead.org> <alpine.LFD.2.00.0912061144100.3560@localhost.localdomain> <20091206121803.70385c33@infradead.org>
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:58706 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934338AbZLFWy6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2009 17:54:58 -0500
In-Reply-To: <20091206121803.70385c33@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>

On Dec 6, 2009, at 12:18 PM, Arjan van de Ven <arjan@infradead.org>  
wrote:

> On Sun, 6 Dec 2009 11:58:44 -0800 (PST)
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>>
>>
>> On Sun, 6 Dec 2009, Arjan van de Ven wrote:
>>>
>>> in suspend, there's a PCI device (:1b) that does take some time,
>>> which is the audio controller. The bulk of the time is in the serio
>>> driver though..
>>
>> That serio thing is disgusting. We had serious problems with the
>> serial driver timeouts for boot-time optimizations too, didn't we?
>
> isn't serio the PS/2 stuff?

Yes, that's your PS/2 mouse (rather touchpad) and the delay comes from  
device reset (needed by some keyboard controllers - I remember HP -or  
it and keyboard will be dead at resume).

-- 
Dmitry

