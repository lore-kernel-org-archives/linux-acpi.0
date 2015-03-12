From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] ACPI / EC: Enhance logging/debugging.
Date: Thu, 12 Mar 2015 23:42:32 +0100
Message-ID: <30354528.S7QEWNWyT3@vostro.rjw.lan>
References: <alpine.LNX.2.11.1502151932250.630@localhost> <cover.1425019470.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1425019470.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, February 27, 2015 02:48:07 PM Lv Zheng wrote:
> This patchset enhances logging/debugging support in EC driver.
> 
> Lv Zheng (2):
>   ACPI / EC: Cleanup logging/debugging splitter support.
>   ACPI / EC: Add GPE reference counting debugging messages.
> 
>  drivers/acpi/ec.c |  120 +++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 84 insertions(+), 36 deletions(-)

Queued up for 4.1, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
