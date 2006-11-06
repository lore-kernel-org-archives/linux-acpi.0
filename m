From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Overheating Problem: Acer 1525WLMi
Date: Mon, 6 Nov 2006 22:23:15 +0100
Message-ID: <200611062223.16168.rjw@sisk.pl>
References: <E1Gh0dO-0003TM-9y@fenris.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:15085 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1753823AbWKFVZc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Nov 2006 16:25:32 -0500
In-Reply-To: <E1Gh0dO-0003TM-9y@fenris.runbox.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Haller <sh@grep.ch>
Cc: linux-acpi@vger.kernel.org

Hi,

On Monday, 6 November 2006 10:19, Stefan Haller wrote:
> Hi all
> 
> I hope this is the right place to ask this.
> 
> I have an overheating problem with my acer 1525WLMi notebook (AMD64) and
> experience frequent shutdowns due to "critical temperature (80C) reached".
> Interesstingly, this happens when the temperature of THRC reaches 90C,
> not 80C. I did not yet experience any such shutdowns under WIndows.   
> 
> According to BIOS info, I have version 1.11 from Phoenix, which is the
> latest available from acer for my notebook. Unlike others with this kind
> of notebook, I had no problems under Windows yet, though I use Windows
> only for gaming once in a while.   

You can try the latest -rc kernel with the final patches from
http://bugzilla.kernel.org/show_bug.cgi?id=7122

It may be related.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
