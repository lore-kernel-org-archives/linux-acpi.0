Return-Path: <SRS0=qsjX=3Y=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A736C2D0B1
	for <linux-acpi@archiver.kernel.org>; Tue,  4 Feb 2020 09:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6DF21744
	for <linux-acpi@archiver.kernel.org>; Tue,  4 Feb 2020 09:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgBDJRK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:17:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:49366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgBDJRK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Feb 2020 04:17:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE908AC65;
        Tue,  4 Feb 2020 09:17:08 +0000 (UTC)
Date:   Tue, 4 Feb 2020 10:17:07 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-acpi@vger.kernel.org
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Note about acpi_get_table_header
Message-ID: <20200204101707.30eaa5bb@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

The description block before acpi_get_table_header() in
drivers/acpi/acpica/tbxface.c includes the following comment:

 * NOTE:        Caller is responsible in unmapping the header with
 *              acpi_os_unmap_memory

However, looking at the code, it seems that we are already calling
acpi_os_unmap_memory() internally as appropriate, and we always return
a copy of the header, not a pointer to it. So I see no reason why the
caller would ever need to call acpi_os_unmap_memory(). As a matter of
fact the only current caller of this function does NOT call
acpi_os_unmap_memory() afterwards.

So I believe this note is wrong and should be removed?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
