From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 4/5] ACPI 2.0 / AML: Improve module level execution by
 moving the If/Else/While execution to per-table basis
Date: Thu, 24 Nov 2016 22:16:39 +0100
Message-ID: <CAJZ5v0jwydmsBDyWSVxAhzqNcPyjoCMPRrbYjNQJdhSu-g5nPw@mail.gmail.com>
References: <cover.1474600034.git.lv.zheng@intel.com> <d64177f75f03dc05b0fe63cbb84ff352e15d4f11.1474600034.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wj0-f177.google.com ([209.85.210.177]:35535 "EHLO
        mail-wj0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941269AbcKXVQl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Nov 2016 16:16:41 -0500
In-Reply-To: <d64177f75f03dc05b0fe63cbb84ff352e15d4f11.1474600034.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Sep 23, 2016 at 5:26 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> This reverts commit 00c611def8748a0a1cf1d31842e49b42dfdb3de1.

It would be good to say why it is now OK to revert it.

Thanks,
Rafael
