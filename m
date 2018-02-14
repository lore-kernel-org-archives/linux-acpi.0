From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/2] acpi: document sysfs interfaces
Date: Wed, 14 Feb 2018 10:27:24 +0100
Message-ID: <2867905.gflgnk5biQ@aspire.rjw.lan>
References: <cover.1518252138.git.aishpant@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:60714 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966446AbeBNJ3N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Feb 2018 04:29:13 -0500
In-Reply-To: <cover.1518252138.git.aishpant@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>

On Saturday, February 10, 2018 9:55:53 AM CET Aishwarya Pant wrote:
> Patchset contains documentation for two acpi drivers- dock and dptf. Description
> was collected from git history and reading through code. This might be useful
> for tracking changes in the ABI.
> 
> Changes in v2:
> - Split up multiple attribute definitions
> 
> Aishwarya Pant (2):
>   acpi/dptf: document sysfs atttributes
>   acpi/dock: document sysfs interface
> 
>  .../ABI/testing/sysfs-devices-platform-dock        | 39 +++++++++++++++++++++
>  Documentation/ABI/testing/sysfs-platform-dptf      | 40 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf

Both patches applied with minor modifications, thanks!

