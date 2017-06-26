From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPICA regression for empty ResourceTemplates
Date: Mon, 26 Jun 2017 13:49:03 +0200
Message-ID: <CAJZ5v0gsNAooprhJ4thgd184hB+gCeU_mo=fC=16TncAfAPqbw@mail.gmail.com>
References: <20170626083815.zxlohrjz64delbae@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35170 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdFZLtF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jun 2017 07:49:05 -0400
Received: by mail-io0-f177.google.com with SMTP id h134so61137593iof.2
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jun 2017 04:49:04 -0700 (PDT)
In-Reply-To: <20170626083815.zxlohrjz64delbae@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ronald Tschalaer <ronald@innovation.ch>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Jun 26, 2017 at 10:38 AM, Lukas Wunner <lukas@wunner.de> wrote:
> Hi Robert,
>
> ACPICA commit c8eac101 (= Linux commit a83019eb9f1f, "ACPICA: Update
> resource descriptor handling") is causing a regression when parsing
> an empty ResourceTemplate:

This is a linux-next commit, right?

Thanks,
Rafael
