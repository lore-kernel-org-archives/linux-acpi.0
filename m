From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] sony-laptop: allow complex per-value input/output validation
Date: Mon, 12 Feb 2007 23:55:56 -0500
Message-ID: <200702122355.56336.lenb@kernel.org>
References: <20070212210107.GA5577@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45433 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161018AbXBME5U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Feb 2007 23:57:20 -0500
In-Reply-To: <20070212210107.GA5577@inferi.kami.home>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

On Monday 12 February 2007 16:01, Mattia Dongili wrote:
> allows consistency between the sony-laptop
> specific 'brightness_default' and the backlight subsystem 0-based
> 'brightness'.

Why do we need to have "sony-laptop specific 'brightness_default'" --
is that a shortcoming of the backlight subsystem?

thanks,
-Len
