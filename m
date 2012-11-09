From: David Rientjes <rientjes@google.com>
Subject: Re: mmotm 2012-11-08-15-17 uploaded  (acpi)
Date: Fri, 9 Nov 2012 13:45:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211091345080.2974@chino.kir.corp.google.com>
References: <20121108231753.E6B7A100047@wpzn3.hot.corp.google.com> <509D862C.2060408@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <509D862C.2060408@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 9 Nov 2012, Randy Dunlap wrote:

> on x86_64:
> 
> drivers/built-in.o: In function `acpi_pm_device_sleep_state':
> (.text+0x21855): undefined reference to `acpi_target_system_state'
> drivers/built-in.o: In function `acpi_pm_device_sleep_wake':
> (.text+0x2198e): undefined reference to `acpi_target_system_state'
> drivers/built-in.o: In function `acpi_dev_suspend_late':
> (.text+0x21add): undefined reference to `acpi_target_system_state'
> 

Sent a fix for this yesterday: 
http://marc.info/?l=linux-kernel&m=13524024192708
