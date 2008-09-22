From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: bluetooth support for Toshiba Tecra A8
Date: Mon, 22 Sep 2008 21:12:30 +0100
Message-ID: <200809222112.31146.carlos@strangeworlds.co.uk>
References: <48D79E5A.2090406@softhard.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:44738 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbYIVUMo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2008 16:12:44 -0400
In-Reply-To: <48D79E5A.2090406@softhard.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sawa@softhard.org
Cc: linux-acpi@vger.kernel.org

On Monday 22 September 2008 14:32:10 Sava Rados wrote:
> Every time I upgrade kernel on my system, I need to [patch toshiba_]acpi
> module to get my laptop to work with bluetooth.
> [..]
> Can anyone tell me who to talk to and why this can't be implemented to
> the official acpi module?

A version of this patch which exposes bluetooth via the rfkill interface 
instead of /proc has been picked up by John Linville in the wireless tree. It 
will be merged in 2.6.28.

http://git.kernel.org/?p=linux/kernel/git/linville/wireless-next-2.6.git;a=commit;h=c41a40c58b623f97dd2e23aa3baab2cedb47d99f


-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
