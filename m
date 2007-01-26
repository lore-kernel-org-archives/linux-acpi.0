From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 5/7] asus-laptop: add display switching support
Date: Fri, 26 Jan 2007 03:04:31 -0500
Message-ID: <200701260304.32068.lenb@kernel.org>
References: <200701251254.56798.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59824 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030814AbXAZILx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 03:11:53 -0500
In-Reply-To: <200701251254.56798.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On Thursday 25 January 2007 06:54, Corentin CHARY wrote:
> /sys/.../asus-laptop/display can now be used to switch displays like the old
> /proc/acpi/asus/disp does
> 
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>  asus-laptop.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)

Tried to apply this series on top of 2.6.20-rc6 and it stopped applying here.
Late here, maybe operator error...

In any case, it is probably simplest if the patch series is based off of Linus' tree
unless it has dependencies on stuff in the acpi-test tree which have to go in
before this goes in.

thanks,
-Len
