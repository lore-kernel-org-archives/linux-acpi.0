From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 03/15] ACPI: Allow drivers to match using Device Tree compatible property
Date: Wed, 01 Oct 2014 09:48 +0200
Message-ID: <1977503.88D87WA4bh@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <1852462.V1jlbi8OPt@vostro.rjw.lan> <3582127.hCPY12ZqpT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3582127.hCPY12ZqpT@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 01 October 2014 04:10:40 Rafael J. Wysocki wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> We have lots of existing Device Tree enabled drivers and allocating
> separate _HID for each is not feasible. Instead we allocate special _HID
> "PRP0001" that means that the match should be done using Device Tree
> compatible property using driver's .of_match_table instead.
> 
> If there is a need to distinguish from where the device is enumerated
> (DT/ACPI) driver can check dev->of_node or ACPI_COMPATION(dev).
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
