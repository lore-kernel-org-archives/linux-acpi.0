From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Allow userspace do something special on overtemp
Date: Thu, 12 Aug 2004 08:16:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040812081634.532e3fc7.rddunlap@osdl.org>
References: <20040811085326.GA11765@elf.ucw.cz>
	<1092323945.5028.177.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268594AbUHLPis@vger.kernel.org>
In-Reply-To: <1092323945.5028.177.camel@dhcppc4>
To: Len Brown <len.brown@intel.com>
Cc: pavel@suse.cz, trenn@suse.de, seife@suse.de, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On 12 Aug 2004 11:19:05 -0400 Len Brown wrote:

| Simpler to delete the usermode call and rely on the (flexible)
| acpid event, yes?
| 
|  thermal.c |   29 +----------------------------
|  1 files changed, 1 insertion(+), 28 deletions(-)

a.  Yes, it should be more flexible than just 'overtemp'.

b.  For userspace, there are:

acpid -  http://sourceforge.net/projects/acpid/

acpi tools, like ospmd (by Andy Grover) - in CVS at
  http://sourceforge.net/projects/acpi/

What others are there?

And ospmd (at least) needs some care.  Andy wanted to give it up
1 or 2 years ago, so I took it over for awhile.  However, it
still needs more care, so if anyone out there wants to maintain it,
please speak up.

--
~Randy
