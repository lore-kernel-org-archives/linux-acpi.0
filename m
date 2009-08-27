From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 8] PM: Allow user space to change the
	power.async_suspend flag of devices
Date: Thu, 27 Aug 2009 13:04:20 -0700
Message-ID: <20090827203634.372EC526EC9@mailhub.coreip.homeip.net>
References: <200908262217.19609.rjw@sisk.pl> <200908270025.34821.rjw@sisk.pl> <200908272117.52931.rjw@sisk.pl> <200908272120.56021.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752415AbZH0UE1@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200908272120.56021.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On Thu, Aug 27, 2009 at 09:20:55PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Add sysfs attribute power/async for every device allowing the user
> space to access the device's power.async_suspend flag and modify it,
> if necessary.
> 

I don't think we should let users meddle with individual devices;
one global flag should be enough to work around "broken-at-the-moment"
issues.

-- 
Dmitry
