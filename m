From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Thu, 24 Mar 2011 13:58:37 +0100
Message-ID: <1300971517.3807.17.camel@jlt3.sipsolutions.net>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
	 <201103160732.15488.oldium.pro@seznam.cz>
	 <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
	 <201103202109.53484.oldium.pro@seznam.cz>
	 <4D87D082020000230002A29F@novprvlin0050.provo.novell.com>
	 <1300707796.4052.7.camel@jlt3.sipsolutions.net>
	 <4D87F3F9020000230002A2CA@novprvlin0050.provo.novell.com>
	 <1300718135.4052.14.camel@jlt3.sipsolutions.net>
	 <4D881693020000230002A2FC@novprvlin0050.provo.novell.com>
	 <1300882647.3790.17.camel@jlt3.sipsolutions.net>
	 <4D8B86FC020000230002A543@novprvlin0050.provo.novell.com>
	 <1300955725.3807.5.camel@jlt3.sipsolutions.net>
	 <4D8BD9E4020000230002A575@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D8BD9E4020000230002A575@novprvlin0050.provo.novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, oldium.pro@seznam.cz, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,


> > So it _does_ store the state? I thought you earlier said it didn't store
> > it, and when you cold rebooted it was always disabled?
> > 
> 
> There have 2 different behavior on Acer BIOS:
>  - cold boot (shutdown then power on): BIOS will reset to raw state (WLAN on, BT off, WWAN on)
>  - warm boot (reboot): BIOS will keep last time's state

Yeah but in that case I don't really see the point in making it
persistent. It's not really persistent anyway, warm reboot just means it
was stuck somewhere in memory I guess... I'd not call this persistent,
and making it not persistent also solves the problem, right?

johannes
