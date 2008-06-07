From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: PTS ordering / asus P1-AH2 system
Date: Sat, 7 Jun 2008 11:22:10 +0100
Message-ID: <200806071122.10951.carlos@strangeworlds.co.uk>
References: <20080607040650.GA21015@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:54375 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642AbYFGKWV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jun 2008 06:22:21 -0400
In-Reply-To: <20080607040650.GA21015@zoy.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michel Lespinasse <walken@zoy.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

(Adding Rafael to CC)

On Saturday 07 June 2008 05:06:50 Michel Lespinasse wrote:
> I am wondering, are there patches for 2.6.25.* or 2.6.26-rc* to
> work around the suspend/resume PTS ordering issue, even using
> a kernel parameter if needed ?

See Rafael's patches here: 
http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.26-rc3/patches/

(They apply fine to the latest 2.6.26 git, and should hit mainline in 2.6.27)

You'll need to boot with acpi_sleep=old_ordering to test.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
