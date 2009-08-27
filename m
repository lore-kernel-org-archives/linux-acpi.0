From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/6] PM: Allow serio input devices to suspend/resume
	asynchronously
Date: Thu, 27 Aug 2009 13:08:53 -0700
Message-ID: <20090827204106.1132B526EC9@mailhub.coreip.homeip.net>
References: <200908262217.19609.rjw@sisk.pl> <200908262224.19110.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752532AbZH0UJA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200908262224.19110.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 26, 2009 at 10:24:19PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Set async_suspend for all serio input devices, so that they can be
> suspended and resumed asynchronously with other devices they don't
> depend on in a known way (i.e. devices which are not their parents
> or children and to which they are not connected via struct pm_link
> objects).
> 

As I mentioned not yet, please - i8042 may be unhappy if you pound
all its ports at once. I should have a solution for it though.

-- 
Dmitry
