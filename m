From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/6 try3] sony-laptop for 2.6.25
Date: Thu, 24 Jan 2008 00:49:56 -0500
Message-ID: <200801240049.56344.lenb@kernel.org>
References: <1200301546-6079-1-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54417 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbYAXFuN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jan 2008 00:50:13 -0500
In-Reply-To: <1200301546-6079-1-git-send-email-malattia@linux.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

On Monday 14 January 2008 04:05, Mattia Dongili wrote:
> Hi Len,
> 
> here we go again, this time checkpatch clean.
> 
>  drivers/misc/sony-laptop.c |  501 +++++++++++++++++++++++++++------------------
>  include/linux/sonypi.h     |    2 
>  2 files changed, 305 insertions(+), 198 deletions(-)

wow, this thing is becoming a sub-system in itself (like thinkpad:-)

1-6 applied to acpi-test.

thanks,
-Len
