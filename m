From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 1/3] ACPI: move ACPI_SYSTEM_HID to acpi_drivers.h
Date: Thu, 17 Mar 2016 10:53:31 -0600
Message-ID: <56EAE10B.8070404@codeaurora.org>
References: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
 <1458157022-18633-2-git-send-email-pprakash@codeaurora.org>
 <CAJZ5v0jewRqgvi7Ei939ddafnNJEQw+cv2cjGWrFNK2pZ0-2rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49761 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031260AbcCQQxf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2016 12:53:35 -0400
In-Reply-To: <CAJZ5v0jewRqgvi7Ei939ddafnNJEQw+cv2cjGWrFNK2pZ0-2rQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, harba@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

Hi Rafael,

On 3/16/2016 7:50 PM, Rafael J. Wysocki wrote:
>  #include "internal.h"
> @@ -22,7 +24,6 @@ ACPI_MODULE_NAME("scan");
>  extern struct acpi_device *acpi_root;
>
>  #define ACPI_BUS_CLASS                 "system_bus"
> -#define ACPI_BUS_HID                   "LNXSYBUS"
> No.
>
> This is not a valid device ID and should never be used as such.
Section 5.6.6 in ACPI 6.1 is defining the notification value for the graceful
shutdown request as a ACPI device specific value(0x81) and it is targeting
the system bus(\_SB), so we took the current approach of creating a sybus
driver to handle the notifications targeting the system bus.

Let me go through the code again and see if we can avoid using the
ACPI_BUS_HID. In the meantime, if you have any specific thoughts on
how this should be handled, please let us know.

Thanks,
Prashanth

