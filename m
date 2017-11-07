From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / PM: fix build regression
Date: Tue, 7 Nov 2017 12:17:01 +0100
Message-ID: <CAJZ5v0hY-5Hko3YiW_-kg9Mgaf0qFn+fMUdYyip8ax0ADB6DTA@mail.gmail.com>
References: <20171107104913.3303452-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171107104913.3303452-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, Stable <stable@vger.kernel.org>, Jean Delvare <jdelvare@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 7, 2017 at 11:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The XPS13 workaround caused a build regression in configurations without
> CONFIG_ACPI_SLEEP.
>
> drivers/acpi/sleep.c:95:5: error: redefinition of 'acpi_target_system_state'
>  u32 acpi_target_system_state(void)
>      ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/acpi.h:44:0,
>                  from drivers/acpi/sleep.c:20:
> include/acpi/acpi_bus.h:661:19: note: previous definition of 'acpi_target_system_state' was here
>  static inline u32 acpi_target_system_state(void) { return ACPI_STATE_S0; }
>                    ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/sleep.c:495:13: error: 'acpi_pm_end' defined but not used [-Werror=unused-function]
>
> This adds back the #ifdef checks required to make it build cleanly again.
> The patch that caused the regression is marked for backports to v4.13, the
> same should apply to this one.
>
> Fixes: 8d7a4756fef9 ("ACPI / PM: Blacklist Low Power S0 Idle _DSM for Dell XPS13 9360")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This should have been fixed in my tree already.

Unfortunately, linux-next picked up an earlier version with this issue.

Thanks,
Rafael
