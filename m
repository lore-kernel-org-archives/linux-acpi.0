From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 16:14:40 -0500
Message-ID: <d120d5000601091314g7cef73fk445976b14c549a04__21647.327199071$1138783004$gmane$org@mail.gmail.com>
References: <3ACA40606221794F80A5670F0AF15F840AA37137@pdsmsx403>
	 <20060109014350.GA672@srcf.ucam.org>
	 <200601091019.01083.luming.yu@intel.com>
	 <20060109023037.GA1316@srcf.ucam.org>
	 <1136801040.19776.34.camel@localhost>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:41427 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750751AbWAIVOl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Jan 2006 16:14:41 -0500
Received: by zproxy.gmail.com with SMTP id x7so3906849nzc
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2006 13:14:41 -0800 (PST)
In-Reply-To: <1136801040.19776.34.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Yu Luming <luming.yu@intel.com>, linux-acpi@vger.kernel.org, gnome-power-manager-list@gnome.org, desktop_portables@lists.osdl.org

On 1/9/06, Richard Hughes <hughsient@gmail.com> wrote:
>
> * All ACPI keyboard events would come through /proc/acpi/event as hkey's
> * You could change the brightness on *any* lcdpanel by doing a simple
>  #echo 3 > /proc/acpi/video/brightness
> * You could get the number of brightness levels supported doing
>  #cat /proc/acpi/video/brightness_levels
>

And what do you do if:

1. You don't have ACPI available (other platforms)
2. APM works better for some reason
3. The hotkey (sleep, power, etc) does not come from ACPI?

--
Dmitry
