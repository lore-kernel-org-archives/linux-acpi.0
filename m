From: Dmitry Nezhevenko <dion@inhex.net>
Subject: Re: Strange ACPI errors sometimes after resume from s2disk
Date: Wed, 22 Oct 2008 10:41:49 +0300
Message-ID: <20081022074149.GA6066@laptop.local>
References: <20081021220034.GA18248@laptop.local> <200810220044.01259.rjw@sisk.pl> <48FED672.4060008@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752772AbYJVHm0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <48FED672.4060008@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 22, 2008 at 11:29:54AM +0400, Alexey Starikovskiy wrote:
> Please try changing msleep(1) to udelay(50) in drivers/acpi/ec.c

Ok. Will try this. However as I said issue is not easy to reproduce.. So
I'll just change it and wait a bit.

> have msi-laptop module loaded?

No. I don't use it.

> Please fill a bugreport and attach all the information there.

Ok. Will do this soon
 
-- 
WBR, Dmitry
