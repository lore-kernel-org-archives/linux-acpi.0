From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] sony-laptop and sonypi for 2.6.23-rc2
Date: Fri, 3 Aug 2007 15:27:05 -0400
Message-ID: <200708031527.06045.lenb@kernel.org>
References: <118615455219-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35892 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760106AbXHCT1P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 15:27:15 -0400
In-Reply-To: <118615455219-git-send-email-malattia@linux.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

Applied.

thanks,
-Len

On Friday 03 August 2007 11:22, Mattia Dongili wrote:
> Hi Len,
> 
> these 3 patches are aimed at 2.6.23-rc2 if there is time enough.
> There's only http://bugzilla.kernel.org/show_bug.cgi?id=8803 left,
> I hope to be able to have it sorted out soon.
> 
> Please apply
> ---
>  drivers/char/sonypi.c      |    8 ++++++--
>  drivers/misc/sony-laptop.c |    9 ++++++---
>  2 files changed, 12 insertions(+), 5 deletions(-)
