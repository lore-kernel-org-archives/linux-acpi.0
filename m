From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/9] PM: Add a switch for disabling/enabling asynchronous suspend/resume
Date: Thu, 10 Sep 2009 20:56:39 +0200
Message-ID: <200909102056.39903.rjw@sisk.pl>
References: <200909100127.11252.rjw@sisk.pl> <200909100138.25839.rjw@sisk.pl> <20090910102653.GA30778@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753361AbZIJSzm@vger.kernel.org>
In-Reply-To: <20090910102653.GA30778@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

On Thursday 10 September 2009, Pavel Machek wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Add sysfs attribute kernel/power/pm_async allowing the user space to
> > disable and enable async suspend/resume of devices.
> 
> for bisect reasons, should this go before 5?

It is set to "enabled" by default, so it shouldn't change bisection results.

Thanks,
Rafael
