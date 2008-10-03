From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] Hibernation: Introduce new system state for the
 last phase of hibernation
Date: Fri, 3 Oct 2008 05:43:55 -0700
Message-ID: <20081003054355.e3a3ac79.akpm@linux-foundation.org>
References: <200808290002.55026.rjw@sisk.pl>
	<200809300010.39000.rjw@sisk.pl>
	<20081003013557.42ce685d.akpm@linux-foundation.org>
	<200810031327.19293.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40510 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751474AbYJCMoM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Oct 2008 08:44:12 -0400
In-Reply-To: <200810031327.19293.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>

On Fri, 3 Oct 2008 13:27:18 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > Can we just create a new global?
> > 
> > 	extern bool system_entering_hibernation_or_whatever;
> 
> Yes, we can, but what about:
> 
> extern bool system_entering_hibernation(void);
> 
> that will become a static inline in case of !CONFIG_HIBERNATION,
> and using a static variable?

Sure, even better.
