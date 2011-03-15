From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] v2 merge 32 and 64 realmode wakeup code
Date: Tue, 15 Mar 2011 23:37:53 +0100
Message-ID: <20110315223753.GA1700@atrey.karlin.mff.cuni.cz>
References: <4D7FE5C5.3040106@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D7FE5C5.3040106@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: x86@kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-acpi@vger.kernel.org

> - this mean less ifdef in code
> - we could remove now unused field in wakeup_header (pmode_*)
>
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
