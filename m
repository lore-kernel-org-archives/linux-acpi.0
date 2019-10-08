Return-Path: <SRS0=WKK3=YB=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6CC4360C
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Oct 2019 11:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DCA20679
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Oct 2019 11:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfJHLyK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:54:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730618AbfJHLyJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Oct 2019 07:54:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1BD1EACC6;
        Tue,  8 Oct 2019 11:54:08 +0000 (UTC)
Date:   Tue, 8 Oct 2019 13:54:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v9 08/12] lib/vsprintf: Add a note on re-using %pf or %pF
Message-ID: <20191008115407.6qiv66cc6b566bys@pathway.suse.cz>
References: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
 <20191003123219.11237-9-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003123219.11237-9-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu 2019-10-03 15:32:15, Sakari Ailus wrote:
> Add a note warning of re-use of obsolete %pf or %pF extensions.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
