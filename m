From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 09/20] ACPI: thinkpad-acpi: uncouple subdriver init from ibms struct
Date: Sat, 21 Apr 2007 23:40:51 -0400
Message-ID: <200704212340.51550.lenb@kernel.org>
References: <11771645253042-git-send-email-hmh@hmh.eng.br> <11771645271352-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56513 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003AbXDVDtX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Apr 2007 23:49:23 -0400
In-Reply-To: <11771645271352-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@debian.org>

On Saturday 21 April 2007 10:08, Henrique de Moraes Holschuh wrote:
> From: Henrique de Moraes Holschuh <hmh@debian.org>
> 
> Move the .init method from ibms struct to another struct, and use a list
> head to control which subdrivers have been activated.
> 
> This allows us to have the subdriver init methods marked __init, saving
> quite a lot of .text size, and even a bit of .data size as some data can
> now be made __initdata.

does this save any space when the driver is compiled as a module?

-Len
