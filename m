From: Yuhong Bao <yuhongbao_386@hotmail.com>
Subject: Re: [PATCH] ACPI: Adjust the return value of =?utf-8?b?X1JFVg==?= on x86
Date: Thu, 26 Mar 2015 02:40:55 +0000 (UTC)
Message-ID: <loom.20150326T033956-898@post.gmane.org>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com> <1426363131-14530-1-git-send-email-jason.ekstrand@intel.com> <CAOFGe95CiLcHtzD3Vv-KJoCXfeHCyGa55OBkzHSZMWwdOyLnfg@mail.gmail.com> <20150323120331.GA3007@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44710 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbbCZCpJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Mar 2015 22:45:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1Yaxn5-0003a4-V7
	for linux-acpi@vger.kernel.org; Thu, 26 Mar 2015 03:45:04 +0100
Received: from S0106001b21018173.vc.shawcable.net ([50.67.244.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2015 03:45:03 +0100
Received: from yuhongbao_386 by S0106001b21018173.vc.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2015 03:45:03 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Matt Fleming <matt <at> codeblueprint.co.uk> writes:
> P.S If Dell XPS13 owners try this patch and audio isn't magically
> detected, make sure you perform *two* cold boots. There appears to be some
> level of caching going where the last read _REV value is used.

I suggested in the comments on mjg59's blog that a BIOS option set by the
user be used for things like this.

