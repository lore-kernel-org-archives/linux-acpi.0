From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: 2.6.17-mm6: BUG: spinlock wrong CPU on CPU#1,
 kacpid_notify/7105
Date: Tue, 11 Jul 2006 12:26:07 -0700
Message-ID: <20060711122607.a290f3e6.kristen.c.accardi@intel.com>
References: <44B08F3F.1080704@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:983 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751192AbWGKT0L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Jul 2006 15:26:11 -0400
In-Reply-To: <44B08F3F.1080704@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 08 Jul 2006 22:08:15 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> [ Repost: got linux-acpi's address wrong. ]
> 
> I just got this while undocking my machine.  Thinkpad X60, Core Duo CPU.
>

Hi Jeremy,
I think the patch I posted on Friday will solve this issue:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115230920629981&w=2

It is included in 2.6.18-rc1-mm1.

Let me know if this works for you.

Kristen
