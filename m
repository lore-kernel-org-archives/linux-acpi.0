From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] [-mm] ACPI: export ACPI events via netlink
Date: Sun, 27 May 2007 17:40:53 +0800
Message-ID: <1180258853.7707.53.camel@localhost.localdomain>
References: <1179827251.7707.29.camel@localhost.localdomain>
	 <1179831825.4121.30.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1179831825.4121.30.camel@localhost>
Sender: netdev-owner@vger.kernel.org
To: hadi@cyberus.ca
Cc: linux-acpi@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2007-05-22 at 07:03 -0400, jamal wrote:
> Hi Zhang Rui,
> 
> Really cool stuff. Can you instead use genetlink?
> http://linux-net.osdl.org/index.php/Generic_Netlink_HOWTO 
> should help. And if you have more questions post on netdev (not lk).
> 
Yes, I have one now. :)
I need to write a user application to test my patch.
Netlink messages can be sent/received using the standard socket API.
But how to receive Genetlink messages from specified genetlink family?
There is no socket ACPI with such a parameter, right?
Do I have to receive all the genetlink messages first?
It would be great if there are any examples on user space communication.

Or should I use libnl library instead?

Thanks,
Rui.
