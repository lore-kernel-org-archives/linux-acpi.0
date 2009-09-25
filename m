From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ACPI: New driver for Lenovo SL laptops
Date: Thu, 24 Sep 2009 21:34:41 -0700
Message-ID: <20090925043441.GE416@core.coreip.homeip.net>
References: <1253805163-12493-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:37560 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbZIYEel (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2009 00:34:41 -0400
Content-Disposition: inline
In-Reply-To: <1253805163-12493-1-git-send-email-ike.pan@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Rostovtsev <tetromino@gmail.com>

On Thu, Sep 24, 2009 at 11:12:43PM +0800, Ike Panhc wrote:
> +
> +static void hkey_inputdev_exit(void)
> +{
> +	if (hkey_inputdev) {
> +		input_unregister_device(hkey_inputdev);
> +		input_free_device(hkey_inputdev);

input_free_device() should not be called after input_unregister_device().

-- 
Dmitry
