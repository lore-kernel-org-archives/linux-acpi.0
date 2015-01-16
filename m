From: Jon Masters <jcm@redhat.com>
Subject: Re: SPCR table parsing
Date: Thu, 15 Jan 2015 22:18:26 -0500
Message-ID: <54B88302.2070903@redhat.com>
References: <54B880B5.6010907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35670 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470AbbAPDSu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Jan 2015 22:18:50 -0500
In-Reply-To: <54B880B5.6010907@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 01/15/2015 10:08 PM, Jon Masters wrote:

> We're implementing support for SPCR table parsing shortly[0], since it
> will allow to deprecate supplying a "console=" (and eventually, also
> "earlycon=") on 64-bit ARM servers, where it's not always the case that
> we can assume a 16550 at a specific address. SPCR has been provided on
> x86 systems since 2000 but is not (yet) supported by Linux.
> 
> If anyone knows of existing efforts on e.g. x86 or IA64, please get in
> touch. I expect the initial implementation to require revision 2+ modern
> server systems and possibly be limited to ARM initially.

Side note: I preemptively had this added to the SBBR so it's already
required on ARM servers, and have confirmed the reference systems out
there have valid tables for us to use ahead of time.

Jon.

