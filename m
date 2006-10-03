From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [patch 2/2]: acpi: add removable drive bay support
Date: Wed, 4 Oct 2006 01:49:41 +0200
Message-ID: <41840b750610031649n5db15a0bq4834420b51974562@mail.gmail.com>
References: <20060907161319.5495fc65.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:21259 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751035AbWJCXtm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Oct 2006 19:49:42 -0400
Received: by ug-out-1314.google.com with SMTP id o38so710594ugd
        for <linux-acpi@vger.kernel.org>; Tue, 03 Oct 2006 16:49:41 -0700 (PDT)
In-Reply-To: <20060907161319.5495fc65.kristen.c.accardi@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com

Hi Kristen,

On 9/8/06, Kristen Carlson Accardi <kristen.c.accardi@intel.com> wrote:

> +static void bay_notify(acpi_handle handle, u32 event, void *data)
[...]
> +       case ACPI_NOTIFY_EJECT_REQUEST:
[...]
> +               /* wouldn't it be a good idea to just call the
> +                * eject_device here if we were a SATA device?
> +                */

No, bay eject should go through userspace so that it gets a chance to
do cleanup (e.g., unmount filesystems) or to tell the user to abort
the eject (e.g., filesystems in use, or system running on bay battery
power).

And the driver of whatever is in the bay should be informed before
power is removed so it can do its own cleanup (e.g., spin down disk).
This can also be done by userspace.

So your current code is fine, and the comment should probably be
removed lest someone tries to follow it.

  Shem
