From: Mattia Dongili <malattia@linux.it>
Subject: Re: ACPI & driver patch candidates for 2.6.33-rc4
Date: Sat, 16 Jan 2010 20:58:46 +0900
Message-ID: <20100116115846.GH7161@kamineko.org>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:43992
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab0APL6s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 06:58:48 -0500
Content-Disposition: inline
In-Reply-To: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Sat, Jan 16, 2010 at 02:32:50AM -0500, Len Brown wrote:
> please speak up now if any of these should not go upstream.

Hi Len,

Please also apply 
  [PATCH] sony-laptop - fix using of uninitialized variable
from Dmitry on Jan 10th[1]

[1]: http://patchwork.kernel.org/patch/71976/
-- 
mattia
:wq!
