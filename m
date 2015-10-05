From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] ACPI / EC: Fix several code coverity issues
Date: Mon, 05 Oct 2015 22:38:23 +0200
Message-ID: <2638627.7resjTWJsq@vostro.rjw.lan>
References: <cover.1443076693.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443076693.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, September 24, 2015 02:54:26 PM Lv Zheng wrote:
> This patch fixes several code coverity issues in the EC driver.
> One serious issue that can cause memory leak is marked as stable material.
> 
> Lv Zheng (3):
>   ACPI / EC: Fix a memory leak issue in acpi_ec_query()
>   ACPI / EC: Fix query handler related issues
>   ACPI / EC: Fix a race issue in acpi_ec_guard_event()
> 
>  drivers/acpi/ec.c |  113 +++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 74 insertions(+), 39 deletions(-)

Series applied, thanks!

Rafael
