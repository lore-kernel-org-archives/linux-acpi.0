From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/device_sysfs: Add sysfs support for _HRV hardware revision
Date: Tue, 26 Apr 2016 22:35:58 +0200
Message-ID: <3691881.pb3S7Il1cr@vostro.rjw.lan>
References: <1460558894-11971-1-git-send-email-betty.dall@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460558894-11971-1-git-send-email-betty.dall@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Betty Dall <betty.dall@hpe.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, April 13, 2016 08:48:14 AM Betty Dall wrote:
> The ACPI _HRV object on the device is used to supply Linux with
> the device's hardware revision. This is an optional object. Add
> sysfs support for the _HRV object if it exists on the device.
> 
> Signed-off-by: Betty Dall <betty.dall@hpe.com>

The patch itself looks OK to me, but why exactly do we need that thing in sysfs?

Thanks,
Rafael
