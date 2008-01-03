From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 3/7] ACPI: Separate disabling of GPEs from _PTS
Date: Thu, 3 Jan 2008 11:43:46 +0100
Message-ID: <20080103104345.GB1732@elf.ucw.cz>
References: <200712271903.53961.rjw@sisk.pl> <200712271916.28675.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757201AbYACKnv@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200712271916.28675.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The preparation to enter an ACPI system sleep state is now tied to
> the disabling of GPEs, but the GPEs should not be disabled before
> suspending devices.  Since on ACPI 1.0x systems the _PTS global
> control method should be executed before suspending devices, we
> need to disable GPEs separately.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks ok to me... as does rest of the series.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
