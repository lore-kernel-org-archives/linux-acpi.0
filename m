From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA Version 20120620 linuxized patches.
Date: Sat, 14 Jul 2012 11:27:33 -0400
Message-ID: <50018FE5.1080004@kernel.org>
References: <1340948997.3328.181.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:56517 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab2GNP1h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jul 2012 11:27:37 -0400
Received: by qadb17 with SMTP id b17so879959qad.19
        for <linux-acpi@vger.kernel.org>; Sat, 14 Jul 2012 08:27:36 -0700 (PDT)
In-Reply-To: <1340948997.3328.181.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

The sign-off's below are not quite right.

Please see section Documentation/SubmittingPatches
section 12/13/14

A series of Signed-off by's means the patch passed though
that sequence of people.  If if they simply Acked it,
then it should be Acked-by, or Reviewed-by, Tested-by,
Reported-by etc.

-Len


---
    ACPICA: Add support for implicit notify on multiple devices

    Adds basic support to allow multiple devices to be implicitly
    notified.

    This change is partially derived from original commit 981858b("ACPI /
    ACPICA: Implicit notify for multiple devices") by Rafael.

    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Jung-uk Kim <jkim@freebsd.org>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
