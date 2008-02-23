From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.24 Temperature/speed _not_ normal - no thermal throttling?
Date: Fri, 22 Feb 2008 23:33:23 -0500
Message-ID: <200802222333.23160.lenb@kernel.org>
References: <47BBC627.8020907@fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37447 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbYBWEdi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2008 23:33:38 -0500
In-Reply-To: <47BBC627.8020907@fnal.gov>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ron Rechenmacher <ron@fnal.gov>
Cc: linux-acpi@vger.kernel.org

On Wednesday 20 February 2008 01:18, Ron Rechenmacher wrote:
> my dell d830 laptop seems to over heat and hang.

Ron,
see "Thermal Issues" here:

http://www.lesswatts.org/projects/acpi/debug.php

My guess is that ACPI (and thus Linux) have no control over
the fans on this system (as I've never seen a Dell with
OS controlled fans)  If the fans are spinning fast when you
heat up the machine, then they are probably clogged with dust
or there a mechanical issue with the thermal solution.

cheers,
-Len

