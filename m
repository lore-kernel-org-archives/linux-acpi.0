From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: RTC or button wakeup
Date: Tue, 1 Jul 2008 14:40:31 -0300
Message-ID: <20080701174031.GC24605@khazad-dum.debian.net>
References: <4867B402.2070104@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37068 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751234AbYGARkp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jul 2008 13:40:45 -0400
Content-Disposition: inline
In-Reply-To: <4867B402.2070104@tiscali.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Enno Fennema <e.fennema@tiscali.nl>
Cc: linux-acpi@vger.kernel.org

On Sun, 29 Jun 2008, Enno Fennema wrote:
> Could anyone suggest a way to determine in a (shell) program whether my  
> computer was switched on by RTC alarm or by me pressing the power button.

Check the wakeup reason in dmidecode.  There is a very low, but non-zero
chance that the BIOS implemented it properly, and it would tell you if it
was a power-button wakeup, or rtc wakeup.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
