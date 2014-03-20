From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Reorder maintainer addresses for PM and
 ACPI
Date: Wed, 19 Mar 2014 19:21:45 -0700
Message-ID: <1395282105.8649.55.camel@joe-AO722>
References: <1744772.yf52reTAmC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1744772.yf52reTAmC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2014-03-20 at 00:00 +0100, Rafael J. Wysocki wrote:

> Reorder PM and ACPI maintainer addresses in MAINTAINERS to make
> the probability of that a bit smaller.

>  FREEZER
> +M:	Rafael J. Wysocki <rjw@rjwysocki.net>
> -M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
[]
>  HIBERNATION (aka Software Suspend, aka swsusp)
> +M:	Rafael J. Wysocki <rjw@rjwysocki.net>
> -M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
[]
>  SUSPEND TO RAM
> +M:	Rafael J. Wysocki <rjw@rjwysocki.net>
> -M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>

Please keep the quotes around your name.

It makes it easier for some systems to accept
names with periods via copy/paste.


