Return-Path: <SRS0=s14x=SK=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A252C10F14
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7EF218EA
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554738167;
	bh=nWemL7SHJ7gPd5YbSIkkmwRpuaAXgFtg8KYf9tI5T5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wAzPhnQPRKxQM5hDN/bCkl2oovt78E0ZzObPXVDntJtF7mETge1UvnGcj1+rB9vtc
	 XDChRt0Q1bfdHD9u6KDv1m1d4ts7cT0eZpX9yLXiQUX+OX3q9qx12Cg03WKzfGR0pZ
	 tQ3yYpe/zJAprQqnIpwjtsbZsPJ4BAQ9N+/864lE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDHPml (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:42:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:48753 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHPmj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Apr 2019 11:42:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 08:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="159785522"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2019 08:42:38 -0700
Date:   Mon, 8 Apr 2019 09:44:15 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, lenb@kernel.org,
        keith.busch@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] acpi/hmat: fix an uninitialized memory_target
Message-ID: <20190408154415.GG32498@localhost.localdomain>
References: <20190407011222.38963-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190407011222.38963-1-cai@lca.pw>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190408154415.2UfiZnZcHjzBpfmo11yA5mr4b-m82aIXtz_xcTBG3Vk@z>

On Sat, Apr 06, 2019 at 09:12:22PM -0400, Qian Cai wrote:
> The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> memory") introduced an uninitialized "struct memory_target" that could
> cause an incorrect branching.

Thanks for the catch. We do have another patch submitted a few days that
fixes this, though:

  https://patchwork.kernel.org/patch/10887487/
