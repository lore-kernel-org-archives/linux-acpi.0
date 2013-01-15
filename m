From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/5] remove some unnecessary newline from error messages
Date: Tue, 15 Jan 2013 23:27:03 +0100
Message-ID: <1410204.blb3EQMqHJ@vostro.rjw.lan>
References: <1354189996-14431-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354189996-14431-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, November 29, 2012 11:53:11 AM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The ACPI_EXCEPTION and ACPI_ERROR macros already emit a newline after
> the message, so remove the unnecessary newlines from a bunch of messages.
> 
> Colin Ian King (5):
>   ACPI dock: remove unnecessary newline from exception message
>   ACPI video: remove unnecessary newline from error messages
>   ACPI sysfs: remove unnecessary newline from exception
>   ACPICA: GPE support: remove unnecessary newline from error messages
>   ACPI thermal: remove unnecessary newline from exception message
> 
>  drivers/acpi/acpica/hwgpe.c | 2 +-
>  drivers/acpi/dock.c         | 2 +-
>  drivers/acpi/sysfs.c        | 2 +-
>  drivers/acpi/thermal.c      | 2 +-
>  drivers/acpi/video.c        | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)

I don't seem to have received patch [1/5] (dock).

Patches [2-3/5] and [5/5] have been taken into linux-pm/linux-next for v3.9,
but [4/5] needs to go through ACPICA upstream.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
