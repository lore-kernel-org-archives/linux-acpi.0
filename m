From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/3] ACPI: Support for platform initiated graceful
 shutdown
Date: Tue, 10 May 2016 16:50:27 -0600
Message-ID: <21470c3b-c176-ef46-fc93-081d482b4cab@redhat.com>
References: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35113 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbcEJWua (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 May 2016 18:50:30 -0400
Received: by mail-ig0-f179.google.com with SMTP id bi2so144505708igb.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 May 2016 15:50:30 -0700 (PDT)
In-Reply-To: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org
Cc: harba@codeaurora.org, rjw@rjwysocki.net

On 03/16/2016 01:36 PM, Prashanth Prakash wrote:
> This patch-set adds support for platform initited graceful shutdown as
> described in the sections 5.6.6(Table-143) and 6.3.5.1 of ACPI 6.1 spec
> 
> Jonathan (Zhixiong) Zhang (1):
>   ACPI: move ACPI_SYSTEM_HID to acpi_drivers.h
> 
> Prashanth Prakash (2):
>   ACPI / sybus: add a driver for LNXSYBUS device
>   ACPI: update the definition of common notification values
> 
>  drivers/acpi/Kconfig        |   6 +++
>  drivers/acpi/Makefile       |   1 +
>  drivers/acpi/scan.c         |   3 +-
>  drivers/acpi/sybus.c        | 116 ++++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_drivers.h |   1 +
>  include/acpi/actypes.h      |   2 +-
>  6 files changed, 127 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/acpi/sybus.c
> 

Is v2 coming along soon?  I'd like to try these out on a couple of
systems.  Thanks, Prashanth.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
