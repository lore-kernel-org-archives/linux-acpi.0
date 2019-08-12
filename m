Return-Path: <SRS0=atkf=WI=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF813C31E40
	for <linux-acpi@archiver.kernel.org>; Mon, 12 Aug 2019 11:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0408208C2
	for <linux-acpi@archiver.kernel.org>; Mon, 12 Aug 2019 11:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565611154;
	bh=vBt+QSKBMMCiqKR4EJbOKmSTXRlZV73GsGzL2FwUFJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m4T59WEZ4R8QG/Ftyq/QR/05HODclPH22ZSWqkVqgjpazesASoLXvbA64+84MQ/Qz
	 2YsUvbDfzNFQsIZ6fRzTIyEd+hnoU/RDzagOHKaR0hJGiddxaCKyf25jkYdD5xlj9k
	 3f7rcMXHpOa9wHWbNiYsd0Ct5umTI2RxO2+wtrSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfHLL7O (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbfHLL7O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Aug 2019 07:59:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 119E3206DF;
        Mon, 12 Aug 2019 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565611152;
        bh=vBt+QSKBMMCiqKR4EJbOKmSTXRlZV73GsGzL2FwUFJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNg4o/1DEJKQAm6uBrNHwHIN+mT16FEFUIdmxoWSh26piY5b/OFu3/R6KVvSGZyVE
         LBmqq11G1+mi2FqfDTde3aOME9v4BE4eoQl+JtsT9nCU4AnoXyK+r1BLkCwUIX3zq/
         nIZfbgFk7V6RTyvRIDL0O3KVu3itpDSJYE/adOOA=
Date:   Mon, 12 Aug 2019 12:59:07 +0100
From:   Will Deacon <will@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Richter <rrichter@marvell.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
Subject: Re: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
Message-ID: <20190812115907.kugk57jvv3g2r66a@willie-the-truck>
References: <20190808204007.30110-1-jeremy.linton@arm.com>
 <20190808204007.30110-2-jeremy.linton@arm.com>
 <20190808222518.5q4fhd2tvs4lb6aw@rric.localdomain>
 <CAJZ5v0imn0X=M38LJcwe76gfLafWGU+MgyGd=NuKAeDtNZ+1DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0imn0X=M38LJcwe76gfLafWGU+MgyGd=NuKAeDtNZ+1DQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 12, 2019 at 11:06:07AM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 9, 2019 at 12:25 AM Robert Richter <rrichter@marvell.com> wrote:
> >
> > On 08.08.19 15:40:06, Jeremy Linton wrote:
> > > ACPI 6.3 adds a flag to the CPU node to indicate whether
> > > the given PE is a thread. Add a function to return that
> > > information for a given linux logical CPU.
> > >
> > > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/acpi/pptt.c  | 53 +++++++++++++++++++++++++++++++++++++++++++-
> > >  include/linux/acpi.h |  5 +++++
> > >  2 files changed, 57 insertions(+), 1 deletion(-)
> >
> > Reviewed-by: Robert Richter <rrichter@marvell.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> and please push it through ARM64 along with the second patch.

Thanks. I'll push these into -next shortly.

Will
