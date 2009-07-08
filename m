From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BISECTED] (REGRESSION) HP G7000 battery disappears after
 suspend
Date: Wed, 8 Jul 2009 23:24:35 +0100
Message-ID: <20090708232435.5e694c28@lxorguk.ukuu.org.uk>
References: <61b223ba0907081216q3813c8f0n677bcce8b24ae52c@mail.gmail.com>
	<200907082141.18135.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:32847 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753869AbZGHWZG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jul 2009 18:25:06 -0400
In-Reply-To: <200907082141.18135.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>

> Now, the only case this patch can make any difference is when the BIOS doesn't
> set SCI_EN before returning control the the kernel, which quite evidently is a
> BIOS bug.  The fact that the battery doesn't work with this patch applied means
> that the BIOS not only doesn't set SCI_EN, but also expects it to remain unset,
> which is insane.
> 
> IMO this is a "won't fix", sorry.

It's an "oh god we need another DMI entry" case and a regression so it
wants fixing for the next -rc.

Alan
