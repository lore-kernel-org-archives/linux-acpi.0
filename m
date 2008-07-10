From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 6/8] Schedule sysrq poweroff on boot cpu
Date: Thu, 10 Jul 2008 13:36:44 +0200
Message-ID: <20080710113643.GF15412@elf.ucw.cz>
References: <200807100152.17755.rjw@sisk.pl> <200807100204.25010.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758867AbYGJPFk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200807100204.25010.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Rus <harbour@sfinx.od.ua>
List-Id: linux-acpi@vger.kernel.org

On Thu 2008-07-10 02:04:24, Rafael J. Wysocki wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> Subject: Schedule sysrq poweroff on boot cpu
> 
> schedule sysrq poweroff on boot cpu.
> 
> sysrq poweroff needs to disable nonboot cpus, and we need to run this
> on boot cpu to avoid any recursion.
> http://bugzilla.kernel.org/show_bug.cgi?id=10897
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> tested-by: Rus <harbour@sfinx.od.ua>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
