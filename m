From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] hwmon: Enhance the sysfs API for power meters.
Date: Fri, 7 Aug 2009 20:09:06 +0200
Message-ID: <20090807180906.GD1728@ucw.cz>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com> <20090725004328.20709.57712.stgit@elm3a70.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752140AbZHHPZh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090725004328.20709.57712.stgit@elm3a70.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org


> @@ -365,6 +373,16 @@ power[1-*]_average_lowest	Historical average minimum power use
>  				Unit: microWatt
>  				RO
>  
> +power[1-*]_average_max		A notification is sent when power use
> +				rises above this value.
> +				Unit: microWatt
> +				RW
> +

How is the notification sent?

> +power[1-*]_average_min		A notification is sent when power use
> +				sinks below this value.
> +				Unit: microWatt
> +				RW

And what is this good for? Will it wake from sleep? Will it wake from
C3?

...seems like good way to prevent deep sleep states.

> +power[1-*]_cap			If power use rises above this limit, the
> +				system should take action to reduce
> power use.

System as in 'hw'? Or who? And how?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
