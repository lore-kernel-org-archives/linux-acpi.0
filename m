From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH] ACPI / sysfs: fix shift-overflow in GPE flooding quirk
 mechanism
Date: Tue, 2 Jan 2018 19:11:48 +0800
Message-ID: <20180102111148.r2r322yjtmwqfrhd@intel.com>
References: <1513955470-27270-1-git-send-email-changbin.du@intel.com>
 <20180102063651.3p2bwr467w43twbu@intel.com>
 <CAJZ5v0hcMMd+V4eD76mZt4=qobAzbzviOvDuLmC7KRnw8emdPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:26174 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbeABLT6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Jan 2018 06:19:58 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hcMMd+V4eD76mZt4=qobAzbzviOvDuLmC7KRnw8emdPg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Du, Changbin" <changbin.du@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Jan 02, 2018 at 11:18:31AM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 2, 2018 at 7:36 AM, Du, Changbin <changbin.du@intel.com> wrote:
> > Hi Wysocki and Brown,
> > May I know wether you have checked this? Thanks!
> 
> There's a commit changing this queued up already, see
> https://patchwork.kernel.org/patch/10085579/
> 
Got it, Thanks for your reply.

> Thanks!

-- 
Thanks,
Changbin Du
