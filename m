From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 21:56:52 +0000
Message-ID: <20060420215652.GB2352@ucw.cz>
References: <20060419195356.GA24122@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56332 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750974AbWDVTQG
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Apr 2006 15:16:06 -0400
Content-Disposition: inline
In-Reply-To: <20060419195356.GA24122@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> Sleep and power buttons are logically part of the keyboard, and it makes 
> for them to be exposed via an input device rather than an odd file in 
> /proc. This patch adds a keycode for lid switches (are we running out of 
> keycodes?) and allows the button driver to register an input device.

Yes, please. This is actually long overdue.

								Pavel

-- 
Thanks, Sharp!
