From: Ognjen Galic <smclt30p@gmail.com>
Subject: Re: thinkpad E555, fan module not loaded
Date: Wed, 20 Dec 2017 20:14:55 +0100
Message-ID: <20171220191455.GA5734@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:44790 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755902AbdLTTO7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2017 14:14:59 -0500
Received: by mail-wr0-f179.google.com with SMTP id l41so11004084wre.11
        for <linux-acpi@vger.kernel.org>; Wed, 20 Dec 2017 11:14:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gibboris@gmail.com, linux-acpi@vger.kernel.org

> Hi,

> I post here as a last ressort as advised at the end of this thread
> https://www.spinics.net/lists/ibm-acpi-devel/msg04173.html
> 
> I own a Thinkpad E555/Kaveri which is overheating.
> I noticed fan stopped working soon after a 4.9 => 4.12 (Debian Jessie =>
> Stretch) upgrade.
> BIOS is up to date, kernel is 4.12.
> fan runs during BIOS & GRUB stages (or if booting acpi=off)
> The main symptom seems to be that the "fan" module is not loaded.
> I already provided information and a couple of ACPI tables in the above
> thread.
>
> What more may I provide in order to efficiently help getting this
> spotted & solved?

Thanks for contacting us!

That could be caused by two modules, either thinkpad_acpi or fan.

First, build a kernel with both modules not built at all and install
the kernel. The fan should work just fine as both fan and thinkpad_acpi
are not loaded. Then, build the battery and thinkpad_acpi modules and 
load one by one, and see which one causes the issue and report back.

Thanks,
Ognjen
