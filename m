From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] Re: [PATCH 2/2] Introduce CONFIG_SUSPEND (updated)
Date: Tue, 31 Jul 2007 11:16:39 +0200
Message-ID: <200707311116.39857.oliver@neukum.org>
References: <200707251238.50218.lenb@kernel.org> <200707310059.50329.lenb@kernel.org> <200707311115.29057.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753629AbXGaJOt@vger.kernel.org>
In-Reply-To: <200707311115.29057.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Am Dienstag 31 Juli 2007 schrieb Rafael J. Wysocki:

> Well, the people on linux-pm seem to agree that the .suspend() and .resume()
> callbacks are not suitable for runtime power management, so having them
> built without SUSPEND or HIBERNATION wouldn't be very useful. ;-)

These are what USB runtime power management uses. How many code
paths for power management do you want to introduce?

	Regards
		Oliver
