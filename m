From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: use NULL for pointer
Date: Wed, 6 Jun 2007 15:57:53 +0900
Message-ID: <20070606065753.GH6314@inferi.kami.home>
References: <20070605214332.6aceb2ec.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi16.ns.itscom.net ([219.110.2.186]:58477 "EHLO
	mtoichi16.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbXFFG6J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jun 2007 02:58:09 -0400
Content-Disposition: inline
In-Reply-To: <20070605214332.6aceb2ec.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, akpm <akpm@linux-foundation.org>

On Tue, Jun 05, 2007 at 09:43:32PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Use NULL instead of 0 for pointer:
> drivers/misc/sony-laptop.c:1920:6: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Mattia Dongili <malattia@linux.it>


-- 
mattia
:wq!
