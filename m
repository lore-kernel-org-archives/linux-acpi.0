From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 8/9] ACPI: thinkpad-acpi: add sysfs support to hotkey subdriver
Date: Sat, 28 Apr 2007 21:47:59 -0400
Message-ID: <200704282148.00041.lenb@kernel.org>
References: <11777220172751-git-send-email-hmh@hmh.eng.br> <11777220182109-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54420 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbXD2B7M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Apr 2007 21:59:12 -0400
In-Reply-To: <11777220182109-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, luming.yu@intel.com

On Friday 27 April 2007 21:00, Henrique de Moraes Holschuh wrote:
> Add the hotkey sysfs support.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  Documentation/thinkpad-acpi.txt |   58 ++++++++++++++----
>  drivers/misc/thinkpad_acpi.c    |  127 +++++++++++++++++++++++++++++++++++++++
>  drivers/misc/thinkpad_acpi.h    |    2 +
>  3 files changed, 176 insertions(+), 11 deletions(-)

I haven't tried this out.
I was wondering how you know what action should be associated with what key?

if that association can be made, is is possible to send the events to
the input layer like other keyboard events?

thanks,
-Len
