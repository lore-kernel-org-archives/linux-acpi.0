From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH resend] ACPI / PNP: constify device IDs
Date: Tue, 05 Jan 2016 13:58:33 +0100
Message-ID: <7062442.hJxWv2aY9W@vostro.rjw.lan>
References: <1451730609-2722-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65255 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751608AbcAEM1x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2016 07:27:53 -0500
In-Reply-To: <1451730609-2722-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathias Krause <minipli@googlemail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Saturday, January 02, 2016 11:30:09 AM Mathias Krause wrote:
> Instead of re-creating the array on the stack each time
> is_cmos_rtc_device() gets called, make the array 'static const'.
> 
> Signed-off-by: Mathias Krause <minipli@googlemail.com>

Applied, thanks!

Rafael

