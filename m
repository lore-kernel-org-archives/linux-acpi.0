From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] device property: export irqchip_fwnode_ops
Date: Wed, 26 Jul 2017 02:13:25 +0200
Message-ID: <2233361.D5jIfdWk16@aspire.rjw.lan>
References: <20170725153243.101147-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725153243.101147-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>, Will Deacon <will.deacon@arm.com>, Eric Auger <eric.auger@redhat.com>, Sebastian Frias <sf84@laposte.net>, linux-kernel@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, July 25, 2017 05:32:31 PM Arnd Bergmann wrote:
> The newly added irqchip_fwnode_ops structure is not exported, which can
> lead to link errors:
> 
> ERROR: "irqchip_fwnode_ops" [drivers/gpio/gpio-xgene-sb.ko] undefined!
> 
> I checked that all other such symbols that were introduced are
> exported if they need to be, this is the only missing one.
> 
> Fixes: db3e50f3234b ("device property: Get rid of struct fwnode_handle type field")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix.

It is linux-next only at this point, isn't it?
