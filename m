From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] acpi: add backlight support to the sony_acpi driver (v2)
Date: Fri, 1 Dec 2006 17:43:37 -0200
Message-ID: <20061201194337.GA7773@khazad-dum.debian.net>
References: <20061127174328.30e8856e.alessandro.guido@gmail.com> <20061201133520.GC4239@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:7878 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S936524AbWLAToR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Dec 2006 14:44:17 -0500
Content-Disposition: inline
In-Reply-To: <20061201133520.GC4239@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org, linux-acpi@vger.kernel.org, len.brown@intel.com

On Fri, 01 Dec 2006, Pavel Machek wrote:
> Looks okay to me. We really want unified interface for backlight.

Then I request some help to get
http://article.gmane.org/gmane.linux.acpi.devel/19792
merged.

Without it, the backlight interface becomes annoying on laptops.  Your
screen will be powered off when you remove the modules providing the
backlight interface.  This is not consistent with the needs of laptop
backlight devices, or with the behaviour the drivers had before the
backlight sysfs support was added.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
