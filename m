Return-Path: <SRS0=PXo4=CQ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4189C43461
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Sep 2020 11:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04D92166E
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Sep 2020 11:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599477586;
	bh=1ynu4cRH0mrmI1AHQ2qFgUodO9DAHgmnCBSCmgnIJHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oe/RUFvqyBiZiWRUpYMrh7+1vrAD1pucEEYo+722S0mjpf1GHLz5YwhFfjSHh+msI
	 0+Td0+j0rXJ1PMIviAwJlDcQVgxjX1Ulk08X3hmiXI8TUk/1JOhBtQDSrKMKJRpPBn
	 58QrS8Uzk16wY1KwiztA6RPyQNZo7xQk7oK4K+g8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgIGLSg (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbgIGLRz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 07:17:55 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF1C216C4;
        Mon,  7 Sep 2020 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599477464;
        bh=1ynu4cRH0mrmI1AHQ2qFgUodO9DAHgmnCBSCmgnIJHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eT+dWR69llGSaQO2YnAk68qy8gi+V0r1GW0uSxcpAOmG4rVVPeldLZJQoOP906/dQ
         NpOlk+J3HKU+9UrW0JUq1VYst6yxkCwduoq3+4tK3MbHseYrodUpKkfkLNhA0pzHrE
         jSC9yeSb/Y3RKVKmhdJjoPnYLa3H/G2QEpCBTrig=
Date:   Mon, 7 Sep 2020 13:17:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: Remove device connection documentation
Message-ID: <20200907111740.GB299300@kroah.com>
References: <20200907103750.9093-1-heikki.krogerus@linux.intel.com>
 <20200907103750.9093-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907103750.9093-3-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 01:37:50PM +0300, Heikki Krogerus wrote:
> The API that allowed device connection descriptions to
> be added is now removed, so removing also the documentation
> for it.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  .../driver-api/device_connection.rst          | 43 -------------------
>  1 file changed, 43 deletions(-)
>  delete mode 100644 Documentation/driver-api/device_connection.rst

Oops, you forgot to remove this file from the list in
Documentation/driver-api/index.rst, which I think will now break the
documentation build, right?

Can you redo this one with that fix?

thanks,

greg k-h
