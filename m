From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: kacpid and acpid
Date: Wed, 30 Apr 2008 11:57:22 -0300
Message-ID: <20080430145722.GE3543@khazad-dum.debian.net>
References: <48187B40.4090003@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:52825 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756299AbYD3O5Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 10:57:24 -0400
Content-Disposition: inline
In-Reply-To: <48187B40.4090003@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Feldmann <feldmann_markus@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Wed, 30 Apr 2008, Markus Feldmann wrote:
> my Problem is that i can not install "acpid" and "acpi-support"
> correctly, because another Process "kacpid" have got Access to
> /proc/acpi/event

Upgrade to latest Debian Lenny (it is NOT a stable distribution), check
if it fixed the issue, and if not, ask about it on debian-user at lists
debian org...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
