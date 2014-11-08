From: Alexander Monakov <amonakov@gmail.com>
Subject: Re: [PATCH] ACPI/osl: speedup grace period in acpi_os_map_cleanup
Date: Sun, 9 Nov 2014 03:24:34 +0400
Message-ID: <CABtfrpDryV5XEzBOttTuGZ7Tvyy4QUo1pajvO07=6tpozjVLzQ@mail.gmail.com>
References: <20141108094717.9388.34638.stgit@zurg>
	<20141108221347.GF4901@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:59667 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbaKHXYe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2014 18:24:34 -0500
In-Reply-To: <20141108221347.GF4901@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Konstantin Khlebnikov <koct9i@gmail.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Tom Boshoven <tomboshoven@gmail.com>, x86@kernel.org, Josh Triplett <josh@joshtriplett.org>

On Sun, Nov 9, 2014 at 1:13 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> Did anyone try replacing the synchronize_rcu() with
> synchronize_rcu_expedited()?  That should provide substantial speedups
> over synchronize_rcu().

I've just briefly tested it on my laptop, and it also helps to avoid the issue.

Alexander
