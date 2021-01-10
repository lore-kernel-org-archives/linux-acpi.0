Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC1EC43381
	for <linux-acpi@archiver.kernel.org>; Sun, 10 Jan 2021 15:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3432389B
	for <linux-acpi@archiver.kernel.org>; Sun, 10 Jan 2021 15:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAJPIu (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 10 Jan 2021 10:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbhAJPIu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 10 Jan 2021 10:08:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59C1523719;
        Sun, 10 Jan 2021 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610291268;
        bh=bCoT+YC8imLT2HAQJHyTTrBGySz+HBiv3aSwzELycoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OhUPFLdO29F8HOoRwt/e0iVSgi3zlrrPU+nggNDAgbxI9t+qQPBuMbQsJkfOpWXun
         RPvshY4syPPPoHE93oRwvdeLIFG0g6V3bqZ7TRASLlz3fJbr2FPFdHUXPlQPJbPiQu
         ZWNz7iS5zPNhWehA2wumkgSZqyp6dgaitFm/4EE0=
Date:   Sun, 10 Jan 2021 16:09:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, mchehab@kernel.org, sergey.senozhatsky@gmail.com,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 06/15] software_node: unregister software_nodes in
 reverse order
Message-ID: <X/sYjqjcWKlOoaQ0@kroah.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-7-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-7-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 01:28:29PM +0000, Daniel Scally wrote:
> To maintain consistency with software_node_unregister_nodes(), reverse
> the order in which the software_node_unregister_node_group() function
> unregisters nodes.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
