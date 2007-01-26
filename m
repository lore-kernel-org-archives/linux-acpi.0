From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/7] asus-laptop: add base driver
Date: Fri, 26 Jan 2007 02:56:20 -0500
Message-ID: <200701260256.21073.lenb@kernel.org>
References: <200701251254.36495.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54556 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030810AbXAZIDm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 03:03:42 -0500
In-Reply-To: <200701251254.36495.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On Thursday 25 January 2007 06:54, Corentin CHARY wrote:
> Add the new driver and make ASUS_LAPTOP and ACPI_ASUS incompatible.
> It may be strange to use ASUS_CREATE_DEVICE_ATTR and 
> ASUS_SET_DEVICE_ATTR now, but these macro will be very usefull in next
> patchs.
> ASUS_HANDLE and ASUS_HANDLE_INIT come from IBM_HANDLE and IBM_HANDLE_INIT,
> with some modification, and will also be used in next patchs.
> 

>  misc/asus-laptop.c |  530 +++++++++++++++++++++++++++++++++++++++++++++++++++++

Adds trailing whitespace. line 446
