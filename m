Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70231C433E0
	for <linux-acpi@archiver.kernel.org>; Wed, 20 Jan 2021 20:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2708623441
	for <linux-acpi@archiver.kernel.org>; Wed, 20 Jan 2021 20:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389893AbhATUKM (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:10:12 -0500
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:45328 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389909AbhATUKJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Jan 2021 15:10:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8D930182CED28;
        Wed, 20 Jan 2021 20:09:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: gold90_1a0b8a72755d
X-Filterd-Recvd-Size: 1045
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Jan 2021 20:09:20 +0000 (UTC)
Message-ID: <614c6027cc22a5024b4ee3334079d501998add83.camel@perches.com>
Subject: Re: [PATCH v1 0/6] ACPI:  Clean up printing messages in some source
 files
From:   Joe Perches <joe@perches.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Date:   Wed, 20 Jan 2021 12:09:19 -0800
In-Reply-To: <2809410.8bz27usjlQ@kreacher>
References: <2809410.8bz27usjlQ@kreacher>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2021-01-20 at 19:56 +0100, Rafael J. Wysocki wrote:
> This series cleans up messaging in some source files under drivers/acpi/
> and get rids of some debug code pieces that aren't needed any more.

Thanks Rafael.


