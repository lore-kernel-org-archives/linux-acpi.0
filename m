From: Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] [PATCH] can we compile ACPI without define CONFIG_PM ?
Date: 07 May 2004 00:18:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1083903538.2296.248.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F9FD0@hdsmsx403.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S262896AbUEGETN@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F9FD0@hdsmsx403.hd.intel.com>
To: sergiomb@netcabo.pt
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Never occurred to me to build ACPI w/o CONFIG_PM...
There are #ifdef CONFIG_PM in the acpi code, so I guess this was on
purpose, but it makes ACPI a lot less interesting.

But I'm inclined to leave 2.4 alone except for real system failures. 
The only clean-up I'm really interested in doing in 2.4 is when it makes
maintenance via backporting from 2.6 easier.

-Len
