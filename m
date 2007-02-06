From: Len Brown <lenb@kernel.org>
Subject: Re: Regression in kernel linux-2.6.20-rc1/2: Problems with poweroff
Date: Mon, 5 Feb 2007 22:28:34 -0500
Message-ID: <200702052228.34264.lenb@kernel.org>
References: <459069AA.20809@rrz.uni-koeln.de> <45999C47.40204@rrz.uni-koeln.de> <20070102190722.GT20714@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59756 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbXBFDd6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Feb 2007 22:33:58 -0500
In-Reply-To: <20070102190722.GT20714@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Berthold Cogel <cogel@rrz.uni-koeln.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

> On Tue, Jan 02, 2007 at 12:41:59AM +0100, Berthold Cogel wrote:

> > >> 'shutdown -h now' doesn't work for my system (Acer Extensa 3002 WLMi)
> > >> with linux-2.6.20-rc kernels. The system reboots instead.
> > >> I've checked linux-2.6.19.1 with an almost identical .config file
> > >> (differences because of new or changed options). For pre 2.6.20 kernels
> > >> shutdown works for my computer.

Try CONFIG_USB=n

http://bugzilla.kernel.org/show_bug.cgi?id=7945

-Len
