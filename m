From: John Belmonte <john@neggie.net>
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs	namespace
Date: Sat, 10 Apr 2004 01:31:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <407786C6.7030706@neggie.net>
References: <1081453741.3398.77.camel@patsy.fc.hp.com>	 <1081549317.2694.25.camel@patsy.fc.hp.com>  <4077535D.6020403@neggie.net> <1081566768.2562.8.camel@wilson.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1081566768.2562.8.camel@wilson.home.net>
To: Alex Williamson <alex.williamson@hp.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Alex Williamson wrote:
> On Fri, 2004-04-09 at 19:52, John Belmonte wrote:
> 
>>The limitation of this interface is that it's not able to call an ACPI 
>>method with some arguments and get the return value, correct?
> 
>    Yes, that's unfortunately a limitation.  Most of the standard
> interfaces either take no parameters or have no return value, so they
> fit nicely into this framework.  I'm open to suggestions on how to work
> around this.  We could make the store function save off the method
> parameters, then the show function would call the method with the saved
> parameters and return the results.  Obviously there are some userspace
> ordering issues that could make this complicated, but it's easy to code
> on the kernel side.  Other ideas?  Thanks,

You may want to look at the acpi-devel thread "[rfc] generic testing 
ACPI module", where this issue was discussed 
(http://sourceforge.net/mailarchive/message.php?msg_id=7455349).

-John


-- 
http:// if  ile.org/
