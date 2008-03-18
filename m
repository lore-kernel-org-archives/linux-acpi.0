From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 3/3] PM: New suspend and hibernation callbacks for
	PCI bus type
Date: Tue, 18 Mar 2008 11:02:56 +0100
Message-ID: <20080318100256.GC10830@elf.ucw.cz>
References: <200803170020.55473.rjw@sisk.pl> <200803170025.16149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753875AbYCRLru@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200803170025.16149.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>
List-Id: linux-acpi@vger.kernel.org

On Mon 2008-03-17 00:25:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Implement new suspend and hibernation callbacks for the PCI busi type.

"bus", I guess.

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

> ---
>  drivers/pci/pci-driver.c |  497 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/pci.h      |    2 
>  2 files changed, 453 insertions(+), 46 deletions(-)

...but big, too :-(.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
