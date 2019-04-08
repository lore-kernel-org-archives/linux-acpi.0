Return-Path: <SRS0=s14x=SK=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DAAC10F13
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B241220863
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDHU4H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:56:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:65013 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfDHU4H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Apr 2019 16:56:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 13:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="159356541"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2019 13:56:06 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.68]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.52]) with mapi id 14.03.0415.000;
 Mon, 8 Apr 2019 13:56:06 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: RE: [PATCH 0/8] ACPICA release 20190329 and 20190405
Thread-Topic: [PATCH 0/8] ACPICA release 20190329 and 20190405
Thread-Index: AQHU7k0NxANkmGqo/UiEdx4TygF20KYyvdWA
Date:   Mon, 8 Apr 2019 20:56:05 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C5A003D@ORSMSX122.amr.corp.intel.com>
References: <20190408204230.4335-1-erik.schmauss@intel.com>
In-Reply-To: <20190408204230.4335-1-erik.schmauss@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sorry for the spam, everyone.
There's no difference between this patch-set and the one before.
However, this cover letter contains a link to a copy of the patch set in case the patches were not sent.

Thanks,
Erik

> -----Original Message-----
> From: Schmauss, Erik
> Sent: Monday, April 8, 2019 1:42 PM
> To: linux-acpi@vger.kernel.org; rjw@rjwysocki.net
> Cc: Schmauss, Erik <erik.schmauss@intel.com>
> Subject: [PATCH 0/8] ACPICA release 20190329 and 20190405
> 
> Since ACPICA had a release within one week of each other, this patch-
> set contains both releases. Notable items include a patch to remove a
> namespace node from the global address list correctly. Other than
> that, there are several renamings for clarity.
> 
> This patch-set is also available at the link below:
> https://github.com/SchmErik/linux/commits/acpica201904
> 
> Bob Moore (5):
>   ACPICA: Rename nameseg copy macro for clarity
>   ACPICA: Rename nameseg compare macro for clarity
>   ACPICA: Rename nameseg length macro/define for clarity
>   ACPICA: Update version to 20190329
>   ACPICA: Update version to 20190405
> 
> Erik Schmauss (3):
>   ACPICA: Namespace: remove address node from global list after
> method
>     termination
>   ACPICA: utilities: fix spelling of PCC to platform_comm_channel
>   ACPICA: Namespace: add check to avoid null pointer dereference
> 
>  arch/x86/boot/compressed/acpi.c               |  2 +-
>  drivers/acpi/acpica/aclocal.h                 |  4 +-
>  drivers/acpi/acpica/dbexec.c                  |  2 +-
>  drivers/acpi/acpica/dbnames.c                 |  2 +-
>  drivers/acpi/acpica/dsinit.c                  |  2 +-
>  drivers/acpi/acpica/evgpeinit.c               |  4 +-
>  drivers/acpi/acpica/exnames.c                 |  6 +--
>  drivers/acpi/acpica/nsaccess.c                |  2 +-
>  drivers/acpi/acpica/nsalloc.c                 |  4 ++
>  drivers/acpi/acpica/nsdump.c                  |  2 +-
>  drivers/acpi/acpica/nsinit.c                  |  4 +-
>  drivers/acpi/acpica/nsnames.c                 |  8 ++--
>  drivers/acpi/acpica/nsobject.c                |  4 ++
>  drivers/acpi/acpica/nsparse.c                 |  2 +-
>  drivers/acpi/acpica/nsrepair.c                |  2 +-
>  drivers/acpi/acpica/nsrepair2.c               |  4 +-
>  drivers/acpi/acpica/nsutils.c                 | 14 +++---
>  drivers/acpi/acpica/nsxfname.c                |  4 +-
>  drivers/acpi/acpica/psargs.c                  |  8 ++--
>  drivers/acpi/acpica/rsxface.c                 |  8 ++--
>  drivers/acpi/acpica/tbdata.c                  |  3 +-
>  drivers/acpi/acpica/tbfind.c                  | 20 ++++----
>  drivers/acpi/acpica/tbinstal.c                |  2 +-
>  drivers/acpi/acpica/tbprint.c                 | 10 ++--
>  drivers/acpi/acpica/tbutils.c                 |  6 +--
>  drivers/acpi/acpica/tbxface.c                 |  4 +-
>  drivers/acpi/acpica/tbxfload.c                | 15 +++---
>  drivers/acpi/acpica/utascii.c                 |  2 +-
>  drivers/acpi/acpica/utdecode.c                |  4 +-
>  drivers/acpi/acpica/utmisc.c                  |  8 ++--
>  drivers/acpi/acpica/utpredef.c                |  4 +-
>  drivers/acpi/acpica/utstring.c                |  6 +--
>  drivers/acpi/scan.c                           |  2 +-
>  drivers/acpi/sysfs.c                          | 14 +++---
>  drivers/acpi/tables.c                         |  4 +-
>  include/acpi/acpixf.h                         |  2 +-
>  include/acpi/actbl.h                          |  4 +-
>  include/acpi/actypes.h                        | 12 ++---
>  .../os_specific/service_layers/oslinuxtbl.c   | 48 +++++++++----------
>  tools/power/acpi/tools/acpidump/apdump.c      |  8 ++--
>  tools/power/acpi/tools/acpidump/apfiles.c     |  8 ++--
>  41 files changed, 142 insertions(+), 132 deletions(-)
> 
> --
> 2.17.2

