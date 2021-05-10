Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EFCC433B4
	for <linux-acpi@archiver.kernel.org>; Mon, 10 May 2021 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E8B61260
	for <linux-acpi@archiver.kernel.org>; Mon, 10 May 2021 14:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhEJOcr (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 10 May 2021 10:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234282AbhEJOao (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 10:30:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2670C611CE;
        Mon, 10 May 2021 14:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620656979;
        bh=jXtawgAEql2mdBiBp3QIE60fK6xUJp5RjRSJRC/3OBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyhB93OH82HR274R7A4zGYpmBR4q4i+Ug09CSUECeTXg9rr/vCjvC0uPqCNysJVPF
         hYcOEwe72vFXinK1jPech1xPs32LtQ37xsmilcWUrnk3TJEP44ISP45/nLX+rBskVw
         bT8N/MLaHea+xWf+SH62CylqyyvJwebAtW/GTTmI=
Date:   Mon, 10 May 2021 16:29:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1] usb: typec: tcpm: Don't block probing of consumers of
 "connector" nodes
Message-ID: <YJlDURS+6DHgDwEx@kroah.com>
References: <20210506004423.345199-1-saravanak@google.com>
 <CALAqxLU+Uf6OSDLG8OC_gHY9-VVHPgu0_bXxJcO8B4peFugtqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLU+Uf6OSDLG8OC_gHY9-VVHPgu0_bXxJcO8B4peFugtqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 05, 2021 at 07:01:04PM -0700, John Stultz wrote:
> On Wed, May 5, 2021 at 5:44 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > fw_devlink expects DT device nodes with "compatible" property to have
> > struct devices created for them. Since the connector node might not be
> > populated as a device, mark it as such so that fw_devlink knows not to
> > wait on this fwnode being populated as a struct device.
> >
> > Without this patch, USB functionality can be broken on some boards.
> >
> > Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-endpoint")
> > Reported-by: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> 
> Tested-by: John Stultz <john.stultz@linaro.org>
> 
> Thanks so much for this fix! HiKey960 is back to booting properly!
> -john

Now queued up, thanks.

greg k-h
