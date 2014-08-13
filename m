From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/2] USB: Use ACPI device information
Date: Thu, 14 Aug 2014 06:03:09 +0800
Message-ID: <20140813220309.GE7908@kroah.com>
References: <1407950132-15863-1-git-send-email-sameo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51055 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbaHMWDo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Aug 2014 18:03:44 -0400
Content-Disposition: inline
In-Reply-To: <1407950132-15863-1-git-send-email-sameo@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Faouaz TENOUTIT <faouaz.tenoutit@intel.com>

On Wed, Aug 13, 2014 at 07:15:31PM +0200, Samuel Ortiz wrote:
> From: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> 
> Use ACPI device pld information instead of calling
> acpi_get_physical_device_location.

Why?  What does this do "better" than the existing code?


thanks,

gre gk-h
