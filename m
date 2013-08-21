From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: bgrt: take advantage of binary sysfs groups
Date: Wed, 21 Aug 2013 14:51:40 +0200
Message-ID: <3825729.FGg1e4OV3U@vostro.rjw.lan>
References: <20130821001149.GA16350@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53237 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab3HUMlI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Aug 2013 08:41:08 -0400
In-Reply-To: <20130821001149.GA16350@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, August 20, 2013 05:11:49 PM Greg KH wrote:
> From: Greg KH <gregkh@linuxfoundation.org>
> 
> Attribute groups now can handle binary sysfs attributes, so clean up the
> code here by using a binary attribute array.  This saves us the extra
> call to create the binary attribute at saves 6 lines overall.
> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

