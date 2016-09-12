From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2 0/3] serial: dw8250: ACPI tuning
Date: Tue, 13 Sep 2016 00:11:48 +0200
Message-ID: <2065510.Ra7hIhvnf9@vostro.rjw.lan>
References: <1471941208-27963-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42064 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755824AbcILWFm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Sep 2016 18:05:42 -0400
In-Reply-To: <1471941208-27963-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, August 23, 2016 11:33:25 AM Heikki Krogerus wrote:
> Hi,
> 
> Since we now have the build-in properties available, using those when
> ever possible to get the details the driver expects and when they are
> not being provided by the fw. Right now there is only one exception
> ACPI enumerated board where we have no means to provide the properties
> with build-in ones, so simply handling that as an exception in
> dw8250_quirks().
> 
> Changes since v1:
> - Fix a compiler error in acpi_apd.c found by kbuild test robot
> - ACK from Mika
> 
> 
> Heikki Krogerus (3):
>   ACPI / APD: Provide build-in properties of the UART
>   ACPI / LPSS: Provide build-in properties of the UART
>   serial: 8250_dw: Add quirk for APM X-Gene SoC

Whole series applied.

Thanks,
Rafael

