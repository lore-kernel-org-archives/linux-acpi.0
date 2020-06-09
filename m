Return-Path: <SRS0=PV1G=7W=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00836C433E0
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Jun 2020 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4561207F9
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Jun 2020 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591701185;
	bh=OdDa6FOuHaEzYzy7yhXy/IuRfvsjZXDtHPm1HnIBno8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TRpiO26cqNa6qGa/3vRx0aXin/2x/NPoxYM0CpBMurmqdVuNlpTutyDGbQz9dRoBw
	 rNoO9Dj+3unjQQUuqI4idrSw9285Ueq2coo8Tnbwj8z11ClUQgILYJyu5QOhQVqE6E
	 6RYw/Iv6V691fag/2FQWfCdYSbdPAO7nkwUG5fHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgFILMz (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgFILMy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Jun 2020 07:12:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0CE7207ED;
        Tue,  9 Jun 2020 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591701174;
        bh=OdDa6FOuHaEzYzy7yhXy/IuRfvsjZXDtHPm1HnIBno8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgSKqYnFRv3uB3Y4aOb8f2660QiGhY534hS78U9s6Z4YRKrhQfRRDWPbNwffZzbYa
         wjGTLDiaSuwNPJTelJzjWtrgH6fQrz6e5+Fm+Mr4fkzDbu8jg98IdhhE5245A5dWz7
         gXMhgdR3plUBAbHcEOsygM60HeYdOXs2JRgOtTWA=
Date:   Tue, 9 Jun 2020 13:12:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v3 4/7] printk: Add pr_debug_level macro over dynamic one
Message-ID: <20200609111252.GB780233@kroah.com>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
 <20200609104604.1594-5-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609104604.1594-5-stanimir.varbanov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 09, 2020 at 01:46:01PM +0300, Stanimir Varbanov wrote:
> Introduce new pr_debug_level macro over dynamic_debug level one
> to allow dynamic debugging to show only important messages.

What does "important messages" mean???

