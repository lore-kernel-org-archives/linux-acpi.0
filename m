From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: ACPI buttons in 2.6.12-rc4-mm2
Date: Fri, 29 Jul 2005 12:35:43 -0400
Message-ID: <42EA5ADF.9000202@tmr.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300428C952@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262656AbVG2Qfv@vger.kernel.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300428C952@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Brown, Len wrote:
> I agree that the value of _LID can be usefult to user-space
> and I'll be sure it is restored as a property of the lid device
> under sysfs -- available as a simple file read like it
> was under /proc.

You're missing the point, removing the /proc feature breaks existing 
code. You can add new features in /sys as you like, but when you remove 
existing featires you break system for no benefit.
