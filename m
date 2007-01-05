From: Len Brown <lenb@kernel.org>
Subject: Sony Vaio VGN-SZ340 (was Re: sonypc with Sony Vaio VGN-SZ1VP)
Date: Fri, 5 Jan 2007 12:11:08 -0500
Message-ID: <200701051211.08458.lenb@kernel.org>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <20070104154434.7e1a7c83.akpm@osdl.org> <7ce7bf330701041820l5132ddbfsd3dd2b6ea826f3ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161171AbXAERMK@vger.kernel.org>
In-Reply-To: <7ce7bf330701041820l5132ddbfsd3dd2b6ea826f3ae@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: MoRpHeUz <morpheuz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
List-Id: linux-acpi@vger.kernel.org

On Thursday 04 January 2007 21:20, MoRpHeUz wrote:
> Hi,
> 
>   I own a Sony Vaio VGN-SZ340 and I had problems regarding acpi + it's
> dual core processor. The guys from Intel gave me a workaround and now
> it recognises both cores.

What workaround are you using?

>   The problem is that it does not do cpu frequency scaling for both
> cores, just for cpu0...And when I boot with acpi the Nvidia graphic
> card doesnt work also.
> 
>   I don't know if you know about these problems regarding sony acpi.
> The guys from Intel said that this notebook have 2 dst's. So to detect
> both cores the workaround just uses the second dst (although frequency
> scaling does work for both.)
> 
>   I can help you to fix this bug...I have the machine where we can do
> some tests..

The frequency scaling issue sounds like a BIOS/Linux incompatibility.
Please open a bugzilla, if you haven't already, and include the
output from acpidump.

The nvidia issue sounds like an interrupt issue, so please reproduce
it using the open source nvidia driver (not the nvidia binary),
and include the lspci -vv output, dmesg, and /proc/interrupts.

thanks,
-Len
