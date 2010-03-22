From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [patch] power_meter: acpi_device_class "power_meter_resource"
	too long
Date: Mon, 22 Mar 2010 11:13:27 -0700
Message-ID: <20100322181327.GG22820@tux1.beaverton.ibm.com>
References: <20100319114920.GP5331@bicker>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35032 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359Ab0CVSNa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Mar 2010 14:13:30 -0400
Content-Disposition: inline
In-Reply-To: <20100319114920.GP5331@bicker>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, =?iso-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Lin Ming <ming.m.lin>

On Fri, Mar 19, 2010 at 02:49:20PM +0300, Dan Carpenter wrote:
> acpi_device_class can only be 19 characters and a NULL terminator.
> 
> The current code has a buffer overflow in acpi_power_meter_add():
>        strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> Feel free to change the name to anything you like.

How hard would it be to increase the size of that buffer?

(Or, is there a need to have "_resource" in that string at all?)

--D
