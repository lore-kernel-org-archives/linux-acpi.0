From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode mails.
Date: Fri, 18 Jan 2008 23:40:39 -0500
Message-ID: <200801182340.39346.lenb@kernel.org>
References: <20071013174835.GF18760@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37176 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761839AbYASElU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 23:41:20 -0500
In-Reply-To: <20071013174835.GF18760@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 13 October 2007 13:48, Dave Jones wrote:
> The last month or so, we've seen lots of people posting
> their dmidecode output here (in response to seeing requests
> for it in dmesg, if their BIOS requests _OSI(Linux) I guess)
> 
> I'm wondering if anyone is actually looking at these, because
> I don't think I've seen a single follow up to any of them.

I plan to follow up on every one of them -- just
that until today, there always seemed to be something more urgent:-)

> Given we're about to do a Fedora release with this printk,
> I'm contemplating removing it, because we're going to be
> getting them for a long time after upstream removed the printk
> otherwise.  Unless someone sees value in continuing to get
> the reports ?

Either way is fine with me -- the e-mail will
come directly here rather than to the fedora project.

The latest code is smarter -- not asking for stuff it already
knows about (big DMI list on the way)
and printing directly to dmesg rather than asking
for dmidecode output.
I'll send the latest code to .25-rc8 and also .23-stable,
but .22 will be as it always was.

So far, I've found that this hook is usually a NOP,
but the cases where it is not are important.

We have to get rid of it, so slogging through the escapes
to see where the problems are really can't be avoided.

thanks,
-Len


