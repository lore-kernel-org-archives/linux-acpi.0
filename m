From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Mon, 24 Apr 2006 10:51:27 -0400
Message-ID: <d120d5000604240751y7501d376p62904e149ccbf4b3@mail.gmail.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD13787F2@pdsmsx411.ccr.corp.intel.com>
	 <20060420215549.GA2352@ucw.cz>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:61170 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750753AbWDXOv2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2006 10:51:28 -0400
Received: by nz-out-0102.google.com with SMTP id 40so987917nzk
        for <linux-acpi@vger.kernel.org>; Mon, 24 Apr 2006 07:51:27 -0700 (PDT)
In-Reply-To: <20060420215549.GA2352@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Yu, Luming" <luming.yu@intel.com>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Xavier Bestel <xavier.bestel@free.fr>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 4/20/06, Pavel Machek <pavel@ucw.cz> wrote:
> Having EV_ACPI might make sense for thermal/battery events, but not
> for normal keys.

No, I do not want EV_ACPI at all. If it does not map to standard
key/button/switch abstraction it really does not belong in input
layer. There could be a "battery" or "power" layers providing
abstraction for ACPI/APM/whateverfor that kind of stuff, but not input
layer.

But KEY_SLEEP, KEY_POWER, etc are more than welcome.

--
Dmitry
