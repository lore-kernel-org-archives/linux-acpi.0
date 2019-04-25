Return-Path: <SRS0=/XBo=S3=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA30C43218
	for <linux-acpi@archiver.kernel.org>; Thu, 25 Apr 2019 19:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51E92077C
	for <linux-acpi@archiver.kernel.org>; Thu, 25 Apr 2019 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221608;
	bh=65crUk8nsSSRa6Vy0cJEBEIUDn+xP/Hhch2sRMSTUT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JN7EWILuOAnd5gVJKu+2G1KYN+wypntXbMFyU3rnCZQQ6Kso0NA+bdK6gEa6HdAKb
	 gpFNgxer3L3eTNbtlh3vYtwexKo54Liasn1hQ8aLbOUgNWNieK489aJoaXTHPzbAV1
	 wBBPh+xKeg4UyA/EHnc3sRB1OY6Q8D7thEYMlhdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfDYTqs (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfDYTqr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Apr 2019 15:46:47 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD05206BF;
        Thu, 25 Apr 2019 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221607;
        bh=65crUk8nsSSRa6Vy0cJEBEIUDn+xP/Hhch2sRMSTUT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUwVWHtaW3Yw0q6a6u5I+M3QReBGVPgDEaiX2CM+TGd61moAQ62oYxmEex6iJlRYD
         QhJReyVZhHy7yeKbfgiX9SumOh+I4QS03qslViCbTGxqTCEs6rzfz9rJ+4rv5mE4od
         YpW8UNomn1NjtIat5hucuJF3WN3DHCxwEdGvvodM=
Date:   Thu, 25 Apr 2019 21:46:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 05/13] driver core: Add helper
 device_find_child_by_name()
Message-ID: <20190425194644.GB14552@kroah.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-6-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190412134122.82903-6-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190425194644.P71yaRXRNp55s9s8eyAh9I5t81ziHrc4ZvKHke023KA@z>

On Fri, Apr 12, 2019 at 04:41:14PM +0300, Heikki Krogerus wrote:
> It looks like the child device is often matched with a name.
> This introduces a helper that does it automatically.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
