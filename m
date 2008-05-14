From: Andy Neitzke <neitzke@ias.edu>
Subject: Re: /proc/acpi/battery/BAT0/info stale when battery changed on Thinkpad X60t
Date: Wed, 14 May 2008 19:18:50 -0400
Message-ID: <200805141918.50286.neitzke@ias.edu>
References: <200805141105.02277.neitzke@ias.edu> <482B1D11.3000600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.ias.edu ([192.16.204.102]:57109 "EHLO smtp2.ias.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbYEOBnH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 21:43:07 -0400
In-Reply-To: <482B1D11.3000600@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 14 May 2008 1:10:41 pm Alexey Starikovskiy wrote:
> Please check if following patch helps:
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index b1c723f..e5ca3a0 100644

Yes, with that patch the problem seems to have gone away.

Thanks!

-Andy
