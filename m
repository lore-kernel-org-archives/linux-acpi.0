From: Benoit Izac <benoit.izac@free.fr>
Subject: Re: [PATCH 1/2] toshiba-acpi: Add support for hotkey notifications
Date: Sun, 12 Apr 2009 01:06:31 +0200
Message-ID: <w53zlem3i4o@message.id>
References: <20090331214501.GC29489@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lns-bzn-51f-62-147-243-137.adsl.proxad.net ([62.147.243.137]:39043
	"EHLO wok.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756502AbZDKXRj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Apr 2009 19:17:39 -0400
In-Reply-To: <20090331214501.GC29489@srcf.ucam.org> (Matthew Garrett's message of "Tue\, 31 Mar 2009 22\:45\:01 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On 31/03/2009 at 23:45, Matthew Garrett wrote in message
<20090331214501.GC29489@srcf.ucam.org>:

> Calling the ENAB method on Toshiba laptops results in notifications being
> sent when laptop hotkeys are pressed. This patch simply calls that method
> and sets up an input device if it's successful.

Hi,

On my Toshiba Tecra M9, when I press ``FN'' key (needed to access
hotkeys), an event occurs with code 224 (decimal). How do you
distinguish it from KEY_BRIGHTNESSDOWN?

-- 
Benoit Izac
