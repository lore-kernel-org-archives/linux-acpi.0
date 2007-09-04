From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] thinkpad-acpi changes targeted at 2.6.23-rc6 (v2)
Date: Tue, 4 Sep 2007 17:25:06 -0400
Message-ID: <200709041725.06516.lenb@kernel.org>
References: <1188915196931-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46346 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273AbXIDVVR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Sep 2007 17:21:17 -0400
In-Reply-To: <1188915196931-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tuesday 04 September 2007 10:13, you wrote:
> 
> Len,
> 
> Here is a new version of the patches for thinkpad-acpi that I'd like to
> see merged in mainline before 2.6.23-rc6 is out.  There were *no* code
> chages since the last version.  I have updated the patch comments and
> title as you suggested, and also made some changes to the thinkpad-acpi
> documentation in the patch.
> 
> As usual, it is available at:
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-release                                                                  
> 
> Shortlog of the above branch:
> Henrique de Moraes Holschuh (3):
>       ACPI: event: fix acpi_bus_generate_netlink_event call
>       ACPI: thinkpad-acpi: revert new 2.6.23 CONFIG_THINKPAD_ACPI_INPUT_ENABLED option
>       ACPI: thinkpad-acpi: bump up version to 0.16
> 

thanks for updating this, Henrique, it is a big improvement.
I'll apply it to my release branch.

-Len
