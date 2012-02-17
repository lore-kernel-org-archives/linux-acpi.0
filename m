From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] ACPI: Provide config option to disable BIOS
 brightness changes on power events
Date: Fri, 17 Feb 2012 20:27:04 +0100
Message-ID: <20120217192704.GB2707@elf.ucw.cz>
References: <1328282293-16551-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1328282293-16551-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> The default ACPI behaviour is to instruct the BIOS to automatically change
> brightness on power events. This may be undesirable for distributions who
> manage brightness in userspace. Provide a config option that disables this
> behaviour and leaves brightness control up to the OS.

Should this be configured during runtime?

Like... when userspace power management starts, it disables this?
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
