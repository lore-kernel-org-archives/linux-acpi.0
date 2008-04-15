From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Tue, 15 Apr 2008 12:44:49 +0930 (CST)
Message-ID: <200804150314.m3F3EnJW011526@turbo.physics.adelaide.edu.au>
References: <1208171944.888.20.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:56611 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761870AbYDODjM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 23:39:12 -0400
In-Reply-To: <1208171944.888.20.camel@earth.gruber.myown> from "nokos@gmx.net" at Apr 14, 2008 01:19:04 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: trenn@suse.de, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

> > There probably are machines out there which only have one of above
> > devices, then only the relevant driver should be loaded.
> 
> I thought the since there is only a small functionality in each part and
> the module only registers drivers which are started only if an
> appropriate device is present it might be good to integrate it in one
> module. (in the S6410 case there is actually a third device FUJ02E1 but
> I don't know yet what it is for, there are some notifies for that device
> in the DSDT but so far I haven't triggered any of them)

A fair point.  I guess it really depends on how these devices end up being
structured.  Modularity enforces separation which can help with
maintainability going forward but it can also give rise to a certain
amount of code duplication.  I'd be interested to see what others think.

Regards
  jonathan
