From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/3] ACPI/device_sysfs: Add sysfs support for _HRV hardware revision
Date: Fri, 06 May 2016 01:42:47 +0200
Message-ID: <3868129.6UV0OJgmLN@vostro.rjw.lan>
References: <1462032219-12590-1-git-send-email-betty.dall@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49977 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754614AbcEEXjd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2016 19:39:33 -0400
In-Reply-To: <1462032219-12590-1-git-send-email-betty.dall@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Betty Dall <betty.dall@hpe.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, April 30, 2016 10:03:36 AM Betty Dall wrote:
> The ACPI _HRV object on the device is used to supply Linux with the
> device's hardware revision. This is an optional object. Add sysfs support
> for the _HRV object if it exists on the device.
> 
> This change allows users to easily find the hardware version of non-PCI
> hardware by looking at the sysfs 'hrv' file. It is most useful for
> non-PCI devices because lspci can list the hardware version for PCI
> devices.
> 
> v1->v2
> 	Changed hrv_show error return to -EIO.
> 	Changed sun_show and status_show error return to -EIO.
> 	Cleaned up checkpatch errors and warnings.
> 
> v2->v3
> 	Left some of the checkpatch warnings in place.
> 
> Betty Dall (3):
>   ACPI/device_sysfs: Add sysfs support for _HRV hardware revision    
>   ACPI/device_sysfs: Change _SUN and _STA show functions error return to EIO
>   ACPI/device_sysfs: Clean up checkpatch errors

All [1-3/3] applied, thanks!

