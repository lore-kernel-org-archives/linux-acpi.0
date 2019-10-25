Return-Path: <SRS0=XdkV=YS=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D36CA9EA0
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Oct 2019 09:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CC32070B
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Oct 2019 09:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571995153;
	bh=geuqWCjlYvm/sqz35UtH68P7tbWZqVRmXWSoJ8BQI7Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q7lt597xn13AsPaw6j6iyxoQthqHPsxHRQ51rsr5QnLuqw+YlHrqmz6xLmr6fwckE
	 V1VgxSm24EOjkttm0obujnTNJ76UTzFFADrikhBeyGX0jvqsp63aW0AzUDWFfh6QNU
	 ZEXZV3VoBQPpMkAyxJBr9oKlyQTUtTUJmoh43T2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438249AbfJYJTM (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:19:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41231 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfJYJTM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2019 05:19:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id 94so1541587oty.8
        for <linux-acpi@vger.kernel.org>; Fri, 25 Oct 2019 02:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eO6kpTIXKYcY4ou5sdoReZQ7k/e/XcEWAgmC5JAEAbM=;
        b=fV6IEAYaHlzpVZucCQyxW4MSRUc3HT9DYR9EkiR3DJsF7wAbG6UAc2WkzrK8zWqjeL
         Je/Qmq9Fj7nf0cJ7dF2+gWDZTHrM4kLoEjFouGOcrPN5kTrGRYeZMIbq96noZvlExpqi
         /uxOpCRGkjonJP4jbgYqGikdDF0oXmRbp4MWE9Y4lCGH0t0mfg6RloR9lkYkAlsvvn5N
         HRHrXJDIsQTBkpl9M5UtwCZVeuNX144MTG3nch2O8imHVacVjtZhi4v2ckxD1hKDDUVO
         lCqsQKUU1oJlAOpLI2hoI461xLanrnBVKfbBXUp0MJ3zGykl9gh00t5afoqz17J+KUVQ
         bWgg==
X-Gm-Message-State: APjAAAU7WNldy6uAd5UCi2btw20dcr6nyzTwdQ+2QBzba2B/f50SFWE3
        j3//kRDFX6+J0A1pfQOUKFSSHqQfIynZAXU039I=
X-Google-Smtp-Source: APXvYqw+T996enm3bzg1Ug2Oo2tklbN/dna8OVt4+rhQ0y1BHc9Za+kliY9otnBdocuRbRwJN4vOZ4SgESoxaqQGiTc=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr1982615oth.266.1571995151487;
 Fri, 25 Oct 2019 02:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191024185556.4606-1-erik.schmauss@intel.com>
In-Reply-To: <20191024185556.4606-1-erik.schmauss@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Oct 2019 11:19:00 +0200
Message-ID: <CAJZ5v0gqN3yGcLLVntYQgwxVsUhbEZ8L0UJNXOh=xA6nmgTQLA@mail.gmail.com>
Subject: Re: [PATCH 00/12] ACPICA version 20191018
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2019 at 9:13 PM Erik Schmauss <erik.schmauss@intel.com> wrote:
>
> This patchset contains the linuxized patches for ACPICA version
> 20191018. There are several debugger changes but they are meant for
> acpiexec at this time. acpi_load_table definition has been modified and
> a new acpi_unload_table has been added. These new interfaces can be used
> as a part of config fs to load and unload tables.
>
> Other than that, Bob has run clang on our code base and removed several
> compiler warnings.
>
> This patchset is also available here:
> https://github.com/SchmErik/linux/tree/v20191018
>
> Bob Moore (5):
>   ACPICA: Results from Clang changes/fixes From Clang V5.0.1. Mostly
>     "set but never read" warnings.
>   ACPICA: Win OSL: Replace get_tick_count with get_tick_count64
>   ACPICA: More Clang changes - V8.0.1 Fixed all "dead assignment"
>     warnings.
>   ACPICA: Add new external interface, acpi_unload_table
>   ACPICA: Update version to 20191018
>
> Erik Schmauss (6):
>   ACPICA: utilities: add flag to only display data when dumping buffers
>   ACPICA: Debugger: add command to dump all fields of a particular
>     subtype
>   ACPICA: debugger: surround field unit output with braces '{'
>   ACPICA: debugger: add field unit support for acpi_db_get_next_token
>   ACPICA: acpiexec: initialize all simple types and field units from
>     user input
>   ACPICA: debugger: remove leading whitespaces when converting a string
>     to a buffer
>
> Nikolaus Voss (1):
>   ACPICA: make acpi_load_table() return table index

Queuing up as 5.5 material with some minor subject/changelog modifications.

Thanks!
