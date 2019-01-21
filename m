From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [for next][PATCH 1/2] platform/x86: Fix unmet dependency warning
 for ACPI_CMPC
Date: Mon, 21 Jan 2019 17:48:31 -0500
Message-ID: <23b1526a-b664-c4e3-2075-dd9cebe8c28c@kernel.org>
References: <20190121224644.26903-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121224644.26903-1-okaya@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 1/21/2019 5:46 PM, Sinan Kaya wrote:
> ACPI_CMPC selects BACKLIGHT_LCD_SUPPORT but BACKLIGHT_LCD_SUPPORT
> depends on BACKLIGHT_LCD_SUPPORT.

This should have been:

ACPI_CMPC selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
depends on BACKLIGHT_LCD_SUPPORT.
