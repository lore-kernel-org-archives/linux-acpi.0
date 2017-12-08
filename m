From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V7 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Date: Fri, 8 Dec 2017 14:48:49 +0100
Message-ID: <CAJZ5v0g8v3mwCZOCXHsy_0iA+0RzFFhBxfo4f_cEv5QVLEccsA@mail.gmail.com>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43673 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753776AbdLHNsu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2017 08:48:50 -0500
In-Reply-To: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 7, 2017 at 10:10 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Introduce new ACPI and OF device ids for thw HW along with the helper
> functions.
>
> Changes from v6:
> * add const to the device callback parameter in fwnode.
> * reorganize the callbacks in the code
> * rename get_match_data() as device_get_match_data()
> * place pointer checks into acpi_get_match_data()
>
> Sinan Kaya (7):
>   Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
>   ACPI / bus: Introduce acpi_get_match_data() function
>   device property: Introduce a common API to fetch device match data
>   OF: properties: Implement get_match_data() callback
>   ACPI: properties: Implement get_match_data() callback
>   dmaengine: qcom_hidma: Add support for the new revision
>   dmaengine: qcom_hidma: Add identity register support
>
>  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  4 +--
>  drivers/acpi/bus.c                                 | 18 ++++++++++
>  drivers/acpi/property.c                            |  8 +++++
>  drivers/base/property.c                            |  7 ++++
>  drivers/dma/qcom/hidma.c                           | 41 ++++++++++------------
>  drivers/of/property.c                              |  8 +++++
>  include/linux/acpi.h                               |  6 ++++
>  include/linux/fwnode.h                             |  4 +++
>  include/linux/property.h                           |  2 ++
>  9 files changed, 74 insertions(+), 24 deletions(-)
>
> --

The series is fine by me, by how do you want to route it?

Thanks,
Rafael
