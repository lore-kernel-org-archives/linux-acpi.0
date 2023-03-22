Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B57CC6FD1F
	for <linux-acpi@archiver.kernel.org>; Wed, 22 Mar 2023 16:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCVQxb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjCVQxR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2023 12:53:17 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CAC37544;
        Wed, 22 Mar 2023 09:53:06 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id w9so75654274edc.3;
        Wed, 22 Mar 2023 09:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7yquCZhQA+v+ZfD35IzWGLK6PA2Qn2UgbWOUR3WcIs=;
        b=sH/zWVez9i1nUFlMRDqDAyWKwb5hO0jAOPMTA0UnJ6pPuxygyxRYorgFxzVd1T99Jb
         nwfsm3ImHnXqY9f5xZZtTq5FneFfKbgm0P/NQIMvFT1SVM7c3khmqlIdkWi7wxEWAcX8
         x+1CnGXi+fb11WS3Hg2hIlHeu5dvALcLVt3KdMjQDR9h7pbitGb9LAYZMiU5a2e1j1Eb
         o8S9ZQ3g9JimxqJKRLO+eVLUSgAy8yrB+tXysjmYEuUyP3wQgZ1afyjBUZIDdV7SF+r1
         DkY+fxVNo3oVYdVkxLK5oYdbg6f8vcGhl8Pu6aZW+BRPBtfx5tYfKFdYMVQW4iYbJZ7j
         u8DQ==
X-Gm-Message-State: AO0yUKVxISqgYzC8DOm0+N0Gy4hLeeM902uLz9sI4Zddyl2qKH6Que5/
        J/3x4JKK09vJmAN2yos0wkwNSEOKY5k1kEgXgr71dM9W
X-Google-Smtp-Source: AK7set8/U60E58wa9luxEtwbEFbm4h7J+Ws/lQ2rT0SBr67D3TPjBoIhkbHYwTDOLKSWzmL0nL2s0QhkEqMLOI8IkVU=
X-Received: by 2002:a17:906:c413:b0:92f:7c42:863d with SMTP id
 u19-20020a170906c41300b0092f7c42863dmr3408827ejz.2.1679503984146; Wed, 22 Mar
 2023 09:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230317073310.4237-1-xueshuai@linux.alibaba.com> <SJ1PR11MB6083FE558641F0E57FF1F5A4FC869@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083FE558641F0E57FF1F5A4FC869@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 17:52:53 +0100
Message-ID: <CAJZ5v0iX8N9G7yMC3f90JDuHXvdDRcwepcusp0bEctGBhGSnCg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
To:     "Luck, Tony" <tony.luck@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 22, 2023 at 5:13 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > Fix to return -EINVAL in the __einj_error_inject() error handling case
> > instead of -EBUSY, when explicitly indicated by the platform in the status
> > of the completed operation.
>
> Needs a bit longer description on the use case based on follow up discussion.
> Key information is the EINVAL is an indicator to the user that the parameters they
> supplied cannot be used for injection.

Right.

So Shuai, please resend the patch with a more elaborate changelog.

> But for the code:
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

And add the above tag to it when resending.
