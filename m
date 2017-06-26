From: Lukas Wunner <lukas@wunner.de>
Subject: Re: ACPICA regression for empty ResourceTemplates
Date: Mon, 26 Jun 2017 14:38:53 +0200
Message-ID: <20170626123853.GA14363@wunner.de>
References: <20170626083815.zxlohrjz64delbae@wunner.de>
 <CAJZ5v0gsNAooprhJ4thgd184hB+gCeU_mo=fC=16TncAfAPqbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:34549 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbdFZMiz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jun 2017 08:38:55 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gsNAooprhJ4thgd184hB+gCeU_mo=fC=16TncAfAPqbw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ronald Tschalaer <ronald@innovation.ch>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Jun 26, 2017 at 01:49:03PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 26, 2017 at 10:38 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > Hi Robert,
> >
> > ACPICA commit c8eac101 (= Linux commit a83019eb9f1f, "ACPICA: Update
> > resource descriptor handling") is causing a regression when parsing
> > an empty ResourceTemplate:
> 
> This is a linux-next commit, right?

Yes.

Lukas
